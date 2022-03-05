CREATE USER C##TEAM IDENTIFIED BY TEAM;

GRANT CONNECT, RESOURCE, DBA TO C##TEAM;


CREATE TABLE CUSTOMER( --����
 CUS_PHONE VARCHAR2(20) PRIMARY KEY, --�ڵ�����ȣ
 CUS_POINT NUMBER NOT NULL --����Ʈ (�ֹ��ݾ��� 10���ξ� ����)
);

UPDATE CUSTOMER SET CUS_POINT WHERE �ѱݾ�*10 -----???????

INSERT INTO CUSTOMER VALUES('01029235057' , );  
SELECT * FROM CUSTOMER

----------------------------------------------------------------------------------------------

CREATE TABLE ORDERS( --�ֹ�
 ORDER_ID VARCHAR2(20) PRIMARY KEY, --�ֹ���ȣ
 CUS_PHONE VARCHAR2(20) REFERENCES CUSTOMER(CUS_PHONE), --�ڵ�����ȣ
 ORDER_DATE DATE --��¥
);

CREATE SEQUENCE ORDERS_SEQ;
DROP SEQUENCE ORDERS_SEQ;

INSERT INTO ORDERS VALUES ('JB ' || ORDERS_SEQ.NEXTVAL, '01029235057' , SYSDATE)

SELECT * FROM ORDERS
DELETE FROM ORDERS WHERE CUS_PHONE = '01029235057'

------------------------------------------------------------------------------------------------------

CREATE TABLE GOODS( --�ǸŻ�ǰ(���̽�ũ��)
 GOODS_ID VARCHAR2(20) PRIMARY KEY, --��ǰ�ڵ�
 GOODS_NAME VARCHAR2(20) NOT NULL, --��ǰ�̸�
 STOCK_QTY NUMBER , --������
 GOODS_PRICE NUMBER  --�Һ��ڰ���
);

INSERT INTO GOODS VALUES('GC01_SP01' , '������' , 0 ,1500);
INSERT INTO GOODS VALUES('GC01_SP02' , '������' , 0 ,1500); 
INSERT INTO GOODS VALUES('GC01_SP03' , '������' , 0 ,1500); 
INSERT INTO GOODS VALUES('GC01_SP04' , '������' , 0 ,1500); 
INSERT INTO GOODS VALUES('GC01_SP05' , '�ζ���',0 ,1500);  --��

INSERT INTO GOODS VALUES('GC02_SP01' , '�͵�', 0 ,800);
INSERT INTO GOODS VALUES('GC02_SP02' , '������', 0 ,800);
INSERT INTO GOODS VALUES('GC02_SP03' , '��ũ����',0 ,800);
INSERT INTO GOODS VALUES('GC02_SP04' , '������', 0 ,800);
INSERT INTO GOODS VALUES('GC02_SP05' , '������', 0 ,800); --���޹�

INSERT INTO GOODS VALUES('GC03_SP01' , '��ũ����', 0 ,400);
INSERT INTO GOODS VALUES('GC03_SP02' , '�ҽ���', 0 ,400);
INSERT INTO GOODS VALUES('GC03_SP03' , '���ڹ�', 0 ,400);
INSERT INTO GOODS VALUES('GC03_SP04' , '�޷γ�', 0 ,400);
INSERT INTO GOODS VALUES('GC03_SP05' , '������', 0 ,400); --����

INSERT INTO GOODS VALUES('GC04_SP01' , '���Դ�', 0 ,7000);
INSERT INTO GOODS VALUES('GC04_SP02' , '���ѷ�', 0 ,7000);
INSERT INTO GOODS VALUES('GC04_SP03' , '�ϰմ���', 0 ,7000);
INSERT INTO GOODS VALUES('GC04_SP04' , 'ȣ�θ���', 0 ,7000);
INSERT INTO GOODS VALUES('GC04_SP05' , 'ü������', 0 ,7000); --�� 

UPDATE GOODS SET STOCK_QTY=STOCK_QTY +30 --�� ó������ �������� 
SELECT * FROM GOODS

--����� 5�� �����Ͻ� �ڵ����� �����ϰԲ� �Ϸ��� ��� �ؾ��ϴ���....

------------------------------------------------------------------------------------------------

CREATE TABLE ORDER_LINE( --�ֹ���
 ORDER_LINE_ID VARCHAR2(20) PRIMARY KEY, --�ֹ����ڵ�
 ORDER_ID VARCHAR2(20) REFERENCES ORDERS(ORDER_ID), --�ֹ���ȣ
 GOODS_ID VARCHAR2(20) REFERENCES GOODS(GOODS_ID), --��ǰ�ڵ�
 ORDER_PRICE NUMBER , --����
 ORDER_QTY NUMBER --�ֹ�����
);

