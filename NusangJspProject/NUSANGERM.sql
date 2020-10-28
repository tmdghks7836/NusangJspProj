
/* Drop Triggers */

DROP TRIGGER TRI_BUY_RESERVATION_RESERNO;
DROP TRIGGER TRI_LOCATION_LOCATIONNO;
DROP TRIGGER TRI_NUSER_USERNO;
DROP TRIGGER TRI_PAYMENT_MARKET_PH_MARKETNO;
DROP TRIGGER TRI_PAYMENT_USER_PH_USERNO;
DROP TRIGGER TRI_POST_PICTURE_POST_PICNO;
DROP TRIGGER TRI_REPLY_REPLYNO;
DROP TRIGGER TRI_SELLPOST_POSTNO;
DROP TRIGGER TRI_WATCHLIST_WATCHLISTNO;



/* Drop Tables */

DROP TABLE NUSANGUSER.BUY_RESERVATION CASCADE CONSTRAINTS;
DROP TABLE NUSANGUSER.PAYMENT_MARKET CASCADE CONSTRAINTS;
DROP TABLE NUSANGUSER.PAYMENT_USER CASCADE CONSTRAINTS;
DROP TABLE NUSANGUSER.REPLY CASCADE CONSTRAINTS;
DROP TABLE NUSANGUSER.WATCHLIST CASCADE CONSTRAINTS;
DROP TABLE NUSANGUSER.SELLPOST CASCADE CONSTRAINTS;
DROP TABLE NUSANGUSER.NUSER CASCADE CONSTRAINTS;
DROP TABLE LOCATION CASCADE CONSTRAINTS;
DROP TABLE POST_PICTURE CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_BUY_RESERVATION_RESERNO;
DROP SEQUENCE SEQ_LOCATION_LOCATIONNO;
DROP SEQUENCE SEQ_NUSER_USERNO;
DROP SEQUENCE SEQ_PAYMENT_MARKET_PH_MARKETNO;
DROP SEQUENCE SEQ_PAYMENT_USER_PH_USERNO;
DROP SEQUENCE SEQ_POST_PICTURE_POST_PICNO;
DROP SEQUENCE SEQ_REPLY_REPLYNO;
DROP SEQUENCE SEQ_SELLPOST_POSTNO;
DROP SEQUENCE SEQ_WATCHLIST_WATCHLISTNO;




/* Create Sequences */

CREATE SEQUENCE SEQ_BUY_RESERVATION_RESERNO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_LOCATION_LOCATIONNO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_NUSER_USERNO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_PAYMENT_MARKET_PH_MARKETNO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_PAYMENT_USER_PH_USERNO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_POST_PICTURE_POST_PICNO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_REPLY_REPLYNO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_SELLPOST_POSTNO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_WATCHLIST_WATCHLISTNO INCREMENT BY 1 START WITH 1;



/* Create Tables */

CREATE TABLE LOCATION
(
	LOCATIONNO number NOT NULL,
	NAME1 varchar2(50),
	NAME2 varchar2(50),
	NAME3 varchar2(50),
	LONGTITUDE number,
	LATITUDE number,
	TABLETYPE varchar2(50) NOT NULL,
	PRIMARY KEY (LOCATIONNO),
	UNIQUE (LOCATIONNO, TABLETYPE)
);


CREATE TABLE POST_PICTURE
(
	P_1 varchar2(50),
	P_2 varchar2(50),
	P_3 varchar2(50),
	P_4 varchar2(50),
	P_5 varchar2(50),
	POST_PICNO number NOT NULL,
	PRIMARY KEY (POST_PICNO)
);


CREATE TABLE NUSANGUSER.BUY_RESERVATION
(
	SELLPOSTNO number NOT NULL,
	USERNO number DEFAULT 1    NOT NULL,
	RESER_PRICE number NOT NULL,
	STATE varchar2(30) NOT NULL,
	RESERNO number NOT NULL,
	REGDATE date NOT NULL,
	CONSTRAINT SYS_C0012097 PRIMARY KEY (RESERNO)
);


