CREATE USER C##TEAM IDENTIFIED BY TEAM;

GRANT CONNECT, RESOURCE, DBA TO C##TEAM;


CREATE TABLE CUSTOMER( --유저
 CUS_PHONE VARCHAR2(20) PRIMARY KEY, --핸드폰번호
 CUS_POINT NUMBER NOT NULL --포인트 (주문금액의 10프로씩 적립)
);

UPDATE CUSTOMER SET CUS_POINT WHERE 총금액*10 -----???????

INSERT INTO CUSTOMER VALUES('01029235057' , );  
SELECT * FROM CUSTOMER

----------------------------------------------------------------------------------------------

CREATE TABLE ORDERS( --주문
 ORDER_ID VARCHAR2(20) PRIMARY KEY, --주문번호
 CUS_PHONE VARCHAR2(20) REFERENCES CUSTOMER(CUS_PHONE), --핸드폰번호
 ORDER_DATE DATE --날짜
);

CREATE SEQUENCE ORDERS_SEQ;
DROP SEQUENCE ORDERS_SEQ;

INSERT INTO ORDERS VALUES ('JB ' || ORDERS_SEQ.NEXTVAL, '01029235057' , SYSDATE)

SELECT * FROM ORDERS
DELETE FROM ORDERS WHERE CUS_PHONE = '01029235057'

------------------------------------------------------------------------------------------------------

CREATE TABLE GOODS( --판매상품(아이스크림)
 GOODS_ID VARCHAR2(20) PRIMARY KEY, --상품코드
 GOODS_NAME VARCHAR2(20) NOT NULL, --상품이름
 STOCK_QTY NUMBER , --재고수량
 GOODS_PRICE NUMBER  --소비자가격
);

INSERT INTO GOODS VALUES('GC01_SP01' , '구구콘' , 0 ,1500);
INSERT INTO GOODS VALUES('GC01_SP02' , '빵빠레' , 0 ,1500); 
INSERT INTO GOODS VALUES('GC01_SP03' , '슈퍼콘' , 0 ,1500); 
INSERT INTO GOODS VALUES('GC01_SP04' , '월드콘' , 0 ,1500); 
INSERT INTO GOODS VALUES('GC01_SP05' , '부라보콘',0 ,1500);  --콘

INSERT INTO GOODS VALUES('GC02_SP01' , '뽕따', 0 ,800);
INSERT INTO GOODS VALUES('GC02_SP02' , '설레임', 0 ,800);
INSERT INTO GOODS VALUES('GC02_SP03' , '탱크보이',0 ,800);
INSERT INTO GOODS VALUES('GC02_SP04' , '빠삐코', 0 ,800);
INSERT INTO GOODS VALUES('GC02_SP05' , '폴라포', 0 ,800); --쭈쭈바

INSERT INTO GOODS VALUES('GC03_SP01' , '스크류바', 0 ,400);
INSERT INTO GOODS VALUES('GC03_SP02' , '죠스바', 0 ,400);
INSERT INTO GOODS VALUES('GC03_SP03' , '수박바', 0 ,400);
INSERT INTO GOODS VALUES('GC03_SP04' , '메로나', 0 ,400);
INSERT INTO GOODS VALUES('GC03_SP05' , '보석바', 0 ,400); --막대

INSERT INTO GOODS VALUES('GC04_SP01' , '투게더', 0 ,7000);
INSERT INTO GOODS VALUES('GC04_SP02' , '나뚜루', 0 ,7000);
INSERT INTO GOODS VALUES('GC04_SP03' , '하겐다즈', 0 ,7000);
INSERT INTO GOODS VALUES('GC04_SP04' , '호두마루', 0 ,7000);
INSERT INTO GOODS VALUES('GC04_SP05' , '체리마루', 0 ,7000); --컵 

UPDATE GOODS SET STOCK_QTY=STOCK_QTY +30 --맨 처음물량 들어왔을때 
SELECT * FROM GOODS

--재고량이 5개 이하일시 자동으로 발주하게끔 하려면 어떻게 해야하는지....

------------------------------------------------------------------------------------------------

CREATE TABLE ORDER_LINE( --주문상세
 ORDER_LINE_ID VARCHAR2(20) PRIMARY KEY, --주문상세코드
 ORDER_ID VARCHAR2(20) REFERENCES ORDERS(ORDER_ID), --주문번호
 GOODS_ID VARCHAR2(20) REFERENCES GOODS(GOODS_ID), --상품코드
 ORDER_PRICE NUMBER , --가격
 ORDER_QTY NUMBER --주문수량
);

