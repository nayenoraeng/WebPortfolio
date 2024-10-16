-- 삭제 필요할때 
drop table board;
drop table inquiryBoard;
drop table noticeBoard;
DELETE FROM inquiryBoard;
drop table member;

DROP SEQUENCE board_seq;
DROP SEQUENCE InquiryBoard_seq;
DROP SEQUENCE noticeBoard_seq;


alter session set "_ORACLE_SCRIPT"=true;

create user PROJECT identified by 1234;

--테이블 스페이스 권한 주기
grant connect, resource, unlimited tablespace to PROJECT;
--테이블 스페이스 리스트 확인
select tablespace_name, status, contents from dba_tablespaces;
--테이블스페이스에 용량 확인
select tablespace_name, sum(bytes), max(bytes) from dba_free_space group by tablespace_name;
--개인 계정이 어느 테이블스페이스에 들어있는지 확인
select username, default_tablespace from dba_users where username in upper('PROJECT');

--PROJECT계정에 users 테이블 스페이스에 데이터를 입력할 수 있도록 5m의 용량 할당
alter user PROJECT quota 5m on users;

-------------------------------------------------------------멤버게시판
CREATE TABLE member (
  id varchar2(100),
  pass varchar2(100) ,
  name varchar2(50) ,
  phoneNum varchar2(20),
  email varchar2(50) ,
  postcode varchar(10) ,
  address varchar2(200) ,
  detailaddress varchar2(200) ,
  regidate Date DEFAULT SYSDATE ,
  authority varchar2(20) default 'ROLE_USER',
  enabled number(1) default 1,
  provider varchar2(20) default 'LOCAL',
  providerId varchar2 (100),
  isLock  NUMBER(1) DEFAULT 1,
  failCount NUMBER DEFAULT 0,
  lockTime TIMESTAMP
  primary key(id)
);

ALTER TABLE member

insert into member (id, pass, name, phoneNum, email, postcode, address, detailaddress)
    values ('test1', '$2a$10$vIxaMNqXvsQnHIHgk7mXPu071T7Qo7YjWaH2p/0kfYLK6B2QRwHMm', '홍길동', '010-000-0000', 'asdf@asdf.com', '10414', '경기도 고양시 일산동구 00로', '학원');
insert into member (id, pass, name, phoneNum, email, postcode, address, detailaddress)
    values ('test2', '$2a$10$vIxaMNqXvsQnHIHgk7mXPu071T7Qo7YjWaH2p/0kfYLK6B2QRwHMm', '홍길동', '010-000-0000', 'asdf@asdf.com', '10414', '경기도 고양시 일산동구 00로', '학원');
insert into member (id, pass, name, phoneNum, email, postcode, address, detailaddress)
    values ('test3', '$2a$10$vIxaMNqXvsQnHIHgk7mXPu071T7Qo7YjWaH2p/0kfYLK6B2QRwHMm', '홍길동', '010-000-0000', 'asdf@asdf.com', '10414', '경기도 고양시 일산동구 00로', '학원');
insert into member (id, pass, name, phoneNum, email, postcode, address, detailaddress)
    values ('test4', '$2a$10$vIxaMNqXvsQnHIHgk7mXPu071T7Qo7YjWaH2p/0kfYLK6B2QRwHMm', '홍길동', '010-000-0000', 'asdf@asdf.com', '10414', '경기도 고양시 일산동구 00로', '학원');
insert into member (id, pass, name, phoneNum, email, postcode, address, detailaddress)
    values ('test5', '$2a$10$vIxaMNqXvsQnHIHgk7mXPu071T7Qo7YjWaH2p/0kfYLK6B2QRwHMm', '홍길동', '010-000-0000', 'asdf@asdf.com', '10414', '경기도 고양시 일산동구 00로', '학원');
insert into member (id, pass, name, phoneNum, email, postcode, address, detailaddress)
    values ('test6', '$2a$10$vIxaMNqXvsQnHIHgk7mXPu071T7Qo7YjWaH2p/0kfYLK6B2QRwHMm', '홍길동', '010-000-0000', 'asdf@asdf.com', '10414', '경기도 고양시 일산동구 00로', '학원');
