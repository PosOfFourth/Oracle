CREATE TABLE CUSTOMER( --����
 CUS_ID VARCHAR2(20 )PRIMARY KEY, --���̵� (�ڵ�����ȣ)
 CUS_PWD VARCHAR2(20) NOT NULL --�н�����(�޹�ȣ ���ڸ�)
);

INSERT INTO CUSTOMER VALUES('010-2923-5057' , '5057');  
SELECT * FROM CUSTOMER

DELETE FROM CUSTOMER WHERE CUS_PHONE = '010-2923-5057'
DROP TABLE CUSTOMER

COMMIT
----------------------------------------------------------------------------------------------

CREATE TABLE ORDERS( --�ֹ�
 ORDER_ID VARCHAR2(50) PRIMARY KEY, --�ֹ���ȣ
 CUS_ID VARCHAR2(20) REFERENCES CUSTOMER(CUS_ID), --�ֹ��ھ��̵� 
 ORDER_DATE DATE --��¥
);

DROP TABLE ORDERS

INSERT INTO ORDERS VALUES ('JB ' || ORDERS_SEQ.NEXTVAL,'010-2923-5057' ,SYSDATE)

SELECT * FROM ORDERS
DELETE FROM ORDERS WHERE CUS_ID = '010-2923-5057'

CREATE SEQUENCE ORDERS_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOMINVALUE
NOCYCLE

DROP SEQUENCE ORDERS_SEQ

--'JB ' || ORDERS_SEQ.NEXTVAL


------------------------------------------------------------------------------------------------------

CREATE TABLE GOODS( --�ǸŻ�ǰ(���̽�ũ��) 
 GOODS_ID VARCHAR2(20) PRIMARY KEY, --��ǰ�ڵ�
 GOODS_NAME VARCHAR2(50) NOT NULL, --��ǰ�̸�
 STOCK_QTY NUMBER , --������
 GOODS_PRICE NUMBER  --�Һ��ڰ���         
);  -----------------�ܼ�â�� ��ǰ�ڵ�� �Ⱥ��̰� �ϴ� ���???

INSERT INTO GOODS VALUES('GC_C1','������ ���ٰ���ī���ٴҶ��' , 0 ,1500);


UPDATE GOODS SET STOCK_QTY=STOCK_QTY +30 --�� ó������ �������� 
SELECT * FROM GOODS
DELETE FROM GOODS WHERE STOCK_QTY = 30

DROP TABLE GOODS


------------------------------------------------------------------------------------------------

CREATE TABLE ORDER_LINE( --�ֹ���
 ORDER_LINE_ID VARCHAR2(30) PRIMARY KEY, --�ֹ����ڵ�
 ORDER_ID VARCHAR2(50) REFERENCES ORDERS(ORDER_ID), --�ֹ���ȣ
 GOODS_ID VARCHAR2(20) REFERENCES GOODS(GOODS_ID), --��ǰ�ڵ�
 GOODS_PRICE NUMBER,--����
 ORDER_QTY NUMBER
);

SELECT * FROM ORDER_LINE
DROP TABLE ORDER_LINE
INSERT INTO ORDER_LINE VALUES('JS ' || ORDER_LINE_SEQ.NEXTVAL, 'JB ' || ORDERS_SEQ.CURRVAL, 'GC_C1', 1500, 1);

CREATE SEQUENCE ORDER_LINE_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOMINVALUE
NOCYCLE


DROP SEQUENCE ORDER_LINE_SEQ; 

-----------------------------------------------------------------------------------------------

CREATE TABLE DEALER( --�ŷ�ó
 DEALER_ID VARCHAR2(20) PRIMARY KEY, --�ŷ�ó�ڵ�
 DEALER_TYPE VARCHAR2(20) NOT NULL, --�ŷ�ó����
 DEALER_NAME VARCHAR2(30) NOT NULL, --�ŷ�ó�̸�
 DEALER_ADDR VARCHAR2(30), --�ּ�
 DEALER_PHONE VARCHAR2(20)  --����ó

);

INSERT INTO DEALER VALUES('GC01', '��', '���׷�', '����Ư���� �߱�', '02-2022-6000');
INSERT INTO DEALER VALUES('GC02', '���޹�', '��������', '����Ư���� ��걸', '02-709-7766');
INSERT INTO DEALER VALUES('GC03', '����','�Ե�����', '����Ư���� ��������', '02-2670-6114');
INSERT INTO DEALER VALUES('GC04', '��','�󺧸�', '���󳲵� ȭ��', '061-372-0151');

