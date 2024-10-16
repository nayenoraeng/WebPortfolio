select * from member;   
select * from inquiryBoard;

drop table board;
drop table member;
DROP SEQUENCE board_seq;

CREATE TABLE member (
    id varchar2(50) not null,
    pass varchar2(100) not null,
    name varchar2(50) not null,
    phoneNum varchar2(20) not null,
    email varchar2(50) not null,
    postcode varchar(10) not null,
    address varchar2(200) not null,
    detailaddress varchar2(200) not null,
    regidate Date DEFAULT SYSDATE not null,
    authority varchar2(20) default 'ROLE_USER',
    enabled number(1) default 1,
    primary key(id)
);


create table board (
    idx varchar2(10) not null,
    id varchar2(50) not null,
    title varchar2(50) not null,
    content varchar2(1000) not null,
    postdate Date default sysdate not null,
    viewCount number(6) default 0 not null,
    likeCount number(6) default 0 not null,
    ofile varchar2(200), 
	sfile varchar2(30),
    isAnnouncement varchar2(1) not null,
    primary key(idx)
);


alter table board
    add constraint board_mem_fk foreign key (id)
    references member(id);
    
create sequence board_seq
    increment by 1  -- 1식 증가
    start with 1    -- 시작값 1
    minvalue 1      -- 최소값 1
    nomaxvalue      -- 최대값은 무한대
    nocycle         -- 순환 x
    nocache;        -- 캐시 사용 안함
    
    
commit;

insert into member (id, pass, name, phoneNum, email, postcode, address, detailaddress, regidate, authority, enabled, provider, providerId)
			values ('test1', NULL, '홍길동', '010-1234-5678', 'test@test.com', '12345', '경기도', '고양시', DEFAULT, DEFAULT, DEFAULT, DEFAULT, NULL);

UPDATE member SET authority='ROLE_ADMIN' WHERE ID='yenoraeng42';
UPDATE member SET enabled=0 WHERE ID='test2';


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
  primary key(id)
);

ALTER TABLE member
ADD (
    IsLock NUMBER(1) DEFAULT 1,
    failCount NUMBER DEFAULT 0,
    LockTime TIMESTAMP
);

ALTER TABLE member RENAME COLUMN LockTime TO lockTimes;
ALTER TABLE member RENAME COLUMN IsLock TO isLocks;


