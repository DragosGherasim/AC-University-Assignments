-- Active: 1697283830777@@127.0.0.1@3306
CREATE TABLE dept (
 deptno              DECIMAL(2) NOT NULL,
 dname               VARCHAR(14),
 loc                 VARCHAR(13),

 CONSTRAINT dept_primary_key PRIMARY KEY (deptno)) ENGINE=INNODB;

INSERT INTO dept VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO dept VALUES (20,'RESEARCH','DALLAS');
INSERT INTO dept VALUES (30,'SALES','CHICAGO');
INSERT INTO dept VALUES (40,'OPERATIONS','BOSTON');

CREATE TABLE emp (
 empno               DECIMAL(4) NOT NULL,
 ename               VARCHAR(10),
 job                 VARCHAR(9),
 mgr                 DECIMAL(4),
 hiredate            DATE,
 sal                 DECIMAL(7,2),
 comm                DECIMAL(7,2),
 deptno              DECIMAL(2) NOT NULL,
 target              DECIMAL(6),
 CONSTRAINT emp_deptno_fk FOREIGN KEY (deptno) REFERENCES dept(deptno),
 CONSTRAINT emp_mgr_fk FOREIGN KEY (mgr) REFERENCES emp(empno),
 CONSTRAINT emp_empno_pk PRIMARY KEY (empno)) ENGINE=INNODB;

INSERT INTO emp VALUES (7839,'KING','PRESIDENT',NULL,STR_TO_DATE('17-NOV-81', '%d-%M-%Y'),5000,NULL,10,NULL);
INSERT INTO emp VALUES (7698,'BLAKE','MANAGER',7839,STR_TO_DATE('1-MAY-81', '%d-%M-%Y'),2850,NULL,30,NULL);
INSERT INTO emp VALUES (7782,'CLARK','MANAGER',7839,STR_TO_DATE('9-JUN-81', '%d-%M-%Y'),2450,NULL,10,NULL);
INSERT INTO emp VALUES (7566,'JONES','MANAGER',7839,STR_TO_DATE('2-APR-81', '%d-%M-%Y'),2975,NULL,20,NULL);
INSERT INTO emp VALUES (7654,'MARTIN','SALESMAN',7698,STR_TO_DATE('28-SEP-81', '%d-%M-%Y'),1250,1389,30,27776);
INSERT INTO emp VALUES (7499,'ALLEN','SALESMAN',7698,STR_TO_DATE('20-FEB-81', '%d-%M-%Y'),1600,394,30,7871);
INSERT INTO emp VALUES (7844,'TURNER','SALESMAN',7698,STR_TO_DATE('8-SEP-81', '%d-%M-%Y'),1500,2903,30,58051);
INSERT INTO emp VALUES (7900,'JAMES','CLERK',7698,STR_TO_DATE('3-DEC-81', '%d-%M-%Y'),950,NULL,30,NULL);
INSERT INTO emp VALUES (7521,'WARD','SALESMAN',7698,STR_TO_DATE('22-FEB-81', '%d-%M-%Y'),1250,495,30,9890);
INSERT INTO emp VALUES (7902,'FORD','ANALYST',7566,STR_TO_DATE('3-DEC-81', '%d-%M-%Y'),3000,NULL,20,NULL);
INSERT INTO emp VALUES (7369,'SMITH','CLERK',7902,STR_TO_DATE('17-DEC-80', '%d-%M-%Y'),800,NULL,20,NULL);
INSERT INTO emp VALUES (7788,'SCOTT','ANALYST',7566,STR_TO_DATE('09-DEC-82', '%d-%M-%Y'),3000,NULL,20,NULL);
INSERT INTO emp VALUES (7876,'ADAMS','CLERK',7788,STR_TO_DATE('12-JAN-83', '%d-%M-%Y'),1100,NULL,20,NULL);
INSERT INTO emp VALUES (7934,'MILLER','CLERK',7782,STR_TO_DATE('23-JAN-82', '%d-%M-%Y'),1300,NULL,10,NULL);

CREATE TABLE bonus (
 ename               	VARCHAR(10),
 job                 	VARCHAR(9),
 sal                	DECIMAL(6),
 comm                   DECIMAL(7,2),
 compensat  	        DECIMAL(6)) ENGINE=INNODB;

CREATE TABLE salgrade (
 grade               DECIMAL,
 losal               DECIMAL,
 hisal               DECIMAL) ENGINE=INNODB;

INSERT INTO salgrade VALUES (1,700,1200);
INSERT INTO salgrade VALUES (2,1201,1400);
INSERT INTO salgrade VALUES (3,1401,2000);
INSERT INTO salgrade VALUES (4,2001,3000);
INSERT INTO salgrade VALUES (5,3001,9999);

CREATE TABLE dummy (
 dummy               DECIMAL ) ENGINE=INNODB;

INSERT INTO dummy VALUES (0);