SELECT * FROM DEALER
DROP TABLE DEALER
-----------------------------------------------------------------------------------------------

CREATE TABLE IB( --����
 IB_ID VARCHAR2(20) PRIMARY KEY, --�����ڵ�
 DEALER_ID VARCHAR2(20) REFERENCES DEALER(DEALER_ID), --�ŷ�ó�ڵ�
 IB_DATE DATE DEFAULT SYSDATE --���ֳ�¥ 
);

--�����ڵ� ������
CREATE SEQUENCE IB_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOMINVALUE
NOCYCLE

DROP SEQUENCE IB_SEQ;

INSERT INTO IB VALUES ('BJ ' || IB_SEQ.NEXTVAL, 'GC01', SYSDATE);
INSERT INTO IB VALUES ('BJ ' || IB_SEQ.NEXTVAL, 'GC02', SYSDATE);
INSERT INTO IB VALUES ('BJ ' || IB_SEQ.NEXTVAL, 'GC03', SYSDATE);
INSERT INTO IB VALUES ('BJ ' || IB_SEQ.NEXTVAL, 'GC04', SYSDATE);
                                                                    ---- ���ÿ� �ֹ��ؾ��ϴµ� ��� �ؾ�����???                                                  

DELETE FROM IB WHERE DEALER_ID = 'GC01'

SELECT * FROM IB;
DROP TABLE IB

---------------------------------------------------------------------------------------------------------

CREATE TABLE IB_LINE( --���ֻ�
 IB_LINE_ID VARCHAR2(20) PRIMARY KEY, --���ֻ��ڵ�   
 IB_ID VARCHAR2(20) REFERENCES IB(IB_ID), -- �����ڵ�
 GOODS_ID VARCHAR2(20) REFERENCES GOODS(GOODS_ID), --��ǰ�ڵ�
 IB_QTY NUMBER , --���ּ���
 IB_PRICE NUMBER  --���ְ��� 
);

CREATE SEQUENCE IB_LINE_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOMINVALUE
NOCYCLE

DROP SEQUENCE IB_LINE_SEQ;

SELECT * FROM IB_LINE;
DROP TABLE IB_LINE

INSERT INTO IB_LINE VALUES('BS ' || IB_LINE_SEQ.NEXTVAL,'BJ ' || IB_SEQ.CURRVAL ,'GC_C1',30,750);   ------���ֻ��ڵ嵵 ������????? 
DELETE FROM IB_LINE WHERE GOODS_ID = 'GC01_SP01'

----------------------------------------------------------------------------------------------------------

CREATE TABLE SKU( --��޻�ǰ
 SKU_ID VARCHAR2(20) PRIMARY KEY, --�����ڵ� = ��ǰ�ڵ� 
 DEALER_ID VARCHAR2(20) REFERENCES DEALER(DEALER_ID), --�ŷ�ó�ڵ�
 SKU_NAME VARCHAR2(50) NOT NULL, --�ŷ�ó��޻�ǰ�̸� 
 SKU_PRICE NUMBER --�ŷ�ó����
);

SELECT * FROM SKU; 

DROP TABLE SKU
COMMIT;

--ICE_QTY NUMBER --�ŷ�ó ��ü ����

--�ŷ�ó������ ���ְ����� 30%�� å���� 
INSERT INTO SKU VALUES('GC_C1','GC01','������ ���ٰ���ī���ٴҶ��', 525);
INSERT INTO SKU VALUES ('GC_C2' ,'GC01', '������ ��Ʈ�κ�����',525);
INSERT INTO SKU VALUES ('GC_C3' ,'GC01', '������ �������θ�',525);
INSERT INTO SKU VALUES ('GC_C4' ,'GC01', '������ �ǳӹ��͸�',525);
INSERT INTO SKU VALUES ('GC_C5' ,'GC01', '������ ȭ��Ʈ���ڸ�',525);

INSERT INTO SKU VALUES ('GC_C6' , 'GC01','������ �ٴҶ��',525);
INSERT INTO SKU VALUES ('GC_C7' , 'GC01','������ ���ڸ�',525);
INSERT INTO SKU VALUES ('GC_C8' , 'GC01','������ �����',525);

