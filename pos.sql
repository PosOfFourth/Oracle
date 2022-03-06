CREATE USER C##TEAM IDENTIFIED BY TEAM;

GRANT CONNECT, RESOURCE, DBA TO C##TEAM;


CREATE TABLE CUSTOMER( --����
 CUS_PHONE VARCHAR2(20) PRIMARY KEY, --�ڵ�����ȣ
 --CUS_POINT NUMBER NOT NULL --����Ʈ (�ֹ��ݾ��� 10���ξ� ����)
);

UPDATE CUSTOMER SET CUS_POINT WHERE �ѱݾ�*10 -----???????

INSERT INTO CUSTOMER VALUES('01029235057' , );  
SELECT * FROM CUSTOMER

----------------------------------------------------------------------------------------------

CREATE TABLE ORDERS( --�ֹ�
 ORDER_ID VARCHAR2(50) PRIMARY KEY, --�ֹ���ȣ
 CUS_PHONE VARCHAR2(20) REFERENCES CUSTOMER(CUS_PHONE), --�ڵ�����ȣ
 ORDER_DATE DATE --��¥
);

DROP TABLE ORDERS

INSERT INTO ORDERS VALUES ('', '01029235057', SYSDATE)

SELECT * FROM ORDERS
DELETE FROM ORDERS WHERE CUS_PHONE = '01029235057'

------------------------------------------------------------------------------------------------------

CREATE TABLE GOODS( --�ǸŻ�ǰ(���̽�ũ��) 
 GOODS_ID VARCHAR2(20) PRIMARY KEY, --��ǰ�ڵ�
 GOODS_NAME VARCHAR2(20) NOT NULL, --��ǰ�̸�
 STOCK_QTY NUMBER , --������
 GOODS_PRICE NUMBER  --�Һ��ڰ���         
);  -----------------�ܼ�â�� ��ǰ�ڵ�� �Ⱥ��̰� �ϴ� ���???

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

------------------------------------------------------------------------------------------------

CREATE TABLE ORDER_LINE( --�ֹ���
 ORDER_LINE_ID VARCHAR2(30) PRIMARY KEY, --�ֹ����ڵ�
 ORDER_ID VARCHAR2(50) REFERENCES ORDERS(ORDER_ID), --�ֹ���ȣ
 GOODS_ID VARCHAR2(20) REFERENCES GOODS(GOODS_ID), --��ǰ�ڵ�
 ORDER_PRICE NUMBER , --����
 ORDER_QTY NUMBER --�ֹ�����
);

SELECT * FROM ORDER_LINE
DROP TABLE ORDER_LINE
INSERT INTO ORDER_LINE VALUES('JS ' || ORDER_LINE_SEQ.NEXTVAL,, 'GC01_SP01', 1500, 1);

CREATE SEQUENCE ORDER_LINE_SEQ;
DROP SEQUENCE ORDER_LINE_SEQ; 

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

INSERT INTO IB_LINE VALUES('BS ' || IB_LINE_SEQ.NEXTVAL, ,'GC01_SP01',30,750);   ------���ֻ��ڵ嵵 ������????? 
DELETE FROM IB_LINE WHERE GOODS_ID = 'GC01_SP01'

----------------------------------------------------------------------------------------------------------

CREATE TABLE SKU( --��޻�ǰ
 SKU_ID VARCHAR2(30) PRIMARY KEY, --�ŷ�ó��޻�ǰ
 DEALER_ID VARCHAR2(20) REFERENCES DEALER(DEALER_ID), --�ŷ�ó�ڵ�
 SKU_PRICE NUMBER , --�ŷ�ó����
 SKU_TYPE VARCHAR2(20) NOT NULL --����
);

--ICE_QTY NUMBER --�ŷ�ó ��ü ����

--�ŷ�ó������ ���ְ����� 30%�� å���� 
INSERT INTO SKU VALUES('GP01', 'GC01', 525, '��'); 
INSERT INTO SKU VALUES('GP02', 'GC02', 280, '���޹�');
INSERT INTO SKU VALUES('GP03', 'GC03', 140, '����');
INSERT INTO SKU VALUES('GP04', 'GC04', 2450, '��');

SELECT * FROM SKU; 

--UPDATE ICE SET ICE_QTY=ICE_QTY-30  -- �� ó�� �ֹ��Ҷ� 
--UPDATE ICE SET ICE_QTY=ICE_QTY-10 WHERE DEALER_ID = 'GC02'

DROP TABLE SKU