insert into member (id, pass, name, phoneNum, email, postcode, address, detailaddress)
    values ('admin', '$2a$10$vIxaMNqXvsQnHIHgk7mXPu071T7Qo7YjWaH2p/0kfYLK6B2QRwHMm', '홍길동', '010-000-0000', 'asdf@asdf.com', '10414', '경기도 고양시 일산동구 00로', '학원');


desc member; 

UPDATE member SET authority='ROLE_ADMIN' WHERE ID='admin';


--멤버게시판 테이블 삭제
drop table member;

commit;

-------------------------------------------------------------멤버게시판

-------------------------------------------------------------정보게시판

--정보게시판 테이블
create table board (
    idx number(6) not null,
    id varchar2(50) not null,
    title varchar2(50) not null,
    content varchar2(1000) not null,
    postdate Date default sysdate not null,
    viewCount number(6) default 0 not null,
    likeCount number(6) default 0 not null,
    ofile varchar2(200), 
	sfile varchar2(100),
    isAnnouncement varchar2(1) default 'N' not null,
    primary key(idx)
);
--정보게시판 댓글테이블
create table boardInfoComment (
    cIdx number(6) primary key, -- 댓글 인덱스 번호
    writer VARCHAR2(50), -- 댓글 작성자 아이디
    commentText VARCHAR2(500), --댓글 내용
    refGroup number(6), -- 원글 번호
    commentGroup number(6), -- 댓글 그룹 번호
    deleted number default 0, -- 지워진 댓글 여부 1:yes 0 no
    regidate date default SYSDATE
);

desc board;

--정보게시판 외래키 설정
alter table board
    add constraint board_mem_fk foreign key (id)
    references member(id);

--정보게시판 댓글테이블 외래키 설정
alter table boardInfoComment
    add constraint boardInfoComm_ref_fk foreign key (refGroup)
    references board(idx);

--정보게시판 시퀀스
create sequence board_seq
    increment by 1  -- 1식 증가
    start with 1    -- 시작값 1
    minvalue 1      -- 최소값 1
    nomaxvalue      -- 최대값은 무한대
    nocycle         -- 순환 x
    nocache;        -- 캐시 사용 안함
--정보게시판 댓글 시퀀스
create sequence boardInfoComment_seq
    increment by 1  -- 1식 증가
    start with 1    -- 시작값 1
    minvalue 1      -- 최소값 1
    nomaxvalue      -- 최대값은 무한대
    nocycle         -- 순환 x
    nocache;        -- 캐시 사용 안함
    
--정보게시판 테이블 삭제
drop table board;
--정보게시판 시퀀스 삭제
DROP SEQUENCE board_seq;

insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test1', '자료실 제목1 입니다.', '내용', sysdate, 'Y');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test1', '자료실 제목2 입니다.', '내용', sysdate, 'Y');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test1', '자료실 제목4 입니다.','내용', sysdate, 'Y');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test1', '자료실 제목3 입니다.','내용', sysdate, 'Y');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test1', '자료실 제목5 입니다.','내용', sysdate, 'Y');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test1', '자료실 제목6 입니다.','내용', sysdate, 'Y');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test2', '자료실 제목7 입니다.','내용', sysdate, 'Y');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test2', '자료실 제목8 입니다.','내용', sysdate, 'N');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test2', '자료실 제목9 입니다.','내용', sysdate, 'N');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test2', '자료실 제목10 입니다.','내용', sysdate, 'N');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test2', '자료실 제목11 입니다.','내용', sysdate, 'N');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test2', '자료실 제목12 입니다.','내용', sysdate, 'N');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test2', '자료실 제목13 입니다.','내용', sysdate, 'N');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test3', '자료실 제목14 입니다.','내용', sysdate, 'N');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test3', '자료실 제목15 입니다.','내용', sysdate, 'N');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test3', '자료실 제목16 입니다.','내용', sysdate, 'N');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test3', '자료실 제목17 입니다.','내용', sysdate, 'N');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test3', '자료실 제목18 입니다.','내용', sysdate, 'N');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test3', '자료실 제목19 입니다.','내용', sysdate, 'N');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test4', '자료실 제목20 입니다.','내용', sysdate, 'N');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test4', '자료실 제목21 입니다.','내용', sysdate, 'N');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test4', '자료실 제목22 입니다.','내용', sysdate, 'N');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test5', '자료실 제목23 입니다.','내용', sysdate, 'N');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test5', '자료실 제목24 입니다.','내용', sysdate, 'N');
insert into board (idx, id, title, content, postdate, isAnnouncement)
    values (board_seq.nextval, 'test6', '자료실 제목25 입니다.','내용', sysdate, 'N');
    
