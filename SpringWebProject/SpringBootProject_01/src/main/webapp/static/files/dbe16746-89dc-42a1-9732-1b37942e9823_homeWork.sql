--게시판 만들기 숙제

create table board (
    idx varchar2(10) not null,
    id varchar2(50) not null,
    title varchar2(50) not null,
    content varchar2(1000) not null,
    postdate Date default sysdate not null,
    viewCount number(6) default 0 not null,
    likeCount number(6) default 0 not null,
    ofile varchar2(200), 
	sfile varchar2(30)
);


create sequence board_seq
    increment by 1  -- 1식 증가
    start with 1    -- 시작값 1
    minvalue 1      -- 최소값 1
    nomaxvalue      -- 최대값은 무한대
    nocycle         -- 순환 x
    nocache;
    

insert into board (idx, id, title, content)
    values(board_seq.nextval, 'project', '안녕하세요', '반갑습니다');

commit;

update board set title = '안녕하세요11', content = '반갑습니다11', ofile=null, sfile = null where idx=1;
    
    
    
    
    
    