INSERT INTO ORDER_LINE VALUES(JS);

-----------------------------------------------------------------------------------------------

CREATE TABLE DEALER( --�ŷ�ó
 DEALER_ID VARCHAR2(20) PRIMARY KEY, --�ŷ�ó�ڵ�
 DEALER_NAME VARCHAR2(30) NOT NULL, --�ŷ�ó�̸�
 DEALER_ADDR VARCHAR2(30) , --�ּ�
 DEALER_PHONE VARCHAR2(20)  --����ó
);

INSERT INTO DEALER VALUES('GC01', '���׷�', '����Ư���� �߱�', '02-2022-6000');
INSERT INTO DEALER VALUES('GC02', '��������', '����Ư���� ��걸', '02-709-7766');
INSERT INTO DEALER VALUES('GC03', '�Ե�����', '����Ư���� ��������', '02-2670-6114');
INSERT INTO DEALER VALUES('GC04', '�󺧸�', '���󳲵� ȭ��', '061-372-0151');

SELECT * FROM DEALER;

-----------------------------------------------------------------------------------------------

CREATE TABLE IB( --����
 IB_ID VARCHAR2(20) PRIMARY KEY, --�����ڵ�
 DEALER_ID VARCHAR2(20) REFERENCES DEALER(DEALER_ID), --�ŷ�ó�ڵ�
 IB_DATE DATE DEFAULT SYSDATE --���ֳ�¥ 
);

--�����ڵ� ������
CREATE SEQUENCE IB_SEQ;
INSERT INTO IB VALUES ('BJ ' || IB_SEQ.NEXTVAL, 'GC01', SYSDATE);
INSERT INTO IB VALUES ('BJ ' || IB_SEQ.NEXTVAL, 'GC02', SYSDATE);
INSERT INTO IB VALUES ('BJ ' || IB_SEQ.NEXTVAL, 'GC03', SYSDATE);
INSERT INTO IB VALUES ('BJ ' || IB_SEQ.NEXTVAL, 'GC04', SYSDATE);
                                                                    ---- ���ÿ� �ֹ��ؾ��ϴµ� ��� �ؾ�����???                                                  
DROP SEQUENCE IB_SEQ;
DELETE FROM IB WHERE DEALER_ID = 'GC01'

SELECT * FROM IB;

---------------------------------------------------------------------------------------------------------

CREATE TABLE IB_LINE( --���ֻ�
 IB_LINE_ID VARCHAR2(20) PRIMARY KEY, --���ֻ��ڵ�   
 IB_ID VARCHAR2(20) REFERENCES IB(IB_ID), -- �����ڵ�
 GOODS_ID VARCHAR2(20) REFERENCES GOODS(GOODS_ID), --��ǰ�ڵ�
 IB_QTY NUMBER , --���ּ���
 IB_PRICE NUMBER  --���ְ��� 
);

CREATE SEQUENCE IB_LINE_SEQ;
DROP SEQUENCE IB_LINE_SEQ;

SELECT * FROM IB_LINE;

INSERT INTO IB_LINE VALUES(???,'BJ ' || IB_LINE_SEQ.NEXTVAL ,'GC01_SP01' ,30,750);   ------���ֻ��ڵ嵵 ������????? 
DELETE FROM IB_LINE WHERE GOODS_ID = 'GC01_SP01'

----------------------------------------------------------------------------------------------------------

CREATE TABLE ICE( --��޻�ǰ
 ICE_ID VARCHAR2(30) PRIMARY KEY, --�ŷ�ó��޻�ǰ
 DEALER_ID VARCHAR2(20) REFERENCES DEALER(DEALER_ID), --�ŷ�ó�ڵ�
 DEALER_PRICE NUMBER , --�ŷ�ó����
 ICE_TYPE VARCHAR2(20) NOT NULL, --����
 ICE_QTY NUMBER --�ŷ�ó ��ü ����
);

--�ŷ�ó������ ���ְ����� 30%�� å���� 
INSERT INTO ICE VALUES('GP01', 'GC01', 525, '��', 999); 
INSERT INTO ICE VALUES('GP02', 'GC02', 280, '���޹�', 999);
INSERT INTO ICE VALUES('GP03', 'GC03', 140, '����', 999);
INSERT INTO ICE VALUES('GP04', 'GC04', 2450, '��', 999);

SELECT * FROM ICE; 

UPDATE ICE SET ICE_QTY=ICE_QTY-30  -- �� ó�� �ֹ��Ҷ� 
UPDATE ICE SET ICE_QTY=ICE_QTY-10 WHERE DEALER_ID = 'GC02'

COMMIT;



