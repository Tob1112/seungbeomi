INSERT INTO TRAFFIC_EXPENSES_MONTH (EMP_NO,YM, APPR_STATUS, REG_SEASON_TICKET_TOTAL, REG_OTHERS_TOTAL, REGULAR_TOTAL, IRREGULLAR_TOTAL, COMMUTATION_TOTAL, BIZ_FARE_TOTAL, GRAND_TOTAL, LAST_MONTH_GRAND_TOTAL, MODIFIER_ID, MODIFIED_DATE)
VALUES ('R258',  '200910',  '0',  300, 100, 600, 100, 1000, 10, 1010, 2000, 'son',  current_timestamp)

INSERT INTO TRAFFIC_EXPENSES_DAY (EMP_NO, YM, YMD, DIVISION, DAY_OF_WEEK, TRAIN_FARE, TRAIN_SECTION, BUS_FARE, BUS_SECTION, OTHER_REG_FARE, OTHER_REG_REM, OTHER_IRREG_FARE, OTHER_IRREG_REM, TAXI_FARE, HOTEL_RATE, REM, MODIFIER_ID, MODIFIED_DATE)
VALUES ('R258', '200910', TO_DATE('20091001', 'YYYYMMDD'), '0', '4', 560, 'yoho-kami', 180, 'yokou-yoko', 0, '', 0, '', 0, 0, 'bikou', 'son', CURRENT_TIMESTAMP)

INSERT INTO TRAFFIC_KIND (EMP_NO, YM, DIVISION, TRAFFIC_SEQ, DEPARTURE_POINT, ARRIVAL_POINT, START_DATE,END_DATE, FILE_NAME, FARE, BUS_CARD_CD, ONE_WAY_FARE_ON_CARD, ONE_WAY_FARE_REAL, MODIFIER_ID, MODIFIED_DATE)
VALUES ('R258', '200910', 'B', '1111', 'YOKOUDAI', 'YOKOHAMA', TO_DATE('20091001', 'YYYMMDD'), TO_DATE('20091031','YYYMMDD'), 'FILE_PATH', 200, '1010', 100, 86, 'son', CURRENT_TIMESTAMP);

-----
CREATE TABLE TRAFFIC_EXPENSES_MONTH(
	EMP_NO VARCHAR(4) NOT NULL,
	YM VARCHAR(6) NOT NULL,
	APPR_STATUS CHAR(1),
	REG_SEASON_TICKET_TOTAL INTEGER,
	REG_OTHERS_TOTAL INTEGER,
	REGULAR_TOTAL INTEGER,
	IRREGULLAR_TOTAL INTEGER,
	COMMUTATION_TOTAL INTEGER,
	BIZ_FARE_TOTAL INTEGER,
	GRAND_TOTAL INTEGER,
	LAST_MONTH_GRAND_TOTAL INTEGER,
	MODIFIER_ID VARCHAR(20),
	MODIFIED_DATE DATE,
	PRIMARY KEY(EMP_NO,YM)
);

-----

CREATE TABLE TRAFFIC_EXPENSES_DAY
(
	EMP_NO VARCHAR(4) NOT NULL,
	YM VARCHAR(6) NOT NULL,
	YMD DATE NOT NULL,
	DIVISION CHAR(1) NOT NULL,
	DAY_OF_WEEK CHAR(1),
	TRAIN_FARE INTEGER,
	TRAIN_SECTION VARCHAR(100),
	TRAIN_ROUND_FLG CHAR(1),
	BUS_FARE INTEGER,
	BUS_SECTION VARCHAR(100),
	BUS_ROUND_FLG CHAR(1),
	OTHER_REG_FARE INTEGER,
	OTHER_REG_REM VARCHAR(100),
	OTHER_IRREG_FARE INTEGER,
	OTHER_IRREG_REM VARCHAR(100),
	TAXI_FARE INTEGER,
	HOTEL_RATE INTEGER,
	REM VARCHAR(100),
	MODIFIER_ID VARCHAR(20),
	MODIFIED_DATE DATE,
	PRIMARY KEY(EMP_NO,YM,YMD,DIVISION)
);

------

CREATE TABLE TRAFFIC_KIND
(
	 EMP_NO VARCHAR(4) NOT NULL,
	 YM VARCHAR(6) NOT NULL,
	 DIVISION  CHAR(1) NOT NULL,
	 TRAFFIC_SEQ INTEGER NOT NULL,
	 DEPARTURE_POINT VARCHAR(20),
	 ARRIVAL_POINT VARCHAR(20),
	 START_DATE DATE,
	 END_DATE DATE,
	 FILE_NAME VARCHAR(100),
	 FARE INTEGER,
	 BUS_CARD_CD VARCHAR(4),
	 ONE_WAY_FARE_ON_CARD INTEGER,
	 ONE_WAY_FARE_REAL INTEGER,
	 MODIFIER_ID VARCHAR(20),
	 MODIFIED_DATE DATE,
	 PRIMARY KEY(EMP_NO,YM,DIVISION,TRAFFIC_SEQ)
);