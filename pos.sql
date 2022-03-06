CREATE USER C##TEAM IDENTIFIED BY TEAM;

GRANT CONNECT, RESOURCE, DBA TO C##TEAM;


CREATE TABLE CUSTOMER( --유저
 CUS_PHONE VARCHAR2(20) PRIMARY KEY, --핸드폰번호
 --CUS_POINT NUMBER NOT NULL --포인트 (주문금액의 10프로씩 적립)
);

UPDATE CUSTOMER SET CUS_POINT WHERE 총금액*10 -----???????

INSERT INTO CUSTOMER VALUES('01029235057' , );  
SELECT * FROM CUSTOMER

----------------------------------------------------------------------------------------------

CREATE TABLE ORDERS( --주문
 ORDER_ID VARCHAR2(50) PRIMARY KEY, --주문번호
 CUS_PHONE VARCHAR2(20) REFERENCES CUSTOMER(CUS_PHONE), --핸드폰번호
 ORDER_DATE DATE --날짜
);

DROP TABLE ORDERS

INSERT INTO ORDERS VALUES ('', '01029235057', SYSDATE)

SELECT * FROM ORDERS
DELETE FROM ORDERS WHERE CUS_PHONE = '01029235057'

------------------------------------------------------------------------------------------------------

CREATE TABLE GOODS( --판매상품(아이스크림) 
 GOODS_ID VARCHAR2(20) PRIMARY KEY, --상품코드
 GOODS_NAME VARCHAR2(20) NOT NULL, --상품이름
 STOCK_QTY NUMBER , --재고수량
 GOODS_PRICE NUMBER  --소비자가격         
);  -----------------콘솔창에 상품코드는 안보이게 하는 방법???

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

------------------------------------------------------------------------------------------------

CREATE TABLE ORDER_LINE( --주문상세
 ORDER_LINE_ID VARCHAR2(30) PRIMARY KEY, --주문상세코드
 ORDER_ID VARCHAR2(50) REFERENCES ORDERS(ORDER_ID), --주문번호
 GOODS_ID VARCHAR2(20) REFERENCES GOODS(GOODS_ID), --상품코드
 ORDER_PRICE NUMBER , --가격
 ORDER_QTY NUMBER --주문수량
);

SELECT * FROM ORDER_LINE
DROP TABLE ORDER_LINE
INSERT INTO ORDER_LINE VALUES('JS ' || ORDER_LINE_SEQ.NEXTVAL,, 'GC01_SP01', 1500, 1);

CREATE SEQUENCE ORDER_LINE_SEQ;
DROP SEQUENCE ORDER_LINE_SEQ; 

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

INSERT INTO IB_LINE VALUES('BS ' || IB_LINE_SEQ.NEXTVAL, ,'GC01_SP01',30,750);   ------발주상세코드도 시퀀스????? 
DELETE FROM IB_LINE WHERE GOODS_ID = 'GC01_SP01'

----------------------------------------------------------------------------------------------------------

CREATE TABLE SKU( --취급상품
 SKU_ID VARCHAR2(30) PRIMARY KEY, --거래처취급상품
 DEALER_ID VARCHAR2(20) REFERENCES DEALER(DEALER_ID), --거래처코드
 SKU_PRICE NUMBER , --거래처가격
 SKU_TYPE VARCHAR2(20) NOT NULL --종류
);

--ICE_QTY NUMBER --거래처 자체 수량

--거래처가격은 발주가격의 30%로 책정함 
INSERT INTO SKU VALUES('GP01', 'GC01', 525, '콘'); 
INSERT INTO SKU VALUES('GP02', 'GC02', 280, '쭈쭈바');
INSERT INTO SKU VALUES('GP03', 'GC03', 140, '막대');
INSERT INTO SKU VALUES('GP04', 'GC04', 2450, '컵');

SELECT * FROM SKU; 

--UPDATE ICE SET ICE_QTY=ICE_QTY-30  -- 맨 처음 주문할때 
--UPDATE ICE SET ICE_QTY=ICE_QTY-10 WHERE DEALER_ID = 'GC02'

DROP TABLE SKU

---------------------------------------------------------------------------------------------
CREATE TABLE ICE ( --아이스크림전체
 SKU_TYPE VARCHAR2(20) PRIMARY KEY,-- 아이스크림 종류
 ICE_ID VARCHAR2(20) NOT NULL --아이스크림 이름
); 