commit;

-------------------------------------------------------------정보게시판

-------------------------------------------------------------공지사항게시판

--공지사항 게시판 테이블
create table noticeBoard (
    idx number(6) not null,
    id varchar2(50) not null,
    title varchar2(50) not null,
    content varchar2(1000) not null,
    postdate Date default sysdate not null,
    viewCount number(6) default 0 not null,
    likeCount number(6) default 0 not null,
    ofile varchar2(200),
    sfile varchar2(200),
    primary key(idx)
);

--공지사항 게시판 댓글 테이블
create table noticeComment (
    coidx number(6) not null, --댓글테이블 번호 pk
    idx number(6) not null, --공지사항테이블과 연결 되는 게시글 번호fk
    id varchar2(50) not null, --멤버 테이블과 연결 fk
    content varchar2(1000) not null, --내용
    postdate Date default sysdate not null, --댓글게시일
    modifydate Date,
    primary key(coidx)
);

desc noticeBoard;

--공지사항게시판 외래키 설정
alter table noticeBoard
    add constraint board_noti_fk foreign key (id)
    references member(id);

--공지사항게시판 댓글 외래키 설정1
alter table noticeComment
    add constraint cfk1
    foreign key (idx) references noticeBoard(idx) on delete cascade;

--외래키 제약조건 삭제
alter table noticeComment drop constraint cfk1;

    
--공지사항게시판 시퀀스
create sequence noticeBoard_seq
    increment by 1  -- 1식 증가
    start with 1    -- 시작값 1
    minvalue 1      -- 최소값 1
    nomaxvalue      -- 최대값은 무한대
    nocycle         -- 순환 x
    nocache;

--댓글게시판 시퀀스
create sequence noticeComment_seq
    increment by 1  -- 1식 증가
    start with 1    -- 시작값 1
    minvalue 1      -- 최소값 1
    nomaxvalue      -- 최대값은 무한대
    nocycle         -- 순환 x
    nocache;

--공지사항 게시판 더미데이터
insert into noticeBoard (idx, id, title, content, postdate)values (noticeBoard_seq.nextval, 'admin', '안녕하세요', '행복하세요', sysdate);
insert into noticeBoard (idx, id, title, content, postdate)values (noticeBoard_seq.nextval, 'admin', '안녕하세요', '행복하세요', sysdate);
insert into noticeBoard (idx, id, title, content, postdate)values (noticeBoard_seq.nextval, 'admin', '안녕하세요', '행복하세요', sysdate);
insert into noticeBoard (idx, id, title, content, postdate)values (noticeBoard_seq.nextval, 'admin', '안녕하세요', '행복하세요', sysdate);
insert into noticeBoard (idx, id, title, content, postdate)values (noticeBoard_seq.nextval, 'admin', '안녕하세요', '행복하세요', sysdate);
insert into noticeBoard (idx, id, title, content, postdate)values (noticeBoard_seq.nextval, 'admin', '안녕하세요', '행복하세요', sysdate);
insert into noticeBoard (idx, id, title, content, postdate)values (noticeBoard_seq.nextval, 'admin', '안녕하세요', '행복하세요', sysdate);
insert into noticeBoard (idx, id, title, content, postdate)values (noticeBoard_seq.nextval, 'admin', '안녕하세요', '행복하세요', sysdate);
insert into noticeBoard (idx, id, title, content, postdate)values (noticeBoard_seq.nextval, 'admin', '안녕하세요', '행복하세요', sysdate);
insert into noticeBoard (idx, id, title, content, postdate)values (noticeBoard_seq.nextval, 'admin', '안녕하세요', '행복하세요', sysdate);
insert into noticeBoard (idx, id, title, content, postdate)values (noticeBoard_seq.nextval, 'admin', '안녕하세요', '행복하세요', sysdate);
insert into noticeBoard (idx, id, title, content, postdate)values (noticeBoard_seq.nextval, 'admin', '안녕하세요', '행복하세요', sysdate);
insert into noticeBoard (idx, id, title, content, postdate)values (noticeBoard_seq.nextval, 'admin', '안녕하세요', '행복하세요', sysdate);