CREATE TABLE NUSANGUSER.NUSER
(
	USERNO number DEFAULT 1    NOT NULL,
	USERID varchar2(50 char) NOT NULL UNIQUE,
	USERNAME varchar2(50 char) NOT NULL,
	PASSWORD varchar2(50) NOT NULL,
	ROLE varchar2(30) NOT NULL,
	LOGINTYPE varchar2(10) NOT NULL,
	EMAIL varchar2(50) NOT NULL,
	REGDATE date DEFAULT SYSDATE   NOT NULL,
	PICTURE varchar2(500 char),
	LOCATIONNO number,
	VIEW_DISTANCE number DEFAULT 5 NOT NULL,
	NICKNAME varchar2(60) NOT NULL,
	CONSTRAINT SYS_C009884 PRIMARY KEY (USERNO)
);


CREATE TABLE NUSANGUSER.PAYMENT_MARKET
(
	PH_MARKETNO number NOT NULL,
	PAYMENTTYPE varchar2(10) NOT NULL,
	STATE varchar2(50) NOT NULL,
	NAME varchar2(30) NOT NULL,
	USERNO number DEFAULT 1    NOT NULL,
	REGDATE date DEFAULT SYSDATE,
	IMP_UID varchar2(500) NOT NULL,
	PRICE number NOT NULL,
	CONSTRAINT SYS_C0010188 PRIMARY KEY (PH_MARKETNO)
);


CREATE TABLE NUSANGUSER.PAYMENT_USER
(
	PH_USERNO number NOT NULL,
	PRODUCTNAME varchar2(30) NOT NULL,
	PRICE long NOT NULL,
	USERNO number DEFAULT 1    NOT NULL,
	SELLSTATE varchar2(30) NOT NULL,
	REGDATE date NOT NULL,
	BUSINESS_PARTNER number DEFAULT 1    NOT NULL,
	CONSTRAINT SYS_C0010196 PRIMARY KEY (PH_USERNO)
);


CREATE TABLE NUSANGUSER.REPLY
(
	REPLYNO number NOT NULL,
	USERNO number DEFAULT 1    NOT NULL,
	POSTNO number NOT NULL,
	TEXTBODY varchar2(50) NOT NULL,
	REGDATE date DEFAULT SYSDATE   NOT NULL,
	STATE varchar2(50) DEFAULT '1  ' NOT NULL,
	CHILD_LEPLYNO number,
	CONSTRAINT SYS_C0010203 PRIMARY KEY (REPLYNO)
);


CREATE TABLE NUSANGUSER.SELLPOST
(
	POSTNO number NOT NULL,
	PICTURE varchar2(500 char),
	TITLE varchar2(100) NOT NULL,
	BODYTEXT varchar2(4000),
	PRICE long NOT NULL,
	PRODUCTNAME varchar2(40),
	USERNO number DEFAULT 1    NOT NULL,
	REGDATE date DEFAULT SYSDATE  ,
	CATEGORY varchar2(100) NOT NULL,
	SELLSTATE varchar2(30),
	VIEWCNT number DEFAULT 0,
	VISIBLE number DEFAULT 1,
	LOCATIONNO number,
	POST_PICNO number NOT NULL,
	CONSTRAINT SYS_C0010215 PRIMARY KEY (POSTNO)
);


CREATE TABLE NUSANGUSER.WATCHLIST
(
	USERNO number DEFAULT 1    NOT NULL,
	POSTNO number NOT NULL,
	WATCHLISTNO number NOT NULL,
	CONSTRAINT SYS_C0010219 PRIMARY KEY (WATCHLISTNO)
);



/* Create Foreign Keys */

ALTER TABLE NUSANGUSER.NUSER
	ADD FOREIGN KEY (LOCATIONNO)
	REFERENCES LOCATION (LOCATIONNO)
;


ALTER TABLE NUSANGUSER.SELLPOST
	ADD FOREIGN KEY (LOCATIONNO)
	REFERENCES LOCATION (LOCATIONNO)
;


ALTER TABLE NUSANGUSER.SELLPOST
	ADD FOREIGN KEY (POST_PICNO)
	REFERENCES POST_PICTURE (POST_PICNO)
;


ALTER TABLE NUSANGUSER.BUY_RESERVATION
	ADD CONSTRAINT SYS_C0012146 FOREIGN KEY (USERNO)
	REFERENCES NUSANGUSER.NUSER (USERNO)
;


ALTER TABLE NUSANGUSER.PAYMENT_MARKET
	ADD CONSTRAINT SYS_C0010233 FOREIGN KEY (USERNO)
	REFERENCES NUSANGUSER.NUSER (USERNO)
;


