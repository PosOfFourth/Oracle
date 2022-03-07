CREATE TABLE CUSTOMER( --유저
 CUS_ID VARCHAR2(20 )PRIMARY KEY, --아이디 (핸드폰번호)
 CUS_PWD VARCHAR2(20) NOT NULL --패스워드(뒷번호 네자리)
);

INSERT INTO CUSTOMER VALUES('010-2923-5057' , '5057');  
SELECT * FROM CUSTOMER

DELETE FROM CUSTOMER WHERE CUS_PHONE = '010-2923-5057'
DROP TABLE CUSTOMER

COMMIT
----------------------------------------------------------------------------------------------

CREATE TABLE ORDERS( --주문
 ORDER_ID VARCHAR2(50) PRIMARY KEY, --주문번호
 CUS_ID VARCHAR2(20) REFERENCES CUSTOMER(CUS_ID), --주문자아이디 
 ORDER_DATE DATE --날짜
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

CREATE TABLE GOODS( --판매상품(아이스크림) 
 GOODS_ID VARCHAR2(20) PRIMARY KEY, --상품코드
 GOODS_NAME VARCHAR2(50) NOT NULL, --상품이름
 STOCK_QTY NUMBER , --재고수량
 GOODS_PRICE NUMBER  --소비자가격         
);  -----------------콘솔창에 상품코드는 안보이게 하는 방법???

INSERT INTO GOODS VALUES('GC_C1','구구콘 마다가스카르바닐라맛' , 0 ,1500);


UPDATE GOODS SET STOCK_QTY=STOCK_QTY +30 --맨 처음물량 들어왔을때 
SELECT * FROM GOODS
DELETE FROM GOODS WHERE STOCK_QTY = 30

DROP TABLE GOODS


------------------------------------------------------------------------------------------------

CREATE TABLE ORDER_LINE( --주문상세
 ORDER_LINE_ID VARCHAR2(30) PRIMARY KEY, --주문상세코드
 ORDER_ID VARCHAR2(50) REFERENCES ORDERS(ORDER_ID), --주문번호
 GOODS_ID VARCHAR2(20) REFERENCES GOODS(GOODS_ID), --상품코드
 GOODS_PRICE NUMBER,--가격
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

CREATE TABLE DEALER( --거래처
 DEALER_ID VARCHAR2(20) PRIMARY KEY, --거래처코드
 DEALER_TYPE VARCHAR2(20) NOT NULL, --거래처종류
 DEALER_NAME VARCHAR2(30) NOT NULL, --거래처이름
 DEALER_ADDR VARCHAR2(30), --주소
 DEALER_PHONE VARCHAR2(20)  --연락처

);

INSERT INTO DEALER VALUES('GC01', '콘', '빙그레', '서울특별시 중구', '02-2022-6000');
INSERT INTO DEALER VALUES('GC02', '쭈쭈바', '해태제과', '서울특별시 용산구', '02-709-7766');
INSERT INTO DEALER VALUES('GC03', '막대','롯데제과', '서울특별시 영등포구', '02-2670-6114');
INSERT INTO DEALER VALUES('GC04', '컵','라벨리', '전라남도 화순', '061-372-0151');

SELECT * FROM DEALER
DROP TABLE DEALER
-----------------------------------------------------------------------------------------------

CREATE TABLE IB( --발주
 IB_ID VARCHAR2(20) PRIMARY KEY, --발주코드
 DEALER_ID VARCHAR2(20) REFERENCES DEALER(DEALER_ID), --거래처코드
 IB_DATE DATE DEFAULT SYSDATE --발주날짜 
);

--발주코드 시퀀스
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
                                                                    ---- 동시에 주문해야하는데 어떻게 해야할지???                                                  

DELETE FROM IB WHERE DEALER_ID = 'GC01'

SELECT * FROM IB;
DROP TABLE IB

---------------------------------------------------------------------------------------------------------

CREATE TABLE IB_LINE( --발주상세
 IB_LINE_ID VARCHAR2(20) PRIMARY KEY, --발주상세코드   
 IB_ID VARCHAR2(20) REFERENCES IB(IB_ID), -- 발주코드
 GOODS_ID VARCHAR2(20) REFERENCES GOODS(GOODS_ID), --상품코드
 IB_QTY NUMBER , --발주수량
 IB_PRICE NUMBER  --발주가격 
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

INSERT INTO IB_LINE VALUES('BS ' || IB_LINE_SEQ.NEXTVAL,'BJ ' || IB_SEQ.CURRVAL ,'GC_C1',30,750);   ------발주상세코드도 시퀀스????? 
DELETE FROM IB_LINE WHERE GOODS_ID = 'GC01_SP01'

----------------------------------------------------------------------------------------------------------

CREATE TABLE SKU( --취급상품
 SKU_ID VARCHAR2(20) PRIMARY KEY, --고유코드 = 상품코드 
 DEALER_ID VARCHAR2(20) REFERENCES DEALER(DEALER_ID), --거래처코드
 SKU_NAME VARCHAR2(50) NOT NULL, --거래처취급상품이름 
 SKU_PRICE NUMBER --거래처가격
);

SELECT * FROM SKU; 

DROP TABLE SKU
COMMIT;

--ICE_QTY NUMBER --거래처 자체 수량

--거래처가격은 발주가격의 30%로 책정함 
INSERT INTO SKU VALUES('GC_C1','GC01','구구콘 마다가스카르바닐라맛', 525);
INSERT INTO SKU VALUES ('GC_C2' ,'GC01', '구구콘 스트로베리맛',525);
INSERT INTO SKU VALUES ('GC_C3' ,'GC01', '구구콘 오리지널맛',525);
INSERT INTO SKU VALUES ('GC_C4' ,'GC01', '구구콘 피넛버터맛',525);
INSERT INTO SKU VALUES ('GC_C5' ,'GC01', '구구콘 화이트초코맛',525);

INSERT INTO SKU VALUES ('GC_C6' , 'GC01','빵빠레 바닐라맛',525);
INSERT INTO SKU VALUES ('GC_C7' , 'GC01','빵빠레 초코맛',525);
INSERT INTO SKU VALUES ('GC_C8' , 'GC01','빵빠레 딸기맛',525);

INSERT INTO SKU VALUES ('GC_C9' , 'GC01','슈퍼콘 쿠앤크맛',525);
INSERT INTO SKU VALUES ('GC_C10' , 'GC01', '슈퍼콘 민트초코칩맛',525);
INSERT INTO SKU VALUES ('GC_C11' ,'GC01', '슈퍼콘 바닐라맛',525);
INSERT INTO SKU VALUES ('GC_C12' ,'GC01', '슈퍼콘 딸기맛',525);
INSERT INTO SKU VALUES ('GC_C13' ,'GC01', '슈퍼콘 초코맛',525);

INSERT INTO SKU VALUES ('GC_C14' ,'GC01', '월드콘 바닐라맛',525);
INSERT INTO SKU VALUES ('GC_C15' ,'GC01', '월드콘 초코맛',525);
INSERT INTO SKU VALUES ('GC_C16' , 'GC01','월드콘 쿠키앤크림맛',525);
INSERT INTO SKU VALUES ('GC_C17' ,'GC01', '월드콘 애플크럼블맛',525);
INSERT INTO SKU VALUES ('GC_C18' , 'GC01','월드콘 까마로사딸기맛',525);

INSERT INTO SKU VALUES ('GC_C19' , 'GC01', '부라보콘 피스타치오맛',525);
INSERT INTO SKU VALUES ('GC_C20' , 'GC01','부라보콘 초코청크맛',525);
INSERT INTO SKU VALUES ('GC_C21' ,'GC01', '부라보콘 바닐라맛',525); -------콘 


INSERT INTO SKU VALUES ('GC_J1' ,'GC02', '빠삐코 소다맛', 280);
INSERT INTO SKU VALUES ('GC_J2' , 'GC02','빠삐코 밀크맛', 280);
INSERT INTO SKU VALUES ('GC_J3' , 'GC02','빠삐코 달고나맛', 280);
INSERT INTO SKU VALUES ('GC_J4' ,'GC02', '빠삐코 초코맛', 280);
INSERT INTO SKU VALUES ('GC_J5' , 'GC02','빠삐코 딸기맛', 280);

INSERT INTO SKU VALUES ('GC_J6' ,'GC02', '주물러 소다맛', 280);
INSERT INTO SKU VALUES ('GC_J7' , 'GC02','주물러 수박맛', 280);
INSERT INTO SKU VALUES ('GC_J8' , 'GC02','주물러 복숭아맛', 280);
INSERT INTO SKU VALUES ('GC_J9' ,'GC02', '주물러 청포도맛', 280);
INSERT INTO SKU VALUES ('GC_J10' , 'GC02','주물러 콜라맛', 280);

INSERT INTO SKU VALUES ('GC_J11' , 'GC02', '뽕따 소다맛', 280);
INSERT INTO SKU VALUES ('GC_J12' , 'GC02','뽕따 레드피치맛', 280);
INSERT INTO SKU VALUES ('GC_J13' , 'GC02','뽕따 초코맛', 280);
INSERT INTO SKU VALUES ('GC_J14' ,'GC02', '뽕따 수박맛', 280);
INSERT INTO SKU VALUES ('GC_J15' ,'GC02', '뽕따 포도맛', 280);

INSERT INTO SKU VALUES ('GC_J16' ,'GC02', '젤루조아 제주감귤맛', 280);
INSERT INTO SKU VALUES ('GC_J17' ,'GC02', '젤루조아 백도맛', 280);
INSERT INTO SKU VALUES ('GC_J18' , 'GC02','젤루조아 청포도맛', 280);
INSERT INTO SKU VALUES ('GC_J19' ,'GC02', '젤루조아 초코맛', 280);
INSERT INTO SKU VALUES ('GC_J20' ,'GC02', '젤루조아 딸기맛', 280);

INSERT INTO SKU VALUES ('GC_J21' ,'GC02', '초키초키 초코맛', 280);
INSERT INTO SKU VALUES ('GC_J22' , 'GC02','초키초키 딸기맛', 280);
INSERT INTO SKU VALUES ('GC_J23' , 'GC02','초키초키 바닐라맛', 280);
INSERT INTO SKU VALUES ('GC_J24' ,'GC02', '초키초키 샤인머스켓맛', 280);
INSERT INTO SKU VALUES ('GC_J25' , 'GC02','초키초키 소다맛', 280);----------------쭈쭈바


INSERT INTO SKU VALUES ('GC_B1' ,'GC03', '스크류바 딸기맛', 140);
INSERT INTO SKU VALUES ('GC_B2' ,'GC03', '스크류바 복숭아맛', 140);
INSERT INTO SKU VALUES ('GC_B3' , 'GC03', '스크류바 사과맛', 140);
INSERT INTO SKU VALUES ('GC_B4' ,'GC03', '스크류바 포도맛', 140);
INSERT INTO SKU VALUES ('GC_B5' ,'GC03', '스크류바 오렌지맛', 140);

INSERT INTO SKU VALUES ('GC_B6' , 'GC03','죠스바 오렌지맛', 140);
INSERT INTO SKU VALUES ('GC_B7' , 'GC03','죠스바 파인애플맛', 140);
INSERT INTO SKU VALUES ('GC_B8' ,'GC03', '죠스바 수박맛', 140);
INSERT INTO SKU VALUES ('GC_B9' ,'GC03', '죠스바 바나나맛', 140);
INSERT INTO SKU VALUES ('GC_B10' ,'GC03', '죠스바 초코맛', 140);

INSERT INTO SKU VALUES ('GC_B11' ,'GC03', '수박바 수박맛', 140);
INSERT INTO SKU VALUES ('GC_B12' ,'GC03', '수박바 딸기맛', 140);
INSERT INTO SKU VALUES ('GC_B13' , 'GC03','수박바 오레오맛', 140);

INSERT INTO SKU VALUES ('GC_B14' ,'GC03', '메로나 딸기맛', 140);
INSERT INTO SKU VALUES ('GC_B15' ,'GC03', '메로나 메론맛', 140);
INSERT INTO SKU VALUES ('GC_B16' ,'GC03', '메로나 바나나맛', 140);
INSERT INTO SKU VALUES ('GC_B17' , 'GC03','메로나 코코넛맛', 140);

INSERT INTO SKU VALUES ('GC_B18' , 'GC03','보석바 우유맛', 140);
INSERT INTO SKU VALUES ('GC_B19' ,'GC03', '보석바 바나나맛', 140);
INSERT INTO SKU VALUES ('GC_B20' ,'GC03', '보석바 치즈크림맛', 140);
INSERT INTO SKU VALUES ('GC_B21' , 'GC03','보석바 밤맛', 140);
INSERT INTO SKU VALUES ('GC_B22' ,'GC03', '보석바 코코넛맛', 140); -------------------막대 


INSERT INTO SKU VALUES ('GC_P1' , 'GC04','투게더 바닐라맛', 2450);
INSERT INTO SKU VALUES ('GC_P2' , 'GC04','투게더 쿠앤크맛', 2450);
INSERT INTO SKU VALUES ('GC_P3' ,'GC04', '투게더 녹차맛', 2450);
INSERT INTO SKU VALUES ('GC_P4' ,'GC04', '투게더 초코맛', 2450);
INSERT INTO SKU VALUES ('GC_P5' ,'GC04', '투게더 딸기맛', 2450);

INSERT INTO SKU VALUES ('GC_P6' ,'GC04', '나뚜루 바닐라맛', 2450);
INSERT INTO SKU VALUES ('GC_P7' ,'GC04', '나뚜루 녹차맛', 2450);
INSERT INTO SKU VALUES ('GC_P8' , 'GC04','나뚜루 초코맛', 2450);
INSERT INTO SKU VALUES ('GC_P9' , 'GC04','나뚜루 딸기맛', 2450);
INSERT INTO SKU VALUES ('GC_P10' ,'GC04', '나뚜루 피스타치오맛', 2450);

INSERT INTO SKU VALUES ('GC_P11' ,'GC04', '하겐다즈 바닐라', 2450);
INSERT INTO SKU VALUES ('GC_P12' ,'GC04', '하겐다즈 초콜릿아몬드', 2450);
INSERT INTO SKU VALUES ('GC_P13' ,'GC04', '하겐다즈 브라우니 마키아또', 2450);
INSERT INTO SKU VALUES ('GC_P14' ,'GC04', '하겐다즈 스트로베리 치즈케이크', 2450);
INSERT INTO SKU VALUES ('GC_P15' ,'GC04', '하겐다즈 키위망고', 2450);

INSERT INTO SKU VALUES ('GC_P16' , 'GC04','호두마루', 2450);
INSERT INTO SKU VALUES ('GC_P17' ,'GC04', '체리마루', 2450);
INSERT INTO SKU VALUES ('GC_P18' , 'GC04','녹차마루', 2450);  ------------------------컵 




















