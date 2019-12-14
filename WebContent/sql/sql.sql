/* Drop Tables */

DROP TABLE LIKE_IT CASCADE CONSTRAINTS;
DROP TABLE BOARD CASCADE CONSTRAINTS;
DROP TABLE REPLY CASCADE CONSTRAINTS;
DROP TABLE ACCOUNT CASCADE CONSTRAINTS;
DROP TABLE PRIVACY CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE ACCOUNT
(
	ID varchar2(256) NOT NULL,
	PW varchar2(256) NOT NULL,
	FRIEND varchar2(3500),
	PFILE varchar2(200),
	SALT varchar2(256) NOT NULL,
	SSNUM varchar2(50) NOT NULL,
	PRIMARY KEY (ID)
);


select * from ACCOUNT;

insert into ACCOUNT values('zs1', '123456asdqwe', null, null, 'asdasd', '00001');
UPDATE ACCOUNT SET FRIEND='zs2,zs3,zs4,zs5' WHERE ID = 'zs1';
insert into ACCOUNT values('zs2', '123456asdqwe', null, null, 'asdasd', '00002');
insert into ACCOUNT values('zs3', '123456asdqwe', null, null, 'asdasd', '00003');
insert into ACCOUNT values('zs4', '123456asdqwe', null, null, 'asdasd', '00004');
insert into ACCOUNT values('zs5', '123456asdqwe', null, null, 'asdasd', '00005');


CREATE TABLE BOARD
(
	BOARDNUM number NOT NULL,
	UDATE date NOT NULL,
	CONTENT varchar2(3500) NOT NULL,
	IMAGE varchar2(200),
	LIKECOUNT number NOT NULL,
	ID varchar2(256) NOT NULL,
	PRIMARY KEY (BOARDNUM)
);

insert into board values(1, to_date('95/12/11'), '컨텐츠 내용1', null, 5, 'zs1');
insert into board values(2, to_date('95/12/12'), '컨텐츠 내용2', null, 6, 'zs2');
insert into board values(3, to_date('95/12/13'), '컨텐츠 내용3', null, 7, 'zs3');
insert into board values(4, to_date('95/12/14'), '컨텐츠 내용4', null, 8, 'zs4');
insert into board values(5, to_date('95/12/15'), '컨텐츠 내용5', null, 9, 'zs5');


CREATE TABLE LIKE_IT
(
	OWNER varchar2(256) NOT NULL,
	ISLIKE varchar2(64) NOT NULL,
	ID varchar2(256) NOT NULL,
	BOARDNUM number NOT NULL
);

delete from LIKE_IT;

insert into LIKE_IT values('zs1', 'true', 'zs1', 1);
insert into LIKE_IT values('zs1', 'true', 'zs2', 1);
insert into LIKE_IT values('zs1', 'true', 'zs3', 1);
insert into LIKE_IT values('zs1', 'true', 'zs4', 1);
insert into LIKE_IT values('zs1', 'true', 'zs5', 1);
insert into LIKE_IT values('zs3', 'false', 'zs2', 3);

insert into LIKE_IT values('zs2', 'true', 'zs1', 2);
insert into LIKE_IT values('zs3', 'true', 'zs1', 3);


CREATE TABLE PRIVACY
(
	SSNUM varchar2(50) NOT NULL,
	GENDER varchar2(20) NOT NULL,
	TEL varchar2(40) NOT NULL,
	EMAIL varchar2(256) NOT NULL,
	PRIMARY KEY (SSNUM)
);

insert into PRIVACY values('00001', 'male', '1234', 'email');
insert into PRIVACY values('00002', 'male', '1234', 'email');
insert into PRIVACY values('00003', 'male', '1234', 'email');
insert into PRIVACY values('00004', 'male', '1234', 'email');
insert into PRIVACY values('00005', 'male', '1234', 'email');


CREATE TABLE REPLY
(
	UDATE date NOT NULL,
	CONTENT varchar2(3500) NOT NULL,
	REPLYNUM number NOT NULL,
	ID varchar2(256) NOT NULL,
	REF number NOT NULL,
	PRIMARY KEY (REPLYNUM)
);

insert into REPLY values(to_date('96/11/01'), '댓글입니다.', 1, 'zs1', 2);

ALTER TABLE REPLY ADD(REF number);
select * from REPLY;

/* Create Foreign Keys */

ALTER TABLE BOARD
	ADD FOREIGN KEY (ID)
	REFERENCES ACCOUNT (ID)
;


ALTER TABLE LIKE_IT
	ADD FOREIGN KEY (ID)
	REFERENCES ACCOUNT (ID)
;


ALTER TABLE REPLY
	ADD FOREIGN KEY (ID)
	REFERENCES ACCOUNT (ID)
;


ALTER TABLE LIKE_IT
	ADD FOREIGN KEY (BOARDNUM)
	REFERENCES BOARD (BOARDNUM)
;

ALTER TABLE ACCOUNT
	ADD FOREIGN KEY (SSNUM)
	REFERENCES PRIVACY (SSNUM)
;

ALTER TABLE REPLY
	ADD FOREIGN KEY (REF)
	REFERENCES BOARD (BOARDNUM)
;

