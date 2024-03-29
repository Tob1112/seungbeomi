DROP TABLE COMPANY IF EXISTS;
DROP TABLE DEPT IF EXISTS;
DROP TABLE EMP IF EXISTS;
DROP TABLE TIMESHEET_MM IF EXISTS;
DROP TABLE TIMESHEET_DD IF EXISTS;
DROP TABLE FIX_TIME IF EXISTS;
DROP TABLE CODE IF EXISTS;
DROP TABLE CODE_DETAIL IF EXISTS;
DROP TABLE AUTH IF EXISTS;
DROP TABLE MESSAGE IF EXISTS;
DROP TABLE INIT_PARAMETER IF EXISTS;

CREATE TABLE COMPANY(COM_CODE VARCHAR(2) NOT NULL,COM_NAME VARCHAR(64),CONSTRAINT PK_COMPANY PRIMARY KEY(COM_CODE));
CREATE TABLE DEPT(COM_CODE VARCHAR(2) NOT NULL,DEPT_CODE VARCHAR(2) NOT NULL,REG_DAY DATE NOT NULL,DEL_DAY DATE,LATEST_FLAG CHAR(1) DEFAULT 'N',DEPT_NAME VARCHAR(64),UPPER_DEPT_CODE VARCHAR(2),CONSTRAINT PK_DEPT PRIMARY KEY(COM_CODE,DEPT_CODE,REG_DAY));
CREATE TABLE EMP(COM_CODE VARCHAR(2) NOT NULL,EMP_NO VARCHAR(4) NOT NULL,REG_DAY DATE NOT NULL,DEL_DAY DATE,LATEST_FLAG CHAR(1) DEFAULT 'N',DEPT_CODE VARCHAR(2) NOT NULL,EMAIL VARCHAR(64) NOT NULL,PASSWD VARCHAR(32) NOT NULL,HIRE_DAY DATE NOT NULL,RETIRE_DAY DATE,LAST_NAME VARCHAR(64) NOT NULL,FIRST_NAME VARCHAR(64) NOT NULL,CONSTRAINT PK_EMP PRIMARY KEY(COM_CODE,EMP_NO,REG_DAY));
CREATE TABLE TIMESHEET_MM(COM_CODE VARCHAR(2) NOT NULL,EMP_NO VARCHAR(4) NOT NULL,YYYYMM DATE NOT NULL,FIX_FLAG CHAR(1) DEFAULT 'N',STATUS_CODE VARCHAR(2) NOT NULL,ACTUAL_TIME_TOTAL NUMERIC(5,2),BREAK_TIME_TOTAL NUMERIC(5,2),OVER_TIME_TOTAL NUMERIC(5,2),NIGHT_TIME_TOTAL NUMERIC(5,2),HOLIDAY_TIME_TOTAL NUMERIC(5,2),LATE_TIME_TOTAL NUMERIC(5,2),EARLY_TIME_TOTAL NUMERIC(5,2),THIS_MONTH_PV_TOTAL NUMERIC(5,2),ABSENCE_DAYS_TOTAL NUMERIC(5,2),CONSTRAINT PK_TIMESHEET_MM PRIMARY KEY(COM_CODE,EMP_NO,YYYYMM));
CREATE TABLE TIMESHEET_DD(COM_CODE VARCHAR(2) NOT NULL,EMP_NO VARCHAR(4) NOT NULL,YYYYMM DATE NOT NULL,YYYYMMDD DATE NOT NULL,WORK_PATTERN_CODE VARCHAR(2) NOT NULL,FIX_TIME_NAME CHAR(1),WORK_START_TIME VARCHAR(4),WORK_END_TIME VARCHAR(4),WORK_TIME_TOTAL NUMERIC(5,2),LUNCH_BREAK_TIME VARCHAR(4),ETC_BREAK_TIME VARCHAR(4),BREAK_TIME_TOTAL NUMERIC(5,2),ACTUAL_TIME NUMERIC(5,2),OVER_WORK_TIME NUMERIC(5,2),NIGHT_WORK_TIME NUMERIC(5,2),HOLIDAY_WORK_TIME NUMERIC(5,2),LATE_TIME NUMERIC(5,2),EARLY_TIME NUMERIC(5,2),NOTE VARCHAR(512),CONSTRAINT PK_TIMESHEET_DD PRIMARY KEY(COM_CODE,EMP_NO,YYYYMM,YYYYMMDD));
CREATE TABLE FIX_TIME(COM_CODE VARCHAR(2) NOT NULL,EMP_NO VARCHAR(4) NOT NULL,YYYYMM DATE NOT NULL,FIX_TIME_NAME CHAR(1) NOT NULL,CLIENT_NAME VARCHAR(64),TIME_UNIT NUMERIC(5,2),WORK_START_TIME VARCHAR(4),WORK_END_TIME VARCHAR(4),LUNCH_START_TIME VARCHAR(4),LUNCH_END_TIME VARCHAR(4),CONSTRAINT PK_FIX_TIME PRIMARY KEY(COM_CODE,EMP_NO,YYYYMM,FIX_TIME_NAME));
CREATE TABLE CODE(CODE_TYPE VARCHAR(2) NOT NULL,CODE_NAME VARCHAR(64),CONSTRAINT PK_CODE PRIMARY KEY(CODE_TYPE));
CREATE TABLE CODE_DETAIL(CODE_TYPE VARCHAR(2),CODE_DETAIL VARCHAR(2),REG_DAY DATE,DEL_DAY DATE,LATEST_FLAG CHAR(1),CODE_DETAIL_NAME VARCHAR(64));
CREATE TABLE AUTH(ID VARCHAR(64),AUTH VARCHAR(64));
CREATE TABLE MESSAGE(MSG_TYPE CHAR(1),MSG_ID VARCHAR(4),MSG_BODY VARCHAR(512));
CREATE TABLE INIT_PARAMETER(PARAMETER_CODE VARCHAR(2) NOT NULL,START_DATE DATE,START_DATE_NAME VARCHAR(64),NOTE VARCHAR(512));

