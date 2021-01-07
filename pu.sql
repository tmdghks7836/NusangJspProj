--------------------------------------------------------
--  ������ ������ - ������-11��-09-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table PAYMENT_USER
--------------------------------------------------------

  CREATE TABLE "NUSANGUSER"."PAYMENT_USER" 
   (	"PH_USERNO" NUMBER, 
	"PRODUCTNAME" VARCHAR2(500 BYTE), 
	"PRICE" NUMBER, 
	"USERNO" NUMBER DEFAULT 1, 
	"SELLSTATE" NUMBER, 
	"REGDATE" DATE DEFAULT SYSDATE, 
	"BUSINESS_PARTNER" NUMBER DEFAULT 1, 
	"STAR_CNT" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "ADMIN" ;
REM INSERTING into NUSANGUSER.PAYMENT_USER
SET DEFINE OFF;
Insert into NUSANGUSER.PAYMENT_USER (PH_USERNO,PRODUCTNAME,PRICE,USERNO,SELLSTATE,REGDATE,BUSINESS_PARTNER,STAR_CNT) values (1,'ī�ÿ��ð�(�췹ź)',23000,1,2,to_date('20/11/09','RR/MM/DD'),6,null);
Insert into NUSANGUSER.PAYMENT_USER (PH_USERNO,PRODUCTNAME,PRICE,USERNO,SELLSTATE,REGDATE,BUSINESS_PARTNER,STAR_CNT) values (2,'ī�ÿ��ð�(�췹ź)',23000,6,1,to_date('20/11/09','RR/MM/DD'),1,null);
Insert into NUSANGUSER.PAYMENT_USER (PH_USERNO,PRODUCTNAME,PRICE,USERNO,SELLSTATE,REGDATE,BUSINESS_PARTNER,STAR_CNT) values (3,'�ٽ����ܽ�źƾ ������ ',25000000,1,2,to_date('20/11/09','RR/MM/DD'),6,null);
Insert into NUSANGUSER.PAYMENT_USER (PH_USERNO,PRODUCTNAME,PRICE,USERNO,SELLSTATE,REGDATE,BUSINESS_PARTNER,STAR_CNT) values (4,'�ٽ����ܽ�źƾ ������ ',25000000,6,1,to_date('20/11/09','RR/MM/DD'),1,null);
--------------------------------------------------------
--  DDL for Index SYS_C0010196
--------------------------------------------------------

  CREATE UNIQUE INDEX "NUSANGUSER"."SYS_C0010196" ON "NUSANGUSER"."PAYMENT_USER" ("PH_USERNO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "ADMIN" ;
--------------------------------------------------------
--  DDL for Trigger TRI_PAYMENT_USER_PH_USERNO
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "NUSANGUSER"."TRI_PAYMENT_USER_PH_USERNO" BEFORE INSERT ON PAYMENT_USER
FOR EACH ROW
BEGIN
	SELECT SEQ_PAYMENT_USER_PH_USERNO.nextval
	INTO :new.PH_USERNO
	FROM dual;
END;


/
ALTER TRIGGER "NUSANGUSER"."TRI_PAYMENT_USER_PH_USERNO" ENABLE;
--------------------------------------------------------
--  Constraints for Table PAYMENT_USER
--------------------------------------------------------

  ALTER TABLE "NUSANGUSER"."PAYMENT_USER" ADD CONSTRAINT "SYS_C0010196" PRIMARY KEY ("PH_USERNO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "ADMIN"  ENABLE;
  ALTER TABLE "NUSANGUSER"."PAYMENT_USER" MODIFY ("BUSINESS_PARTNER" NOT NULL ENABLE);
  ALTER TABLE "NUSANGUSER"."PAYMENT_USER" MODIFY ("REGDATE" NOT NULL ENABLE);
  ALTER TABLE "NUSANGUSER"."PAYMENT_USER" MODIFY ("SELLSTATE" NOT NULL ENABLE);
  ALTER TABLE "NUSANGUSER"."PAYMENT_USER" MODIFY ("USERNO" NOT NULL ENABLE);
  ALTER TABLE "NUSANGUSER"."PAYMENT_USER" MODIFY ("PRICE" NOT NULL ENABLE);
  ALTER TABLE "NUSANGUSER"."PAYMENT_USER" MODIFY ("PRODUCTNAME" NOT NULL ENABLE);
  ALTER TABLE "NUSANGUSER"."PAYMENT_USER" MODIFY ("PH_USERNO" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table PAYMENT_USER
--------------------------------------------------------

  ALTER TABLE "NUSANGUSER"."PAYMENT_USER" ADD CONSTRAINT "SYS_C0010234" FOREIGN KEY ("USERNO")
	  REFERENCES "NUSANGUSER"."NUSER" ("USERNO") ENABLE;
  ALTER TABLE "NUSANGUSER"."PAYMENT_USER" ADD CONSTRAINT "SYS_C0012149" FOREIGN KEY ("BUSINESS_PARTNER")
	  REFERENCES "NUSANGUSER"."NUSER" ("USERNO") ENABLE;