--댓글게시판 더미 데이터
insert into noticeComment (coidx, idx, id, content)values (noticeComment_seq.nextval, 1, 'test3', '첫번째 댓글 입니다.');
insert into noticeComment (coidx, idx, id, content)values (noticeComment_seq.nextval, 2, 'test4', '첫번째 댓글 입니다.');
insert into noticeComment (coidx, idx, id, content)values (noticeComment_seq.nextval, 13, 'test5', '테스트');
--댓글게시판 테이블 삭제
drop table noticeComment;
--댓글게시판 시퀀스 삭제
DROP SEQUENCE noticeComment_seq;

--공지사항게시판 테이블 삭제
drop table noticeBoard;
--공지사항게시판 시퀀스 삭제
DROP SEQUENCE noticeBoard_seq;

commit;

-------------------------------------------------------------공지사항게시판

-------------------------------------------------------------문의사항게시판

--문의사항게시판 테이블
create table inquiryBoard (
    idx number(6) not null,
    parentIdx number(6) DEFAULT 0, --부모 글 번호
    id varchar2(50) not null,
    parentId varchar2(50),
    title varchar2(100) not null,
    content varchar2(1000) not null,
    postdate Date default sysdate not null,
    viewCount number(6) default 0 not null,
    responses number(6) default 0 not null,
    ofile varchar2(200),
	sfile varchar2(300),
    isAnnouncement varchar2(1) not null,
    boardPass  varchar2(20) not null,
    primary key(idx)
);

--문의사항게시판 외래키
alter table inquiryBoard
    add constraint board_inquiry_fk foreign key (id)
    references member(id);
    
--문의사항게시판 시퀀스
create sequence inquiryBoard_seq
    increment by 1  -- 1식 증가
    start with 1    -- 시작값 1
    minvalue 1      -- 최소값 1
    nomaxvalue      -- 최대값은 무한대
    nocycle         -- 순환 x
    nocache;        -- 캐시 사용 안함