CREATE TABLE customer (
 custid              DECIMAL(6) NOT NULL /*AUTO_INCREMENT*/,
 name                VARCHAR(45),
 address             VARCHAR(40),
 city                VARCHAR(30),
 state               VARCHAR(2),
 zip                 VARCHAR(9),
 area                DECIMAL(3),
 phone               VARCHAR(9),
 repid               DECIMAL(4) NOT NULL,
 creditlimit         DECIMAL(9,2),
 comments            LONG,
 CONSTRAINT customer_custid_pk PRIMARY KEY (custid),
 CONSTRAINT customer_custid_ck CHECK (custid > 0)) ENGINE=INNODB;

CREATE TABLE ord (
 ordid               DECIMAL(4) NOT NULL /*AUTO_INCREMENT*/,
 commplan            VARCHAR(1),
 custid              DECIMAL(6) NOT NULL,
 total               DECIMAL(8,2),
 CONSTRAINT ord_total_ck CHECK (total >= 0),
 CONSTRAINT ord_custid_fk FOREIGN KEY (custid) REFERENCES customer (custid),
 CONSTRAINT ord_ordid_pk PRIMARY KEY (ordid)) ENGINE=INNODB;

CREATE TABLE transfer (
 ordid               DECIMAL(4) NOT NULL,
 orderdate           DATE,
 shipdate            DATE) ENGINE=INNODB;

CREATE TABLE item  (
 ordid               DECIMAL(4) NOT NULL,
 itemid              DECIMAL(4) NOT NULL,
 prodid              DECIMAL(6),
 actualprice         DECIMAL(8,2),
 qty                 DECIMAL(8),
 itemtot             DECIMAL(8,2),
 CONSTRAINT item_ordid_fk FOREIGN KEY (ordid) REFERENCES ord (ordid),
 CONSTRAINT item_ordid_itemid_pk PRIMARY KEY (ordid,itemid)) ENGINE=INNODB;

CREATE TABLE product (
 prodid              DECIMAL (6) /*AUTO_INCREMENT*/,
 descrip             VARCHAR (30),
 CONSTRAINT prodid_pk PRIMARY KEY (prodid)) ENGINE=INNODB;

CREATE TABLE price (
 prodid              DECIMAL (6) NOT NULL,
 stdqty	             DECIMAL(6),
 stdprice            DECIMAL (8,2),
 minprice            DECIMAL (8,2),
 startdate           DATE,
 enddate             DATE) ENGINE=INNODB;

INSERT INTO customer (ZIP, STATE, REPID, PHONE, NAME, CUSTID, CREDITLIMIT,
  CITY, AREA, ADDRESS, COMMENTS)
VALUES ('96711', 'CA', '7844', '598-6609',
 'JOCKSPORTS',
 '100', '6000', 'BELMONT', '415', '345 VIEWRIDGE',
 'Very friendly people to work with -- sales rep likes to be called Mike.');
INSERT INTO customer (ZIP, STATE, REPID, PHONE, NAME, CUSTID, CREDITLIMIT,
  CITY, AREA, ADDRESS, COMMENTS)
VALUES ('94061', 'CA', '7521', '368-1223',
 'TKB SPORT SHOP',
 '101', '10000', 'REDWOOD CITY', '415', '490 BOLI RD.',
 'Rep called 5/8 about change in order - contact shipping.');
INSERT INTO customer (ZIP, STATE, REPID, PHONE, NAME, CUSTID, CREDITLIMIT,
  CITY, AREA, ADDRESS, COMMENTS)