INSERT INTO SKU VALUES ('GC_C9' , 'GC01','������ ���ũ��',525);
INSERT INTO SKU VALUES ('GC_C10' , 'GC01', '������ ��Ʈ����Ĩ��',525);
INSERT INTO SKU VALUES ('GC_C11' ,'GC01', '������ �ٴҶ��',525);
INSERT INTO SKU VALUES ('GC_C12' ,'GC01', '������ �����',525);
INSERT INTO SKU VALUES ('GC_C13' ,'GC01', '������ ���ڸ�',525);

INSERT INTO SKU VALUES ('GC_C14' ,'GC01', '������ �ٴҶ��',525);
INSERT INTO SKU VALUES ('GC_C15' ,'GC01', '������ ���ڸ�',525);
INSERT INTO SKU VALUES ('GC_C16' , 'GC01','������ ��Ű��ũ����',525);
INSERT INTO SKU VALUES ('GC_C17' ,'GC01', '������ ����ũ�����',525);
INSERT INTO SKU VALUES ('GC_C18' , 'GC01','������ ��λ�����',525);

INSERT INTO SKU VALUES ('GC_C19' , 'GC01', '�ζ��� �ǽ�Ÿġ����',525);
INSERT INTO SKU VALUES ('GC_C20' , 'GC01','�ζ��� ����ûũ��',525);
INSERT INTO SKU VALUES ('GC_C21' ,'GC01', '�ζ��� �ٴҶ��',525); -------�� 


INSERT INTO SKU VALUES ('GC_J1' ,'GC02', '������ �Ҵٸ�', 280);
INSERT INTO SKU VALUES ('GC_J2' , 'GC02','������ ��ũ��', 280);
INSERT INTO SKU VALUES ('GC_J3' , 'GC02','������ �ް���', 280);
INSERT INTO SKU VALUES ('GC_J4' ,'GC02', '������ ���ڸ�', 280);
INSERT INTO SKU VALUES ('GC_J5' , 'GC02','������ �����', 280);

INSERT INTO SKU VALUES ('GC_J6' ,'GC02', '�ֹ��� �Ҵٸ�', 280);
INSERT INTO SKU VALUES ('GC_J7' , 'GC02','�ֹ��� ���ڸ�', 280);
INSERT INTO SKU VALUES ('GC_J8' , 'GC02','�ֹ��� �����Ƹ�', 280);
INSERT INTO SKU VALUES ('GC_J9' ,'GC02', '�ֹ��� û������', 280);
INSERT INTO SKU VALUES ('GC_J10' , 'GC02','�ֹ��� �ݶ��', 280);

INSERT INTO SKU VALUES ('GC_J11' , 'GC02', '�͵� �Ҵٸ�', 280);
INSERT INTO SKU VALUES ('GC_J12' , 'GC02','�͵� ������ġ��', 280);
INSERT INTO SKU VALUES ('GC_J13' , 'GC02','�͵� ���ڸ�', 280);
INSERT INTO SKU VALUES ('GC_J14' ,'GC02', '�͵� ���ڸ�', 280);
INSERT INTO SKU VALUES ('GC_J15' ,'GC02', '�͵� ������', 280);

INSERT INTO SKU VALUES ('GC_J16' ,'GC02', '�������� ���ְ��ָ�', 280);
INSERT INTO SKU VALUES ('GC_J17' ,'GC02', '�������� �鵵��', 280);
INSERT INTO SKU VALUES ('GC_J18' , 'GC02','�������� û������', 280);
INSERT INTO SKU VALUES ('GC_J19' ,'GC02', '�������� ���ڸ�', 280);
INSERT INTO SKU VALUES ('GC_J20' ,'GC02', '�������� �����', 280);

INSERT INTO SKU VALUES ('GC_J21' ,'GC02', '��Ű��Ű ���ڸ�', 280);
INSERT INTO SKU VALUES ('GC_J22' , 'GC02','��Ű��Ű �����', 280);
INSERT INTO SKU VALUES ('GC_J23' , 'GC02','��Ű��Ű �ٴҶ��', 280);
INSERT INTO SKU VALUES ('GC_J24' ,'GC02', '��Ű��Ű ���θӽ��ϸ�', 280);
INSERT INTO SKU VALUES ('GC_J25' , 'GC02','��Ű��Ű �Ҵٸ�', 280);----------------���޹�


INSERT INTO SKU VALUES ('GC_B1' ,'GC03', '��ũ���� �����', 140);
INSERT INTO SKU VALUES ('GC_B2' ,'GC03', '��ũ���� �����Ƹ�', 140);
INSERT INTO SKU VALUES ('GC_B3' , 'GC03', '��ũ���� �����', 140);
INSERT INTO SKU VALUES ('GC_B4' ,'GC03', '��ũ���� ������', 140);
INSERT INTO SKU VALUES ('GC_B5' ,'GC03', '��ũ���� ��������', 140);