--문의게시판 더미데이터
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '정보 문의합니다.', '교통약자 화장실 정보를 추가하고 싶은데 어디에 말하면 될까요??', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '채팅 상담 문의합니다.', '채팅 상담 중에 오류가 나서 연결이 끊겼습니다. 다시 문의 드리겠습니다.', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '승장장 정보', '현재 **역 지하철 승강장이 공사중이라 사용을 못합니다 정보 업데이트 부탁드립니다~', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '게시판 문의드립니다.', '문의글 게시판을 보려고 하는데 게시글 비밀번호를 변경하고 싶어요.. 다른 방법 있을까요?', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '답변 부탁드려요.', '홈페이지 정보는 어디서 얻어 오는 걸까요?', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '비밀번호 문의', '비밀번호 변경하고 싶은데 가능한가요?', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '정보 문의합니다.', '교통약자 화장실 정보를 추가하고 싶은데 어디에 말하면 될까요??', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '문의합니다. 답변 바랍니다.', '채팅 상담 중에 오류가 나서 연결이 끊겼습니다. 다시 문의 드리겠습니다.', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '승장장 정보', '현재 **역 지하철 승강장이 공사중이라 사용을 못합니다 정보 업데이트 부탁드립니다~', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '게시판 문의드립니다.', '문의글 게시판을 보려고 하는데 비밀번호를 잊어버렸어요. 다른 방법 있을까요?', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '회원가입 정보 변경 문의', '제 정보를 변경하고 싶은데 어디서 하면 될까요?', 'N', 1234);    
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '현재 홈페이지가 너무 마음에 들어요', '항상 감사합니다 좋은 사이트 만들어주셔서 감사합니다~', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '정보 문의.. 답변 해주세요', '교통약자 화장실 정보를 추가하고 싶은데 어디에 말하면 될까요??', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '답변 바랍니다.', '공지 사항 게시판은 일반 회원은 글쓰기가 불가한가요?', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '승장장 정보', '현재 **역 지하철 승강장이 공사중이라 사용을 못합니다 정보 업데이트 부탁드립니다~', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '정보 게시판 궁금합니다.', '정보 게시판은 비회원도 글쓰기가 가능한가요?', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '회원가입 정보', '제 정보를 변경하고 싶은데 어디서 하면 될까요?', 'N', 1234);