ALTER TABLE member RENAME COLUMN lockTimes TO lockTime;
ALTER TABLE member RENAME COLUMN isLocks TO isLock;


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
    VALUES (inquiryBoard_seq.nextval, 'test2', '정보 문의합니다.', '교통약자 화장실 정보를 추가하고 싶은데 어디에 말하면 될까요??', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test3', '채팅 상담 문의합니다.', '채팅 상담 중에 오류가 나서 연결이 끊겼습니다. 다시 문의 드리겠습니다.', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test4', '승장장 정보', '현재 **역 지하철 승강장이 공사중이라 사용을 못합니다 정보 업데이트 부탁드립니다~', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test2', '게시판 문의드립니다.', '문의글 게시판을 보려고 하는데 게시글 비밀번호를 변경하고 싶어요.. 다른 방법 있을까요?', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test3', '답변 부탁드려요.', '홈페이지 정보는 어디서 얻어 오는 걸까요?', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test5', '비밀번호 문의', '비밀번호 변경하고 싶은데 가능한가요?', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test6', '정보 문의합니다.', '교통약자 화장실 정보를 추가하고 싶은데 어디에 말하면 될까요??', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test5', '문의합니다. 답변 바랍니다.', '채팅 상담 중에 오류가 나서 연결이 끊겼습니다. 다시 문의 드리겠습니다.', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test7', '승장장 정보', '현재 **역 지하철 승강장이 공사중이라 사용을 못합니다 정보 업데이트 부탁드립니다~', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test8', '게시판 문의드립니다.', '문의글 게시판을 보려고 하는데 비밀번호를 잊어버렸어요. 다른 방법 있을까요?', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test9', '회원가입 정보 변경 문의', '제 정보를 변경하고 싶은데 어디서 하면 될까요?', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test3', '현재 홈페이지가 너무 마음에 들어요', '항상 감사합니다 좋은 사이트 만들어주셔서 감사합니다~', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test1', '정보 문의.. 답변 해주세요', '교통약자 화장실 정보를 추가하고 싶은데 어디에 말하면 될까요??', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test2', '답변 바랍니다.', '공지 사항 게시판은 일반 회원은 글쓰기가 불가한가요?', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test5', '승장장 정보', '현재 **역 지하철 승강장이 공사중이라 사용을 못합니다 정보 업데이트 부탁드립니다~', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test7', '정보 게시판 궁금합니다.', '정보 게시판은 비회원도 글쓰기가 가능한가요?', 'N', 1234);
INSERT INTO inquiryBoard (idx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 'test8', '회원가입 정보', '제 정보를 변경하고 싶은데 어디서 하면 될까요?', 'N', 1234);
INSERT INTO inquiryBoard (idx, parentIdx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 1, 'yenoraeng42', '	[답변]정보 문의합니다.', '안녕하세요 정보 추가를 원하시면 문의게시판에 정보를 적어 두시거나 채팅 상담을 통해 말씀해주시면 저희가 정보를 추가해놓겠습니다. 감사합니다.', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 1;
INSERT INTO inquiryBoard (idx, parentIdx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 2, 'yenoraeng42', '	[답변]채팅 상담 문의합니다.', '안녕하세요. 채팅 상담 중 연결이 끊겨 불편하셨겠습니다. 죄송합니다. 인터넷 연결이 불안정 하시면 문의게시판을 이용해주시면 답변 해드리겠습니다.', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 2;
INSERT INTO inquiryBoard (idx, parentIdx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 3, 'yenoraeng42', '	[답변]승장장 정보', '안녕하세요. 승강장 정보를 제공해주셔서 감사합니다. 정보는 확인 후 변경도와드리겠습니다. 감사합니다~', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 3;
INSERT INTO inquiryBoard (idx, parentIdx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 4, 'yenoraeng42', '	[답변]게시판 문의드립니다.', '안녕하세요. 문의 게시판 비밀번호는 현재 로그인 후 게시글 수정하실때 변경이 가능합니다. 문제가 있으시면 문의게시판, 채팅상담을 이용해주세요', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 4;
INSERT INTO inquiryBoard (idx, parentIdx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 5, 'yenoraeng42', '	[답변]답변 부탁드려요.', '안녕하세요. 현재 사용중인 정보는 서울특별시 복지건강본부에서 제공하는 정보로 혹시 이용 중 문제나 잘못된 정보가 있으면 문의게시판을 이용해주세요. 감사합니다.
    ', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 5;
INSERT INTO inquiryBoard (idx, parentIdx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 6, 'yenoraeng42', '	[답변]비밀번호 문의', '안녕하세요. 현재 사용중인 로그인시 오른쪽 상단에 위치한 마이페이지에서 비밀번호 변경이 가능합니다.', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 6;
INSERT INTO inquiryBoard (idx, parentIdx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 7, 'yenoraeng42', '	[답변]정보 문의합니다.', '안녕하세요 정보 추가를 원하시면 문의게시판에 정보를 적어 두시거나 채팅 상담을 통해 말씀해주시면 저희가 정보를 추가해놓겠습니다. 감사합니다.', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 7;
INSERT INTO inquiryBoard (idx, parentIdx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 8, 'yenoraeng42', '	[답변]문의합니다. 답변 바랍니다.', '안녕하세요. 채팅 상담 중 연결이 끊겨 불편하셨겠습니다. 죄송합니다. 인터넷 연결이 불안정 하시면 문의게시판을 이용해주시면 답변 해드리겠습니다.', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 8;
INSERT INTO inquiryBoard (idx, parentIdx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 9, 'yenoraeng42', '	[답변]승장장 정보', '안녕하세요. 승강장 정보를 제공해주셔서 감사합니다. 정보는 확인 후 변경도와드리겠습니다. 감사합니다~', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 9;
INSERT INTO inquiryBoard (idx, parentIdx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 10, 'yenoraeng42', '	[답변]게시판 문의드립니다.', '안녕하세요. 문의 게시판 비밀번호는 현재 로그인 후 게시글 수정하실때 변경이 가능합니다. 문제가 있으시면 문의게시판, 채팅상담을 이용해주세요', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 10;
INSERT INTO inquiryBoard (idx, parentIdx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 11, 'yenoraeng42', '	[답변]회원가입 정보 변경 문의', '안녕하세요. 현재 사용중인 로그인시 오른쪽 상단에 위치한 마이페이지에서 회원 정보 변경이 가능합니다.', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx =11;
INSERT INTO inquiryBoard (idx, parentIdx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 12, 'yenoraeng42', '	[답변]현재 홈페이지가 너무 마음에 들어요', '안녕하세요. 저희 홈페이지를 사랑해주셔서 감사합니다.^^ 더욱더 발전해서 더 나은 정보 제공해드리겠습니다.', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx =12;
INSERT INTO inquiryBoard (idx, parentIdx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 13, 'yenoraeng42', '	[답변]정보 문의.. 답변 해주세요.', '안녕하세요 정보 추가를 원하시면 문의게시판에 정보를 적어 두시거나 채팅 상담을 통해 말씀해주시면 저희가 정보를 추가해놓겠습니다. 감사합니다.', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 13;
INSERT INTO inquiryBoard (idx, parentIdx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 14, 'yenoraeng42', '	[답변]답변 바랍니다.', '안녕하세요. 공지사항 게시판은 현재 일반 회원들은 댓글작성, 좋아요만 가능하며 글쓰기는 불가능 합니다. 혹시 필요하신 사항이나 홈페이지에 문제가 발생했다면 문의게시판, 채팅 상담을 이용해주시면 됩니다. 다른 회원분들에게 알리고 싶은 내용은 정보게시판을 이용해주세요. ^^', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 14;
INSERT INTO inquiryBoard (idx, parentIdx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 15, 'yenoraeng42', '	[답변]승장장 정보', '안녕하세요. 승강장 정보를 제공해주셔서 감사합니다. 정보는 확인 후 변경도와드리겠습니다. 감사합니다~', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 15;
INSERT INTO inquiryBoard (idx, parentIdx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 16, 'yenoraeng42', '	[답변]답변 바랍니다.', '안녕하세요. 정보 게시판은 현재 일반 회원들은 일반 회원도 가능하며 로그인을 하셔야 글쓰기가 가능합니다. ^^ 다른 회원분들에게 알리고 싶은 내용은 정보게시판을 이용해주세요. ^^', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 16;
INSERT INTO inquiryBoard (idx, parentIdx, id, title, content, isAnnouncement, boardPass)
    VALUES (inquiryBoard_seq.nextval, 17, 'yenoraeng42', '	[답변]정보 문의합니다.', '[답변] 로그인 시 홈페이지 오른쪽 상단에 있는 마이페이지에 들어가면 회원 정보 변경이 가능합니다 ^^
또 추가 문의 사항있으시면 문의게시판이나 채팅상담에 문의 내용 적어주시면 답변 드리겠습니다 ~ 감사합니다 ', 'Y', 1234);
update inquiryBoard SET responses=responses+1 where idx = 17;
--문의사항게시판 테이블 삭제
drop table inquiryBoard;
--문의사항게시판 시퀀스 삭제
DROP SEQUENCE inquiryBoard_seq;
desc inquiryBoard;
commit;