INSERT INTO ICE VALUES ('콘' , '구구콘 마다가스카르바닐라맛');
INSERT INTO ICE VALUES ('콘' , '구구콘 오리지널맛');
INSERT INTO ICE VALUES ('콘' , '구구콘 스트로베리맛');
INSERT INTO ICE VALUES ('콘' , '구구콘 화이트초코맛');
INSERT INTO ICE VALUES ('콘' , '구구콘 피넛버터맛');

INSERT INTO ICE VALUES ('콘' , '빵빠레 바닐라맛');
INSERT INTO ICE VALUES ('콘' , '빵빠레 초코맛');
INSERT INTO ICE VALUES ('콘' , '빵빠레 딸기맛');

INSERT INTO ICE VALUES ('콘' , '슈퍼콘 쿠앤크맛');
INSERT INTO ICE VALUES ('콘' , '슈퍼콘 민트초코칩맛');
INSERT INTO ICE VALUES ('콘' , '슈퍼콘 바닐라맛');
INSERT INTO ICE VALUES ('콘' , '슈퍼콘 딸기맛');
INSERT INTO ICE VALUES ('콘' , '슈퍼콘 초코맛');

INSERT INTO ICE VALUES ('콘' , '월드콘 바닐라맛');
INSERT INTO ICE VALUES ('콘' , '월드콘 초코맛');
INSERT INTO ICE VALUES ('콘' , '월드콘 쿠키앤크림맛');
INSERT INTO ICE VALUES ('콘' , '월드콘 애플크럼블맛');
INSERT INTO ICE VALUES ('콘' , '월드콘 까마로사딸기맛');

INSERT INTO ICE VALUES ('콘' , '부라보콘 피스타치오맛');
INSERT INTO ICE VALUES ('콘' , '부라보콘 초코청크맛');
INSERT INTO ICE VALUES ('콘' , '부라보콘 바닐라맛');

INSERT INTO ICE VALUES ('쭈쭈바' , '');
INSERT INTO ICE VALUES ('쭈쭈바' , '');
INSERT INTO ICE VALUES ('쭈쭈바' , '');
INSERT INTO ICE VALUES ('쭈쭈바' , '');
INSERT INTO ICE VALUES ('쭈쭈바' , '');

INSERT INTO ICE VALUES ('막대' , '스크류바 딸기맛');
INSERT INTO ICE VALUES ('막대' , '스크류바 복숭아맛');
INSERT INTO ICE VALUES ('막대' , '스크류바 사과맛');
INSERT INTO ICE VALUES ('막대' , '스크류바 포도맛');
INSERT INTO ICE VALUES ('막대' , '스크류바 오렌지맛');

INSERT INTO ICE VALUES ('막대' , '죠스바 오렌지맛');
INSERT INTO ICE VALUES ('막대' , '죠스바 파인애플맛');
INSERT INTO ICE VALUES ('막대' , '죠스바 수박맛');
INSERT INTO ICE VALUES ('막대' , '죠스바 바나나맛');
INSERT INTO ICE VALUES ('막대' , '죠스바 초코맛');

INSERT INTO ICE VALUES ('막대' , '수박바 수박맛');
INSERT INTO ICE VALUES ('막대' , '수박바 딸기맛');
INSERT INTO ICE VALUES ('막대' , '수박바 오레오맛');

INSERT INTO ICE VALUES ('막대' , '메로나 딸기맛');
INSERT INTO ICE VALUES ('막대' , '메로나 메론맛');
INSERT INTO ICE VALUES ('막대' , '메로나 바나나맛');
INSERT INTO ICE VALUES ('막대' , '메로나 코코넛맛');

INSERT INTO ICE VALUES ('막대' , '보석바 우유맛');
INSERT INTO ICE VALUES ('막대' , '보석바 바나나맛');
INSERT INTO ICE VALUES ('막대' , '보석바 치즈크림맛');
INSERT INTO ICE VALUES ('막대' , '보석바 밤맛');
INSERT INTO ICE VALUES ('막대' , '보석바 코코넛맛');


INSERT INTO ICE VALUES ('컵' , '');
INSERT INTO ICE VALUES ('컵' , '');
INSERT INTO ICE VALUES ('컵' , '');
INSERT INTO ICE VALUES ('컵' , '');
INSERT INTO ICE VALUES ('컵' , '');


SELECT * FROM ICE 
DROP TABLE ICE 

COMMIT;