INSERT INTO inquiryBoard (idx, parentIdx, id, parentId, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 1, 'admin', 'test4', '	[답변]정보 문의합니다.', '안녕하세요 정보 추가를 원하시면 문의게시판에 정보를 적어 두시거나 채팅 상담을 통해 말씀해주시면 저희가 정보를 추가해놓겠습니다. 감사합니다.', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 1;
INSERT INTO inquiryBoard (idx, parentIdx, id, parentId, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 2, 'admin', 'test4', '	[답변]채팅 상담 문의합니다.', '안녕하세요. 채팅 상담 중 연결이 끊겨 불편하셨겠습니다. 죄송합니다. 인터넷 연결이 불안정 하시면 문의게시판을 이용해주시면 답변 해드리겠습니다.', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 2;
INSERT INTO inquiryBoard (idx, parentIdx, id, parentId, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 3, 'admin', 'test4', '	[답변]승장장 정보', '안녕하세요. 승강장 정보를 제공해주셔서 감사합니다. 정보는 확인 후 변경도와드리겠습니다. 감사합니다~', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 3;
INSERT INTO inquiryBoard (idx, parentIdx, id, parentId, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 4, 'admin', 'test4', '	[답변]게시판 문의드립니다.', '안녕하세요. 문의 게시판 비밀번호는 현재 로그인 후 게시글 수정하실때 변경이 가능합니다. 문제가 있으시면 문의게시판, 채팅상담을 이용해주세요', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 4;
INSERT INTO inquiryBoard (idx, parentIdx, id, parentId, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 5, 'admin', 'test4', '	[답변]답변 부탁드려요.', '안녕하세요. 현재 사용중인 정보는 서울특별시 복지건강본부에서 제공하는 정보로 혹시 이용 중 문제나 잘못된 정보가 있으면 문의게시판을 이용해주세요. 감사합니다.
    ', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 5;
INSERT INTO inquiryBoard (idx, parentIdx, id, parentId, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 6, 'admin', 'test4', '	[답변]비밀번호 문의', '안녕하세요. 현재 사용중인 로그인시 오른쪽 상단에 위치한 마이페이지에서 비밀번호 변경이 가능합니다.', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 6;
INSERT INTO inquiryBoard (idx, parentIdx, id, parentId, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 7, 'admin', 'test4', '	[답변]정보 문의합니다.', '안녕하세요 정보 추가를 원하시면 문의게시판에 정보를 적어 두시거나 채팅 상담을 통해 말씀해주시면 저희가 정보를 추가해놓겠습니다. 감사합니다.', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 7;
INSERT INTO inquiryBoard (idx, parentIdx, id, parentId, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 8, 'admin', 'test4', '	[답변]문의합니다. 답변 바랍니다.', '안녕하세요. 채팅 상담 중 연결이 끊겨 불편하셨겠습니다. 죄송합니다. 인터넷 연결이 불안정 하시면 문의게시판을 이용해주시면 답변 해드리겠습니다.', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 8;
INSERT INTO inquiryBoard (idx, parentIdx, id, parentId, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 9, 'admin', 'test4', '	[답변]승장장 정보', '안녕하세요. 승강장 정보를 제공해주셔서 감사합니다. 정보는 확인 후 변경도와드리겠습니다. 감사합니다~', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 9;
INSERT INTO inquiryBoard (idx, parentIdx, id, parentId, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 10, 'admin', 'test4', ' [답변]게시판 문의드립니다.', '안녕하세요. 문의 게시판 비밀번호는 현재 로그인 후 게시글 수정하실때 변경이 가능합니다. 문제가 있으시면 문의게시판, 채팅상담을 이용해주세요', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 10;
INSERT INTO inquiryBoard (idx, parentIdx, id, parentId, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 11, 'admin', 'test4', ' [답변]회원가입 정보 변경 문의', '안녕하세요. 현재 사용중인 로그인시 오른쪽 상단에 위치한 마이페이지에서 회원 정보 변경이 가능합니다.', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx =11;
INSERT INTO inquiryBoard (idx, parentIdx, id, parentId, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 12, 'admin', 'test4', ' [답변]현재 홈페이지가 너무 마음에 들어요', '안녕하세요. 저희 홈페이지를 사랑해주셔서 감사합니다.^^ 더욱더 발전해서 더 나은 정보 제공해드리겠습니다.', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx =12;
INSERT INTO inquiryBoard (idx, parentIdx, id, parentId, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 13, 'admin', 'test4', ' [답변]정보 문의.. 답변 해주세요.', '안녕하세요 정보 추가를 원하시면 문의게시판에 정보를 적어 두시거나 채팅 상담을 통해 말씀해주시면 저희가 정보를 추가해놓겠습니다. 감사합니다.', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 13;
INSERT INTO inquiryBoard (idx, parentIdx, id, parentId, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 14, 'admin', 'test4', ' [답변]답변 바랍니다.', '안녕하세요. 공지사항 게시판은 현재 일반 회원들은 댓글작성, 좋아요만 가능하며 글쓰기는 불가능 합니다. 혹시 필요하신 사항이나 홈페이지에 문제가 발생했다면 문의게시판, 채팅 상담을 이용해주시면 됩니다. 다른 회원분들에게 알리고 싶은 내용은 정보게시판을 이용해주세요. ^^', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 14;
INSERT INTO inquiryBoard (idx, parentIdx, id, parentId, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 15, 'admin', 'test4', ' [답변]승장장 정보', '안녕하세요. 승강장 정보를 제공해주셔서 감사합니다. 정보는 확인 후 변경도와드리겠습니다. 감사합니다~', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 15;
INSERT INTO inquiryBoard (idx, parentIdx, id, parentId, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 16, 'admin', 'test4', ' [답변]정보 게시판 궁금합니다.', '안녕하세요. 정보 게시판은 현재 일반 회원들은 일반 회원도 가능하며 로그인을 하셔야 글쓰기가 가능합니다. ^^ 다른 회원분들에게 알리고 싶은 내용은 정보게시판을 이용해주세요. ^^', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 16;
INSERT INTO inquiryBoard (idx, parentIdx, id, parentId, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 17, 'admin', 'test4', ' [답변]회원가입 정보', '[답변] 로그인 시 홈페이지 오른쪽 상단에 있는 마이페이지에 들어가면 회원 정보 변경이 가능합니다 ^^
또 추가 문의 사항있으시면 문의게시판이나 채팅상담에 문의 내용 적어주시면 답변 드리겠습니다 ~ 감사합니다 ', 'Y', 1234);
--update inquiryBoard SET responses=responses+1 where idx = 17;    

--문의사항게시판 테이블 삭제
drop table inquiryBoard;
--문의사항게시판 시퀀스 삭제
DROP SEQUENCE inquiryBoard_seq;

desc inquiryBoard;

commit;
