INSERT INTO ORDER_LINE VALUES(JS);

-----------------------------------------------------------------------------------------------

CREATE TABLE DEALER( --거래처
 DEALER_ID VARCHAR2(20) PRIMARY KEY, --거래처코드
 DEALER_NAME VARCHAR2(30) NOT NULL, --거래처이름
 DEALER_ADDR VARCHAR2(30) , --주소
 DEALER_PHONE VARCHAR2(20)  --연락처
);

INSERT INTO DEALER VALUES('GC01', '빙그레', '서울특별시 중구', '02-2022-6000');
INSERT INTO DEALER VALUES('GC02', '해태제과', '서울특별시 용산구', '02-709-7766');
INSERT INTO DEALER VALUES('GC03', '롯데제과', '서울특별시 영등포구', '02-2670-6114');
INSERT INTO DEALER VALUES('GC04', '라벨리', '전라남도 화순', '061-372-0151');

SELECT * FROM DEALER;

-----------------------------------------------------------------------------------------------

CREATE TABLE IB( --발주
 IB_ID VARCHAR2(20) PRIMARY KEY, --발주코드
 DEALER_ID VARCHAR2(20) REFERENCES DEALER(DEALER_ID), --거래처코드
 IB_DATE DATE DEFAULT SYSDATE --발주날짜 
);

--발주코드 시퀀스
CREATE SEQUENCE IB_SEQ;
INSERT INTO IB VALUES ('BJ ' || IB_SEQ.NEXTVAL, 'GC01', SYSDATE);
INSERT INTO IB VALUES ('BJ ' || IB_SEQ.NEXTVAL, 'GC02', SYSDATE);
INSERT INTO IB VALUES ('BJ ' || IB_SEQ.NEXTVAL, 'GC03', SYSDATE);
INSERT INTO IB VALUES ('BJ ' || IB_SEQ.NEXTVAL, 'GC04', SYSDATE);
                                                                    ---- 동시에 주문해야하는데 어떻게 해야할지???                                                  
DROP SEQUENCE IB_SEQ;
DELETE FROM IB WHERE DEALER_ID = 'GC01'

SELECT * FROM IB;

---------------------------------------------------------------------------------------------------------

CREATE TABLE IB_LINE( --발주상세
 IB_LINE_ID VARCHAR2(20) PRIMARY KEY, --발주상세코드   
 IB_ID VARCHAR2(20) REFERENCES IB(IB_ID), -- 발주코드
 GOODS_ID VARCHAR2(20) REFERENCES GOODS(GOODS_ID), --상품코드
 IB_QTY NUMBER , --발주수량
 IB_PRICE NUMBER  --발주가격 
);

CREATE SEQUENCE IB_LINE_SEQ;
DROP SEQUENCE IB_LINE_SEQ;

SELECT * FROM IB_LINE;

INSERT INTO IB_LINE VALUES(???,'BJ ' || IB_LINE_SEQ.NEXTVAL ,'GC01_SP01' ,30,750);   ------발주상세코드도 시퀀스????? 
DELETE FROM IB_LINE WHERE GOODS_ID = 'GC01_SP01'

----------------------------------------------------------------------------------------------------------

CREATE TABLE ICE( --취급상품
 ICE_ID VARCHAR2(30) PRIMARY KEY, --거래처취급상품
 DEALER_ID VARCHAR2(20) REFERENCES DEALER(DEALER_ID), --거래처코드
 DEALER_PRICE NUMBER , --거래처가격
 ICE_TYPE VARCHAR2(20) NOT NULL, --종류
 ICE_QTY NUMBER --거래처 자체 수량
);

--거래처가격은 발주가격의 30%로 책정함 
INSERT INTO ICE VALUES('GP01', 'GC01', 525, '콘', 999); 
INSERT INTO ICE VALUES('GP02', 'GC02', 280, '쭈쭈바', 999);
INSERT INTO ICE VALUES('GP03', 'GC03', 140, '막대', 999);
INSERT INTO ICE VALUES('GP04', 'GC04', 2450, '컵', 999);

SELECT * FROM ICE; 

UPDATE ICE SET ICE_QTY=ICE_QTY-30  -- 맨 처음 주문할때 
UPDATE ICE SET ICE_QTY=ICE_QTY-10 WHERE DEALER_ID = 'GC02'

COMMIT;