INSERT INTO SKU VALUES ('GC_B6' , 'GC03','�ҽ��� ��������', 140);
INSERT INTO SKU VALUES ('GC_B7' , 'GC03','�ҽ��� ���ξ��ø�', 140);
INSERT INTO SKU VALUES ('GC_B8' ,'GC03', '�ҽ��� ���ڸ�', 140);
INSERT INTO SKU VALUES ('GC_B9' ,'GC03', '�ҽ��� �ٳ�����', 140);
INSERT INTO SKU VALUES ('GC_B10' ,'GC03', '�ҽ��� ���ڸ�', 140);

INSERT INTO SKU VALUES ('GC_B11' ,'GC03', '���ڹ� ���ڸ�', 140);
INSERT INTO SKU VALUES ('GC_B12' ,'GC03', '���ڹ� �����', 140);
INSERT INTO SKU VALUES ('GC_B13' , 'GC03','���ڹ� ��������', 140);

INSERT INTO SKU VALUES ('GC_B14' ,'GC03', '�޷γ� �����', 140);
INSERT INTO SKU VALUES ('GC_B15' ,'GC03', '�޷γ� �޷и�', 140);
INSERT INTO SKU VALUES ('GC_B16' ,'GC03', '�޷γ� �ٳ�����', 140);
INSERT INTO SKU VALUES ('GC_B17' , 'GC03','�޷γ� ���ڳӸ�', 140);

INSERT INTO SKU VALUES ('GC_B18' , 'GC03','������ ������', 140);
INSERT INTO SKU VALUES ('GC_B19' ,'GC03', '������ �ٳ�����', 140);
INSERT INTO SKU VALUES ('GC_B20' ,'GC03', '������ ġ��ũ����', 140);
INSERT INTO SKU VALUES ('GC_B21' , 'GC03','������ ���', 140);
INSERT INTO SKU VALUES ('GC_B22' ,'GC03', '������ ���ڳӸ�', 140); -------------------���� 


INSERT INTO SKU VALUES ('GC_P1' , 'GC04','���Դ� �ٴҶ��', 2450);
INSERT INTO SKU VALUES ('GC_P2' , 'GC04','���Դ� ���ũ��', 2450);
INSERT INTO SKU VALUES ('GC_P3' ,'GC04', '���Դ� ������', 2450);
INSERT INTO SKU VALUES ('GC_P4' ,'GC04', '���Դ� ���ڸ�', 2450);
INSERT INTO SKU VALUES ('GC_P5' ,'GC04', '���Դ� �����', 2450);

INSERT INTO SKU VALUES ('GC_P6' ,'GC04', '���ѷ� �ٴҶ��', 2450);
INSERT INTO SKU VALUES ('GC_P7' ,'GC04', '���ѷ� ������', 2450);
INSERT INTO SKU VALUES ('GC_P8' , 'GC04','���ѷ� ���ڸ�', 2450);
INSERT INTO SKU VALUES ('GC_P9' , 'GC04','���ѷ� �����', 2450);
INSERT INTO SKU VALUES ('GC_P10' ,'GC04', '���ѷ� �ǽ�Ÿġ����', 2450);

INSERT INTO SKU VALUES ('GC_P11' ,'GC04', '�ϰմ��� �ٴҶ�', 2450);
INSERT INTO SKU VALUES ('GC_P12' ,'GC04', '�ϰմ��� ���ݸ��Ƹ��', 2450);
INSERT INTO SKU VALUES ('GC_P13' ,'GC04', '�ϰմ��� ����� ��Ű�ƶ�', 2450);
INSERT INTO SKU VALUES ('GC_P14' ,'GC04', '�ϰմ��� ��Ʈ�κ��� ġ������ũ', 2450);
INSERT INTO SKU VALUES ('GC_P15' ,'GC04', '�ϰմ��� Ű������', 2450);

INSERT INTO SKU VALUES ('GC_P16' , 'GC04','ȣ�θ���', 2450);
INSERT INTO SKU VALUES ('GC_P17' ,'GC04', 'ü������', 2450);
INSERT INTO SKU VALUES ('GC_P18' , 'GC04','��������', 2450);  ------------------------�� 




