---------------------------------------------------------------------------------------------
CREATE TABLE ICE ( --���̽�ũ����ü
 SKU_TYPE VARCHAR2(20) PRIMARY KEY,-- ���̽�ũ�� ����
 ICE_ID VARCHAR2(20) NOT NULL --���̽�ũ�� �̸�
); 

INSERT INTO ICE VALUES ('��' , '������ ���ٰ���ī���ٴҶ��');
INSERT INTO ICE VALUES ('��' , '������ �������θ�');
INSERT INTO ICE VALUES ('��' , '������ ��Ʈ�κ�����');
INSERT INTO ICE VALUES ('��' , '������ ȭ��Ʈ���ڸ�');
INSERT INTO ICE VALUES ('��' , '������ �ǳӹ��͸�');

INSERT INTO ICE VALUES ('��' , '������ �ٴҶ��');
INSERT INTO ICE VALUES ('��' , '������ ���ڸ�');
INSERT INTO ICE VALUES ('��' , '������ �����');

INSERT INTO ICE VALUES ('��' , '������ ���ũ��');
INSERT INTO ICE VALUES ('��' , '������ ��Ʈ����Ĩ��');
INSERT INTO ICE VALUES ('��' , '������ �ٴҶ��');
INSERT INTO ICE VALUES ('��' , '������ �����');
INSERT INTO ICE VALUES ('��' , '������ ���ڸ�');

INSERT INTO ICE VALUES ('��' , '������ �ٴҶ��');
INSERT INTO ICE VALUES ('��' , '������ ���ڸ�');
INSERT INTO ICE VALUES ('��' , '������ ��Ű��ũ����');
INSERT INTO ICE VALUES ('��' , '������ ����ũ�����');
INSERT INTO ICE VALUES ('��' , '������ ��λ�����');

INSERT INTO ICE VALUES ('��' , '�ζ��� �ǽ�Ÿġ����');
INSERT INTO ICE VALUES ('��' , '�ζ��� ����ûũ��');
INSERT INTO ICE VALUES ('��' , '�ζ��� �ٴҶ��');

INSERT INTO ICE VALUES ('���޹�' , '');
INSERT INTO ICE VALUES ('���޹�' , '');
INSERT INTO ICE VALUES ('���޹�' , '');
INSERT INTO ICE VALUES ('���޹�' , '');
INSERT INTO ICE VALUES ('���޹�' , '');

INSERT INTO ICE VALUES ('����' , '��ũ���� �����');
INSERT INTO ICE VALUES ('����' , '��ũ���� �����Ƹ�');
INSERT INTO ICE VALUES ('����' , '��ũ���� �����');
INSERT INTO ICE VALUES ('����' , '��ũ���� ������');
INSERT INTO ICE VALUES ('����' , '��ũ���� ��������');

INSERT INTO ICE VALUES ('����' , '�ҽ��� ��������');
INSERT INTO ICE VALUES ('����' , '�ҽ��� ���ξ��ø�');
INSERT INTO ICE VALUES ('����' , '�ҽ��� ���ڸ�');
INSERT INTO ICE VALUES ('����' , '�ҽ��� �ٳ�����');
INSERT INTO ICE VALUES ('����' , '�ҽ��� ���ڸ�');

INSERT INTO ICE VALUES ('����' , '���ڹ� ���ڸ�');
INSERT INTO ICE VALUES ('����' , '���ڹ� �����');
INSERT INTO ICE VALUES ('����' , '���ڹ� ��������');

INSERT INTO ICE VALUES ('����' , '�޷γ� �����');
INSERT INTO ICE VALUES ('����' , '�޷γ� �޷и�');
INSERT INTO ICE VALUES ('����' , '�޷γ� �ٳ�����');
INSERT INTO ICE VALUES ('����' , '�޷γ� ���ڳӸ�');

INSERT INTO ICE VALUES ('����' , '������ ������');
INSERT INTO ICE VALUES ('����' , '������ �ٳ�����');
INSERT INTO ICE VALUES ('����' , '������ ġ��ũ����');
INSERT INTO ICE VALUES ('����' , '������ ���');
INSERT INTO ICE VALUES ('����' , '������ ���ڳӸ�');


INSERT INTO ICE VALUES ('��' , '');
INSERT INTO ICE VALUES ('��' , '');
INSERT INTO ICE VALUES ('��' , '');
INSERT INTO ICE VALUES ('��' , '');
INSERT INTO ICE VALUES ('��' , '');


SELECT * FROM ICE 
DROP TABLE ICE 

COMMIT;