INSERT INTO COMPANY VALUES('01','\u30eb\u30a6\u30ac\u30eb\u30bd\u30f3');
INSERT INTO COMPANY VALUES('02','\u30b9\u30a4\u30fc\u30c8');
INSERT INTO COMPANY VALUES('03','\u30e9\u30fc\u30cb\u30f3\u30b0');
INSERT INTO DEPT VALUES('01','01','0009-04-01','0001-01-01','Y','\u958b\u767a\u90e8','');
INSERT INTO DEPT VALUES('01','02','0009-04-01','0001-01-01','Y','SI\u90e8','');
INSERT INTO DEPT VALUES('01','03','0009-04-01','0001-01-01','Y','\u7dcf\u52d9\u90e8','');
INSERT INTO DEPT VALUES('01','04','0009-04-01','0001-01-01','Y','\u55b6\u696d\u90e8','');
INSERT INTO DEPT VALUES('01','05','0009-04-01','0001-01-01','Y','\u7814\u4fee\u6240','');
INSERT INTO DEPT VALUES('01','06','0009-04-01','0001-01-01','Y','\u4f01\u753b\u4e8b\u696d\u63a8\u9032G','');
INSERT INTO DEPT VALUES('01','07','0009-04-01','0001-01-01','Y','\u958b\u767a1G','01');
INSERT INTO DEPT VALUES('01','08','0009-04-01','0001-01-01','Y','\u958b\u767a2G','01');
INSERT INTO DEPT VALUES('01','09','0009-04-01','0001-01-01','Y','\u958b\u767a3G','01');
INSERT INTO DEPT VALUES('01','10','0009-04-01','0001-01-01','Y','SI1\u90e8','02');
INSERT INTO DEPT VALUES('01','11','0009-04-01','0001-01-01','Y','SI2\u90e8','02');
INSERT INTO DEPT VALUES('01','12','0009-04-01','0001-01-01','Y','SI3\u90e8','02');
INSERT INTO DEPT VALUES('02','02','0009-04-01','0001-01-01','Y','\u958b\u767a1G','01');
INSERT INTO DEPT VALUES('02','03','0009-04-01','0001-01-01','Y','\u958b\u767a2G','01');
INSERT INTO EMP VALUES('01','100','2009-12-28',NULL,'Y','01','admin','21232f297a57a5a743894ae4a801fc3','2006-12-25',NULL,'son','admin');
INSERT INTO EMP VALUES('01','101','2009-12-28',NULL,'Y','01','user','ee11cbb19052e4b7aac0ca6c23ee','2006-12-25',NULL,'son','user');
INSERT INTO TIMESHEET_MM VALUES('01','101','2009-09-01','N','01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-01','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-02','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-03','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-04','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-05','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-06','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-07','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-08','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-09','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-10','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-11','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-12','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-13','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-14','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-15','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-16','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-17','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-18','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-19','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-20','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-21','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-22','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-23','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-24','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-25','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-26','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-27','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-28','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-29','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-30','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL);
INSERT INTO FIX_TIME VALUES('01','101','2009-09-01','A','suite',15,'0800','1800','1200','1300');
INSERT INTO FIX_TIME VALUES('01','101','2009-09-01','B','test',30,'0800','1900','1200','1300');
INSERT INTO FIX_TIME VALUES('01','101','2009-09-01','C','',NULL,NULL,NULL,NULL,NULL);
INSERT INTO CODE_DETAIL VALUES('1','01','2009-12-28',NULL,'Y','sakuseityu');
INSERT INTO CODE_DETAIL VALUES('1','02','2009-12-28',NULL,'Y','syouninmati');
INSERT INTO CODE_DETAIL VALUES('1','03','2009-12-28',NULL,'Y','syouninnzumi');
INSERT INTO CODE_DETAIL VALUES('1','04','2009-12-28',NULL,'Y','kannrisya-hennsyuutyuu');
INSERT INTO CODE_DETAIL VALUES('2','01','2009-12-28',NULL,'Y','tukin');
INSERT INTO CODE_DETAIL VALUES('2','02','2009-12-28',NULL,'Y','yukyuu');
INSERT INTO CODE_DETAIL VALUES('2','03','2009-12-28',NULL,'Y','gozennkyu');
INSERT INTO AUTH VALUES('01','USER');
INSERT INTO AUTH VALUES('02','ADMIN');
INSERT INTO MESSAGE VALUES('I','0001','SUCCESS');
INSERT INTO MESSAGE VALUES('I','0002','SAVE SUCCESS');
INSERT INTO MESSAGE VALUES('E','0001','FAIL');