VALUES ('95133', 'CA', '7654', '644-3341',
 'VOLLYRITE',
 '102', '28000', 'BURLINGAME', '415', '9722 HAMILTON',
 'Company doing heavy promotion beginning 10/89. Prepare for large orders during
 winter.');
INSERT INTO customer (ZIP, STATE, REPID, PHONE, NAME, CUSTID, CREDITLIMIT,
  CITY, AREA, ADDRESS, COMMENTS)
VALUES ('97544', 'CA', '7521', '677-9312',
 'JUST TENNIS',
 '103', '3000', 'BURLINGAME', '415', 'HILLVIEW MALL',
 'Contact rep about new line of tennis rackets.');
INSERT INTO customer (ZIP, STATE, REPID, PHONE, NAME, CUSTID, CREDITLIMIT,
  CITY, AREA, ADDRESS, COMMENTS)
VALUES ('93301', 'CA', '7499', '996-2323',
 'EVERY MOUNTAIN',
 '104', '10000', 'CUPERTINO', '408', '574 SURRY RD.',
 'Customer with high market share (23%) due to aggressive advertising.');
INSERT INTO customer (ZIP, STATE, REPID, PHONE, NAME, CUSTID, CREDITLIMIT,
  CITY, AREA, ADDRESS, COMMENTS)
VALUES ('91003', 'CA', '7844', '376-9966',
 'K + T SPORTS',
 '105', '47000', 'SANTA CLARA', '408', '3476 EL PASEO',
 'Tends to order large amounts of merchandise at once. Accounting is considering
 raising their credit limit. Usually pays on time.');
INSERT INTO customer (ZIP, STATE, REPID, PHONE, NAME, CUSTID, CREDITLIMIT,
  CITY, AREA, ADDRESS, COMMENTS)
VALUES ('94301', 'CA', '7521', '364-9777',
 'SHAPE UP',
 '106', '9500', 'PALO ALTO', '415', '908 SEQUOIA',
 'Support intensive. Orders small amounts (< 800) of merchandise at a time.');
INSERT INTO customer (ZIP, STATE, REPID, PHONE, NAME, CUSTID, CREDITLIMIT,
  CITY, AREA, ADDRESS, COMMENTS)
VALUES ('93301', 'CA', '7499', '967-4398',
 'WOMENS SPORTS',
 '107', '10000', 'SUNNYVALE', '408', 'VALCO VILLAGE',
 'First sporting goods store geared exclusively towards women. Unusual promotion
al style and very willing to take chances towards new products!');
INSERT INTO customer (ZIP, STATE, REPID, PHONE, NAME, CUSTID, CREDITLIMIT,
  CITY, AREA, ADDRESS, COMMENTS)
VALUES ('55649', 'MN', '7844', '566-9123',
 'NORTH WOODS HEALTH AND FITNESS SUPPLY CENTER',
 '108', '8000', 'HIBBING', '612', '98 LONE PINE WAY', '');

INSERT INTO ord (total, ordid, custid, commplan) VALUES (101.4, '610', '101', 'A');
INSERT INTO ord (total, ordid, custid, commplan) VALUES ('45', '611', '102', 'B');
INSERT INTO ord (total, ordid, custid, commplan) VALUES ('5860', '612', '104', 'C');
INSERT INTO ord (total, ordid, custid, commplan) VALUES (2.4, '601', '106', 'A');
INSERT INTO ord (total, ordid, custid, commplan) VALUES ('56', '602', '102', 'B');
INSERT INTO ord (total, ordid, custid, commplan) VALUES ('698', '604', '106', 'A');
INSERT INTO ord (total, ordid, custid, commplan) VALUES ('8324', '605', '106', 'A');
INSERT INTO ord (total, ordid, custid, commplan) VALUES (3.4, '606', '100', 'A');
INSERT INTO ord (total, ordid, custid, commplan) VALUES (97.5, '609', '100', 'B');
INSERT INTO ord (total, ordid, custid, commplan) VALUES (5.6, '607', '104', 'C');
INSERT INTO ord (total, ordid, custid, commplan) VALUES (35.2, '608', '104', 'C');
INSERT INTO ord (total, ordid, custid, commplan) VALUES ('224', '603', '102', '');
INSERT INTO ord (total, ordid, custid, commplan) VALUES ('4450', '620', '100', '');
INSERT INTO ord (total, ordid, custid, commplan) VALUES ('6400', '613', '108', '');
INSERT INTO ord (total, ordid, custid, commplan) VALUES ('23940','614', '102', '');
INSERT INTO ord (total, ordid, custid, commplan) VALUES ('764', '616', '103', '');
INSERT INTO ord (total, ordid, custid, commplan) VALUES ('1260', '619', '104', '');
INSERT INTO ord (total, ordid, custid, commplan) VALUES ('42120', '617', '105', '');
INSERT INTO ord (total, ordid, custid, commplan) VALUES ('710', '615', '107', '');
INSERT INTO ord (total, ordid, custid, commplan) VALUES (3510.5, '618', '102', 'A');
INSERT INTO ord (total, ordid, custid, commplan) VALUES ('730', '621', '100', 'A');

INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('15-JAN-86', '%d-%M-%Y'), '610', STR_TO_DATE('07-JAN-86', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('20-JAN-87', '%d-%M-%Y'), '611', STR_TO_DATE('11-JAN-87', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('25-JAN-87', '%d-%M-%Y'), '612', STR_TO_DATE('15-JAN-87', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('30-MAY-86', '%d-%M-%Y'), '601', STR_TO_DATE('01-MAY-86', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('20-JUN-86', '%d-%M-%Y'), '602', STR_TO_DATE('05-JUN-86', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('30-JUN-86', '%d-%M-%Y'), '604', STR_TO_DATE('15-JUN-86', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('30-JUL-86', '%d-%M-%Y'), '605', STR_TO_DATE('14-JUL-86', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('30-JUL-86', '%d-%M-%Y'), '606', STR_TO_DATE('14-JUL-86', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('15-AUG-86', '%d-%M-%Y'), '609', STR_TO_DATE('01-AUG-86', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('28-JUL-86', '%d-%M-%Y'), '607', STR_TO_DATE('18-JUL-86', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('25-JUL-86', '%d-%M-%Y'), '608', STR_TO_DATE('15-JUL-86', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('25-JUN-86', '%d-%M-%Y'), '603', STR_TO_DATE('05-JUN-86', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('27-MAR-87', '%d-%M-%Y'), '620', STR_TO_DATE('12-MAR-87', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('18-FEB-87', '%d-%M-%Y'), '613', STR_TO_DATE('01-FEB-87', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('17-FEB-87', '%d-%M-%Y'), '614', STR_TO_DATE('01-FEB-87', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('19-FEB-87', '%d-%M-%Y'), '616', STR_TO_DATE('03-FEB-87', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('24-FEB-87', '%d-%M-%Y'), '619', STR_TO_DATE('10-FEB-87', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('03-MAR-87', '%d-%M-%Y'), '617', STR_TO_DATE('05-FEB-87', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('16-FEB-87', '%d-%M-%Y'), '615', STR_TO_DATE('01-FEB-87', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('06-MAR-87', '%d-%M-%Y'), '618', STR_TO_DATE('15-FEB-87', '%d-%M-%Y'));
INSERT INTO transfer (shipdate, ordid, orderdate) VALUES (STR_TO_DATE('01-APR-87', '%d-%M-%Y'), '621', STR_TO_DATE('15-MAR-87', '%d-%M-%Y'));

INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('1', '100890', '610', '58', '3', '58');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('1', '100861', '611', '45', '1', '45');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('100', '100860', '612', '3000', '1', '30');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('1', '200376', '601', 2.4, '1', 2.4);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('20', '100870', '602', '56', '1', 2.8);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('3', '100890', '604', '174', '1', '58');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('2', '100861', '604', '84', '2', '42');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('10', '100860', '604', '440', '3', '44');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('4', '100860', '603', '224', '2', '56');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('1', '100860', '610', '35', '1', '35');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('3', '100870', '610', 8.4, '2', 2.8);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('200', '200376', '613', '440', '4', 2.2);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('444', '100860', '614', '15540', '1', '35');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('1000', '100870', '614', '2800', '2', 2.8);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('20', '100861', '612', '810', '2', 40.5);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('150', '101863', '612', '1500', '3', '10');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('10', '100860', '620', '350', '1', '35');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('1000', '200376', '620', '2400', '2', 2.4);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('500', '102130', '620', '1700', '3', 3.4);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('100', '100871', '613', '560', '1', 5.6);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('200', '101860', '613', '4800', '2', '24');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('150', '200380', '613', '600', '3', '4');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('100', '102130', '619', '340', '3', 3.4);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('100', '100861', '617', '4500', '2', '45');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('1000', '100871', '614', '5600', '3', 5.6);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('10', '100861', '616', '450', '1', '45');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('50', '100870', '616', '140', '2', 2.8);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('2', '100890', '616', '116', '3', '58');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('10', '102130', '616', '34', '4', 3.4);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('10', '200376', '616', '24', '5', 2.4);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('100', '200380', '619', '400', '1', '4');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('100', '200376', '619', '240', '2', 2.4);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('4', '100861', '615', '180', '1', '45');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('1', '100871', '607', 5.6, '1', 5.6);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('100', '100870', '615', '280', '2', 2.8);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('500', '100870', '617', '1400', '3', 2.8);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('500', '100871', '617', '2800', '4', 5.6);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('500', '100890', '617', '29000', '5', '58');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('100', '101860', '617', '2400', '6', '24');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('100', '102130', '617', '340', '8', 3.4);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('200', '200376', '617', '480', '9', 2.4);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('300', '200380', '617', '1200', '10', '4');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('5', '100870', '609', 12.5, '2', 2.5);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('1', '100890', '609', '50', '3', '50');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('23', '100860', '618', '805', '1', '35');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('50', '100861', '618', 2255.5, '2', 45.11);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('10', '100870', '618', '450', '3', '45');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('10', '100861', '621', '450', '1', '45');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('100', '100870', '621', '280', '2', 2.8);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('50', '100871', '615', '250', '3', '5');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('1', '101860', '608', '24', '1', '24');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('2', '100871', '608', 11.2, '2', 5.6);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('1', '100861', '609', '35', '1', '35');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('1', '102130', '606', 3.4, '1', 3.4);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('100', '100861', '605', '4500', '1', '45');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('500', '100870', '605', '1400', '2', 2.8);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('5', '100890', '605', '290', '3', '58');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('50', '101860', '605', '1200', '4', '24');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('100', '101863', '605', '900', '5', '9');
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('10', '102130', '605', '34', '6', 3.4);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('100', '100871', '612', '550', '4', 5.5);
INSERT INTO item (qty, prodid, ordid, itemtot, itemid, actualprice) VALUES ('50', '100871', '619', '280', '4', 5.6);

INSERT INTO price (stdqty,stdprice, startdate, prodid, minprice, enddate) VALUES (0, '4.8', STR_TO_DATE('01-JAN-85', '%d-%M-%Y'), '100871', '3.2', STR_TO_DATE('01-DEC-85', '%d-%M-%Y'));
INSERT INTO price (stdqty,stdprice, startdate, prodid, minprice, enddate) VALUES (0, '58', STR_TO_DATE('01-JAN-85', '%d-%M-%Y'), '100890', '46.4', NULL);
INSERT INTO price (stdqty,stdprice, startdate, prodid, minprice, enddate) VALUES (0, '54', STR_TO_DATE('01-JUN-84', '%d-%M-%Y'), '100890', '40.5', STR_TO_DATE('31-MAY-84', '%d-%M-%Y'));
INSERT INTO price (stdqty,stdprice, startdate, prodid, minprice, enddate) VALUES (0, '35', STR_TO_DATE('01-JUN-86', '%d-%M-%Y'), '100860', '28', NULL);
INSERT INTO price (stdqty,stdprice, startdate, prodid, minprice, enddate) VALUES (0, '32', STR_TO_DATE('01-JAN-86', '%d-%M-%Y'), '100860', '25.6', STR_TO_DATE('31-MAY-86', '%d-%M-%Y'));
INSERT INTO price (stdqty,stdprice, startdate, prodid, minprice, enddate) VALUES (0, '30', STR_TO_DATE('01-JAN-85', '%d-%M-%Y'), '100860', '24', STR_TO_DATE('31-DEC-85', '%d-%M-%Y'));
INSERT INTO price (stdqty,stdprice, startdate, prodid, minprice, enddate) VALUES (0, '45', STR_TO_DATE('01-JUN-86', '%d-%M-%Y'), '100861', '36', NULL);
INSERT INTO price (stdqty,stdprice, startdate, prodid, minprice, enddate) VALUES (0, '42', STR_TO_DATE('01-JAN-86', '%d-%M-%Y'), '100861', '33.6', STR_TO_DATE('31-MAY-86', '%d-%M-%Y'));
INSERT INTO price (stdqty,stdprice, startdate, prodid, minprice, enddate) VALUES (0, '39', STR_TO_DATE('01-JAN-85', '%d-%M-%Y'), '100861', '31.2', STR_TO_DATE('31-DEC-85', '%d-%M-%Y'));
INSERT INTO price (stdqty,stdprice, startdate, prodid, minprice, enddate) VALUES (0, '2.8', STR_TO_DATE('01-JAN-86', '%d-%M-%Y'), '100870', '2.4', NULL);
INSERT INTO price (stdqty,stdprice, startdate, prodid, minprice, enddate) VALUES (0, '2.4', STR_TO_DATE('01-JAN-85', '%d-%M-%Y'), '100870', '1.9', STR_TO_DATE('01-DEC-85', '%d-%M-%Y'));
INSERT INTO price (stdqty,stdprice, startdate, prodid, minprice, enddate) VALUES (0, '5.6', STR_TO_DATE('01-JAN-86', '%d-%M-%Y'), '100871', '4.8', NULL);
INSERT INTO price (stdqty,stdprice, startdate, prodid, minprice, enddate) VALUES (0, '24', STR_TO_DATE('15-FEB-85', '%d-%M-%Y'), '101860', '18', NULL);
INSERT INTO price (stdqty,stdprice, startdate, prodid, minprice, enddate) VALUES (0, '12.5', STR_TO_DATE('15-FEB-85', '%d-%M-%Y'), '101863', '9.4', NULL);
INSERT INTO price (stdqty,stdprice, startdate, prodid, minprice, enddate) VALUES (0, '3.4', STR_TO_DATE('18-AUG-85', '%d-%M-%Y'), '102130', '2.8', NULL);
INSERT INTO price (stdqty,stdprice, startdate, prodid, minprice, enddate) VALUES (0, '2.4', STR_TO_DATE('15-NOV-86', '%d-%M-%Y'), '200376', '1.75', NULL);
INSERT INTO price (stdqty,stdprice, startdate, prodid, minprice, enddate) VALUES (0, '4', STR_TO_DATE('15-NOV-86', '%d-%M-%Y'), '200380', '3.2', NULL);

CREATE INDEX price_index ON price(prodid, startdate);

INSERT INTO product(prodid, descrip) VALUES ('100860', 'ACE TENNIS RACKET I');
INSERT INTO product(prodid, descrip) VALUES ('100861', 'ACE TENNIS RACKET II');
INSERT INTO product(prodid, descrip) VALUES ('100870', 'ACE TENNIS BALLS-3 PACK');
INSERT INTO product(prodid, descrip) VALUES ('100871', 'ACE TENNIS BALLS-6 PACK');
INSERT INTO product(prodid, descrip) VALUES ('100890', 'ACE TENNIS NET');
INSERT INTO product(prodid, descrip) VALUES ('101860', 'SP TENNIS RACKET');
INSERT INTO product(prodid, descrip) VALUES ('101863', 'SP JUNIOR RACKET');
INSERT INTO product(prodid, descrip) VALUES ('102130', 'RH: "GUIDE TO TENNIS"');
INSERT INTO product(prodid, descrip) VALUES ('200376', 'SB ENERGY BAR-6 PACK');
INSERT INTO product(prodid, descrip) VALUES ('200380', 'SB VITA SNACK-6 PACK');

ALTER TABLE ord AUTO_INCREMENT = 622;
ALTER TABLE product AUTO_INCREMENT = 200381;
ALTER TABLE customer AUTO_INCREMENT = 109;

CREATE VIEW sales AS
SELECT Repid, ord.custid, customer.name custname, product.prodid,
descrip prodname, SUM(itemtot) amount
FROM ord, item, customer, product
WHERE ord.ordid = item.ordid
AND ord.custid = customer.custid
AND item.prodid = product.prodid
GROUP BY repid, ord.custid, name, product.prodid, descrip;

CREATE TABLE departments (
 department_id   DECIMAL(4) NOT NULL,
 department_name VARCHAR(30),
 manager_id      DECIMAL(6),
 location_id     DECIMAL(4),
 CONSTRAINT departmnets_department_id_pk PRIMARY KEY (department_id)) ENGINE=INNODB;

INSERT INTO departments VALUES (10,'Administration',200,1700);
INSERT INTO departments VALUES (20,'Marketing',201,1800);
INSERT INTO departments VALUES (50,'Shipping',124,1500);
INSERT INTO departments VALUES (60,'IT',103,1400);
INSERT INTO departments VALUES (80,'Sales',149,2500);
INSERT INTO departments VALUES (90,'Executive',100,1700);
INSERT INTO departments VALUES (110,'Accounting',205,1700);
INSERT INTO departments VALUES (190,'Contracting',null,1700);

CREATE TABLE employees (
 employee_id    DECIMAL(6) NOT NULL,
 first_name     VARCHAR(20),
 last_name      VARCHAR(25) NOT NULL,
 email          VARCHAR(25) NOT NULL,
 phone_decimal  VARCHAR(10),
 hire_date      DATE NOT NULL,
 job_id         VARCHAR(10) NOT NULL,
 salary         DECIMAL(8,2),
 commission_pct DECIMAL(2,2),
 manager_id     DECIMAL(6),
 department_id  DECIMAL(4),
 CONSTRAINT employees_manager_id_fk FOREIGN KEY (manager_id) REFERENCES employees (employee_id),
 CONSTRAINT employees_department_id_fk FOREIGN KEY (department_id) REFERENCES departments (department_id),
 CONSTRAINT employees_employee_id_pk PRIMARY KEY (employee_id),
 CONSTRAINT employees_last_name_uk UNIQUE(last_name)) ENGINE=INNODB;

INSERT INTO employees VALUES (100,'Steven'  ,'King'     ,' ','0722123401',STR_TO_DATE('17-JUN-1997', '%d-%M-%Y'),'AD_PRES'  ,24000,NULL,NULL,  90);
INSERT INTO employees VALUES (101,'Neena'   ,'Kochhar'  ,' ','0722123402',STR_TO_DATE('21-SEP-1989', '%d-%M-%Y'),'AD_VP'    ,17000,NULL, 100,  90);
INSERT INTO employees VALUES (102,'Lex'     ,'De Haan'  ,' ','0722123403',STR_TO_DATE('13-JAN-1993', '%d-%M-%Y'),'AD_VP'    ,17000,NULL, 100,  90);
INSERT INTO employees VALUES (103,'Alexander','Hunold'  ,' ','0722123404',STR_TO_DATE('03-JAN-1990', '%d-%M-%Y'),'IT_PROG'  , 9000,NULL, 102,  60);
INSERT INTO employees VALUES (104,'Bruce'   ,'Ernst'    ,' ','0722123405',STR_TO_DATE('21-MAY-1991', '%d-%M-%Y'),'IT_PROG'  , 6000,NULL, 103,  60);
INSERT INTO employees VALUES (107,'Diana'   ,'Lorentz'  ,' ','0722123406',STR_TO_DATE('07-FEB-1999', '%d-%M-%Y'),'IT_PROG'  , 4200,NULL, 103,  60);
INSERT INTO employees VALUES (124,'Kevin'   ,'Mourgos'  ,' ','0722123407',STR_TO_DATE('16-NOV-1999', '%d-%M-%Y'),'ST_MAN'   , 5800,NULL, 100,  50);
INSERT INTO employees VALUES (141,'Trenna'  ,'Rajs'     ,' ','0722123408',STR_TO_DATE('17-OCT-1995', '%d-%M-%Y'),'ST_CLERK' , 3500,NULL, 124,  50);
INSERT INTO employees VALUES (142,'Curtis'  ,'Davies'   ,' ','0722123409',STR_TO_DATE('29-JAN-1997', '%d-%M-%Y'),'ST_CLERK' , 3100,NULL, 124,  50);
INSERT INTO employees VALUES (143,'Randall' ,'Matos'    ,' ','0722123410',STR_TO_DATE('15-MAR-1998', '%d-%M-%Y'),'ST_CLERK' , 2600,NULL, 124,  50);
INSERT INTO employees VALUES (144,'Peter'   ,'Vargas'   ,' ','0722123411',STR_TO_DATE('09-JUL-1998', '%d-%M-%Y'),'ST_CLERK' , 2500,NULL, 124,  50);
INSERT INTO employees VALUES (149,'Eleni'   ,'Zlotkey'  ,' ','0722123412',STR_TO_DATE('29-JAN-2000', '%d-%M-%Y'),'SA_MAN'   ,10500, 0.2, 100,  80);
INSERT INTO employees VALUES (174,'Ellen'   ,'Abel'     ,' ','0722123413',STR_TO_DATE('11-MAY-1996', '%d-%M-%Y'),'SA_REP'   ,11000, 0.3, 149,  80);
INSERT INTO employees VALUES (176,'Jonathon','Taylor'   ,' ','0722123414',STR_TO_DATE('24-MAR-1998', '%d-%M-%Y'),'SA_REP'   , 8600, 0.2, 149,  80);
INSERT INTO employees VALUES (178,'Kimberly','Grant'    ,' ','0722123415',STR_TO_DATE('24-MAY-1999', '%d-%M-%Y'),'SA_REP'   , 7000,0.15, 149,NULL);
INSERT INTO employees VALUES (200,'Jennifer','Whalen'   ,' ','0722123416',STR_TO_DATE('17-SEP-1987', '%d-%M-%Y'),'AD_ASST'  , 4400,NULL, 101,  10);
INSERT INTO employees VALUES (201,'Michael' ,'Hartstein',' ','0722123417',STR_TO_DATE('17-FEB-1996', '%d-%M-%Y'),'MK_MAN'   ,13000,NULL, 100,  20);
INSERT INTO employees VALUES (202,'Pat'     ,'Fay'      ,' ','0722123418',STR_TO_DATE('17-AUG-1997', '%d-%M-%Y'),'MK_REP'   , 6000,NULL, 201,  20);
INSERT INTO employees VALUES (205,'Shelley' ,'Higgins'  ,' ','0722123419',STR_TO_DATE('07-JUN-1994', '%d-%M-%Y'),'AC_MGR'   ,12000,NULL, 101, 110);
INSERT INTO employees VALUES (206,'William' ,'Gietz'    ,' ','0722123420',STR_TO_DATE('07-JUN-1994', '%d-%M-%Y'),'AC_ACCOUNT', 8300,NULL, 205, 110);

CREATE TABLE countries (
 country_id   CHAR(2) NOT NULL,
 country_name VARCHAR(40),
 region_id    DECIMAL) ENGINE=INNODB;

INSERT INTO countries VALUES ('CA','Canada',2);
INSERT INTO countries VALUES ('DE','Germany',1);
INSERT INTO countries VALUES ('UK','United Kingdom',1);
INSERT INTO countries VALUES ('US','United States of America',2);

CREATE TABLE jobs (
 Job_id     VARCHAR(10) NOT NULL,
 Job_title  VARCHAR(35) NOT NULL,
 Min_salary DECIMAL(6),
 Max_salary DECIMAL(6)) ENGINE=INNODB;

INSERT INTO jobs VALUES ('AD_PRES'  ,'President'                   ,20000,40000);
INSERT INTO jobs VALUES ('AD_VP'    ,'Administration Vice President',15000,30000);
INSERT INTO jobs VALUES ('AD_ASST'  ,'Administartion Assistant'    , 3000, 6000);
INSERT INTO jobs VALUES ('AC_MGR'   ,'Accounting Manager'          , 8200,16000);
INSERT INTO jobs VALUES ('AC_ACCOUNT','Public Accountant'           , 4200, 9000);
INSERT INTO jobs VALUES ('SA_MAN'   ,'Sales Manager'               ,10000,20000);
INSERT INTO jobs VALUES ('SA_REP'   ,'Sales Represenatative'       , 6000,12000);
INSERT INTO jobs VALUES ('ST_MAN'   ,'Stock Manager'               , 5500, 8500);
INSERT INTO jobs VALUES ('ST_CLERK' ,'Stock Clerk'                 , 2000, 5000);
INSERT INTO jobs VALUES ('IT_PROG'  ,'Programmer'                  , 4000,10000);
INSERT INTO jobs VALUES ('MK_MAN'   ,'Marketing Manager'           , 9000,15000);
INSERT INTO jobs VALUES ('MK_REP'   ,'Marketing Representative'    , 4000, 9000);

CREATE TABLE job_grades(
 grade_level VARCHAR(3),
 lowest_sal  DECIMAL,
 highest_sal DECIMAL) ENGINE=INNODB;

INSERT INTO job_grades VALUES ('A', 1000, 2999);
INSERT INTO job_grades VALUES ('B', 3000, 5999);
INSERT INTO job_grades VALUES ('C', 6000, 9999);
INSERT INTO job_grades VALUES ('D',10000,14999);
INSERT INTO job_grades VALUES ('E',15000,24999);
INSERT INTO job_grades VALUES ('F',25000,40000);

CREATE TABLE job_history(
 employee_id   DECIMAL(6) NOT NULL,
 start_date    DATE NOT NULL,
 end_date      DATE NOT NULL,
 job_id        VARCHAR(10) NOT NULL,
 department_id DECIMAL(4)) ENGINE=INNODB;

INSERT INTO job_history VALUES (102,STR_TO_DATE('13-JAN-1993', '%d-%M-%Y'),STR_TO_DATE('24-JUL-1998', '%d-%M-%Y'),'IT_PROG'  , 60);
INSERT INTO job_history VALUES (101,STR_TO_DATE('21-SEP-1989', '%d-%M-%Y'),STR_TO_DATE('27-OCT-1993', '%d-%M-%Y'),'AC_ACCOUNT',110);
INSERT INTO job_history VALUES (101,STR_TO_DATE('28-OCT-1993', '%d-%M-%Y'),STR_TO_DATE('15-MAR-1997', '%d-%M-%Y'),'AC_MGR'   ,110);
INSERT INTO job_history VALUES (201,STR_TO_DATE('17-FEB-1996', '%d-%M-%Y'),STR_TO_DATE('19-DEC-1999', '%d-%M-%Y'),'MK_REP'   , 20);
INSERT INTO job_history VALUES (114,STR_TO_DATE('24-MAR-1998', '%d-%M-%Y'),STR_TO_DATE('31-DEC-1999', '%d-%M-%Y'),'ST_CLERK' , 50);
INSERT INTO job_history VALUES (122,STR_TO_DATE('01-JAN-1999', '%d-%M-%Y'),STR_TO_DATE('31-DEC-1999', '%d-%M-%Y'),'ST_CLERK' , 50);
INSERT INTO job_history VALUES (200,STR_TO_DATE('17-SEP-1987', '%d-%M-%Y'),STR_TO_DATE('17-JUN-1993', '%d-%M-%Y'),'AD_ASST'  , 90);
INSERT INTO job_history VALUES (176,STR_TO_DATE('24-MAR-1998', '%d-%M-%Y'),STR_TO_DATE('31-DEC-1998', '%d-%M-%Y'),'SA_REP'   , 80);
INSERT INTO job_history VALUES (176,STR_TO_DATE('01-JAN-1999', '%d-%M-%Y'),STR_TO_DATE('31-DEC-1999', '%d-%M-%Y'),'SA_MAN'   , 80);
INSERT INTO job_history VALUES (200,STR_TO_DATE('01-JUL-1994', '%d-%M-%Y'),STR_TO_DATE('31-DEC-1998', '%d-%M-%Y'),'AC_ACCOUNT', 90);

CREATE TABLE locations(
 location_id    DECIMAL(4) NOT NULL,
 street_address VARCHAR(40),
 postal_code    VARCHAR(12),
 city           VARCHAR(30) NOT NULL,
 state_province VARCHAR(25),
 country_id     CHAR(2)) ENGINE=INNODB;

INSERT INTO locations VALUES (1400,'2014 Jabberwockz Rd'                    ,'26192'    ,'Southlake'         ,'Texas'    ,'US');
INSERT INTO locations VALUES (1500,'2011 Interiors Blvd'                    ,'99236'    ,'South San Francisco','California','US');
INSERT INTO locations VALUES (1700,'2004 Charade Rd'                        ,'99189'    ,'Washington'        ,'Washington','US');
INSERT INTO locations VALUES (1800,'460 Bloor St. W.'                       ,'ON M5S 1X8','Toronto'           ,'Ontario'  ,'CA');
INSERT INTO locations VALUES (2500,'Magdalen Centre, The Oxford Science Park','OX9 9XB'  ,'Oxford'            ,'Oxford'   ,'UK');

CREATE TABLE regions(
region_id   DECIMAL NOT NULL,
region_name VARCHAR(25)) ENGINE=INNODB;

INSERT INTO regions VALUES (1,'Europe');
INSERT INTO regions VALUES (2,'America');
INSERT INTO regions VALUES (3,'Asia');
INSERT INTO regions VALUES (4,'Middle East and Africa');

COMMIT;