ALTER TABLE NUSANGUSER.PAYMENT_USER
	ADD CONSTRAINT SYS_C0012149 FOREIGN KEY (BUSINESS_PARTNER)
	REFERENCES NUSANGUSER.NUSER (USERNO)
;


ALTER TABLE NUSANGUSER.PAYMENT_USER
	ADD CONSTRAINT SYS_C0010234 FOREIGN KEY (USERNO)
	REFERENCES NUSANGUSER.NUSER (USERNO)
;


ALTER TABLE NUSANGUSER.REPLY
	ADD CONSTRAINT SYS_C0010235 FOREIGN KEY (USERNO)
	REFERENCES NUSANGUSER.NUSER (USERNO)
;


ALTER TABLE NUSANGUSER.SELLPOST
	ADD CONSTRAINT SYS_C0010236 FOREIGN KEY (USERNO)
	REFERENCES NUSANGUSER.NUSER (USERNO)
;


ALTER TABLE NUSANGUSER.WATCHLIST
	ADD CONSTRAINT SYS_C0010237 FOREIGN KEY (USERNO)
	REFERENCES NUSANGUSER.NUSER (USERNO)
;


ALTER TABLE NUSANGUSER.REPLY
	ADD CONSTRAINT SYS_C0012153 FOREIGN KEY (CHILD_LEPLYNO)
	REFERENCES NUSANGUSER.REPLY (REPLYNO)
;


ALTER TABLE NUSANGUSER.BUY_RESERVATION
	ADD CONSTRAINT SYS_C0012154 FOREIGN KEY (SELLPOSTNO)
	REFERENCES NUSANGUSER.SELLPOST (POSTNO)
;


ALTER TABLE NUSANGUSER.REPLY
	ADD CONSTRAINT SYS_C0010231 FOREIGN KEY (POSTNO)
	REFERENCES NUSANGUSER.SELLPOST (POSTNO)
;


ALTER TABLE NUSANGUSER.WATCHLIST
	ADD CONSTRAINT SYS_C0010232 FOREIGN KEY (POSTNO)
	REFERENCES NUSANGUSER.SELLPOST (POSTNO)
;



/* Create Triggers */

CREATE OR REPLACE TRIGGER TRI_BUY_RESERVATION_RESERNO BEFORE INSERT ON BUY_RESERVATION
FOR EACH ROW
BEGIN
	SELECT SEQ_BUY_RESERVATION_RESERNO.nextval
	INTO :new.RESERNO
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_LOCATION_LOCATIONNO BEFORE INSERT ON LOCATION
FOR EACH ROW
BEGIN
	SELECT SEQ_LOCATION_LOCATIONNO.nextval
	INTO :new.LOCATIONNO
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_NUSER_USERNO BEFORE INSERT ON NUSER
FOR EACH ROW
BEGIN
	SELECT SEQ_NUSER_USERNO.nextval
	INTO :new.USERNO
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_PAYMENT_MARKET_PH_MARKETNO BEFORE INSERT ON PAYMENT_MARKET
FOR EACH ROW
BEGIN
	SELECT SEQ_PAYMENT_MARKET_PH_MARKETNO.nextval
	INTO :new.PH_MARKETNO
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_PAYMENT_USER_PH_USERNO BEFORE INSERT ON PAYMENT_USER
FOR EACH ROW
BEGIN
	SELECT SEQ_PAYMENT_USER_PH_USERNO.nextval
	INTO :new.PH_USERNO
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_POST_PICTURE_POST_PICNO BEFORE INSERT ON POST_PICTURE
FOR EACH ROW
BEGIN
	SELECT SEQ_POST_PICTURE_POST_PICNO.nextval
	INTO :new.POST_PICNO
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_REPLY_REPLYNO BEFORE INSERT ON REPLY
FOR EACH ROW
BEGIN
	SELECT SEQ_REPLY_REPLYNO.nextval
	INTO :new.REPLYNO
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_SELLPOST_POSTNO BEFORE INSERT ON SELLPOST
FOR EACH ROW
BEGIN
	SELECT SEQ_SELLPOST_POSTNO.nextval
	INTO :new.POSTNO
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_WATCHLIST_WATCHLISTNO BEFORE INSERT ON WATCHLIST
FOR EACH ROW
BEGIN
	SELECT SEQ_WATCHLIST_WATCHLISTNO.nextval
	INTO :new.WATCHLISTNO
	FROM dual;
END;

/




