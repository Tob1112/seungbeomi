CREATE SCHEMA PUBLIC AUTHORIZATION DBA
CREATE MEMORY TABLE COMPANY ( 	com_code VARCHAR(2),	com_name VARCHAR(64))
CREATE MEMORY TABLE DEPT(	com_code VARCHAR(2),	dept_code    VARCHAR(2),	reg_day  DATE,	del_day  DATE ,	latest_flag CHAR(1) DEFAULT 'N',	dept_name VARCHAR(64),	upper_dept_code VARCHAR(2))
CREATE MEMORY TABLE EMP(	com_code VARCHAR(2),	emp_no   VARCHAR(4),	reg_day  DATE,	del_day  DATE ,	latest_flag CHAR(1) DEFAULT 'N',	dept_code VARCHAR(2) NOT NULL,	email    VARCHAR(64) NOT NULL,	passwd   VARCHAR(32) NOT NULL,	hire_day DATE NOT NULL,	retire_day DATE,	last_name VARCHAR(64) NOT NULL, FIRST_NAME VARCHAR(64) NOT NULL)
CREATE MEMORY TABLE TIMESHEET_MM(	com_code  VARCHAR(2),	emp_no    VARCHAR(4),	yyyymm    DATE,	fix_flag  CHAR(1) DEFAULT 'N',	status_code VARCHAR(2) NOT NULL,	actual_time_total NUMERIC(5,2),	break_time_total NUMERIC(5,2),	over_time_total NUMERIC(5,2),	night_time_total NUMERIC(5,2),	holiday_time_total NUMERIC(5,2),	late_time_total NUMERIC(5,2),	early_time_total NUMERIC(5,2),	this_month_pv_total NUMERIC(5,2),	absence_days_total NUMERIC(5,2))
CREATE MEMORY TABLE TIMESHEET_DD(	com_code VARCHAR(2),	emp_no   VARCHAR(4),	yyyymm   DATE,	yyyymmdd  DATE,	work_pattern_code VARCHAR(2) NOT NULL,	fix_time_name CHAR(1) NOT NULL,	work_start_time VARCHAR(4),	work_end_time VARCHAR(4),	work_time_total NUMERIC(5,2),	lunch_break_time VARCHAR(4),	etc_break_time VARCHAR(4),	break_time_total NUMERIC(5,2),	actual_time NUMERIC(5,2),	over_work_time NUMERIC(5,2),	night_work_time NUMERIC(5,2),	holiday_work_time NUMERIC(5,2),	late_time NUMERIC(5,2),	early_time NUMERIC(5,2),	note     VARCHAR(512))
CREATE MEMORY TABLE FIX_TIME(	com_code  VARCHAR(2) NOT NULL,	emp_no   VARCHAR(4) NOT NULL,	yyyymm    DATE NOT NULL,	fix_time_name CHAR(1) NOT NULL,	client_name VARCHAR(64),	time_unit NUMERIC(5,2),	work_start_time VARCHAR(4),	work_end_time VARCHAR(4),	lunch_start_time VARCHAR(4),	lunch_end_time VARCHAR(4))
CREATE MEMORY TABLE CODE(	code_type VARCHAR(2),	code_name VARCHAR(64))
CREATE MEMORY TABLE CODE_DETAIL(	code_type VARCHAR(2),	code_detail VARCHAR(2),	reg_day DATE,	del_day  DATE ,	latest_flag CHAR(1),	code_detail_name VARCHAR(64))
CREATE MEMORY TABLE AUTH(	id     VARCHAR(64),	auth   VARCHAR(64))
CREATE MEMORY TABLE MESSAGE(	msg_type CHAR(1),	msg_id   VARCHAR(4),	msg_body VARCHAR(512))
CREATE MEMORY TABLE INIT_PARAMETER(	parameter_code VARCHAR(2) NOT NULL,	start_date DATE,	start_date_name VARCHAR(64),	note      VARCHAR(512))
ALTER TABLE COMPANY ADD CONSTRAINT PK_COMPANY	PRIMARY KEY (com_code)
ALTER TABLE DEPT ADD CONSTRAINT PK_DEPT	PRIMARY KEY (com_code, dept_code, reg_day)
ALTER TABLE EMP ADD CONSTRAINT PK_EMP	PRIMARY KEY (com_code, emp_no, reg_day)
ALTER TABLE TIMESHEET_MM ADD CONSTRAINT PK_TIMESHEET_MM	PRIMARY KEY (com_code, emp_no, yyyymm)
ALTER TABLE TIMESHEET_DD ADD CONSTRAINT PK_TIMESHEET_DD	PRIMARY KEY (com_code, emp_no, yyyymm, yyyymmdd)
ALTER TABLE FIX_TIME ADD CONSTRAINT PK_FIX_TIME	PRIMARY KEY (com_code, emp_no, yyyymm, fix_time_name)
ALTER TABLE CODE ADD CONSTRAINT PK_CODE	PRIMARY KEY (code_type)
ALTER TABLE CODE_DETAIL ADD CONSTRAINT PK_CODE_DETAIL	PRIMARY KEY (code_type, code_detail, reg_day)
ALTER TABLE MESSAGE ADD CONSTRAINT PK_MESSAGE	PRIMARY KEY (msg_type, msg_id)
ALTER TABLE init_parameter ADD CONSTRAINT PK_INIT_PARAMETER	PRIMARY KEY (parameter_code)
CREATE USER SA PASSWORD ""
GRANT DBA TO SA
SET WRITE_DELAY 60
SET SCHEMA PUBLIC
INSERT INTO COMPANY VALUES('01','\u30eb\u30a6\u30ac\u30eb\u30bd\u30f3')
INSERT INTO COMPANY VALUES('02','\u30b9\u30a4\u30fc\u30c8')
INSERT INTO COMPANY VALUES('03','\u30e9\u30fc\u30cb\u30f3\u30b0')
INSERT INTO DEPT VALUES('01','01','0009-04-01','0001-01-01','Y','\u958b\u767a\u90e8','')
INSERT INTO DEPT VALUES('01','02','0009-04-01','0001-01-01','Y','SI\u90e8','')
INSERT INTO DEPT VALUES('01','03','0009-04-01','0001-01-01','Y','\u7dcf\u52d9\u90e8','')
INSERT INTO DEPT VALUES('01','04','0009-04-01','0001-01-01','Y','\u55b6\u696d\u90e8','')
INSERT INTO DEPT VALUES('01','05','0009-04-01','0001-01-01','Y','\u7814\u4fee\u6240','')
INSERT INTO DEPT VALUES('01','06','0009-04-01','0001-01-01','Y','\u4f01\u753b\u4e8b\u696d\u63a8\u9032G','')
INSERT INTO DEPT VALUES('01','07','0009-04-01','0001-01-01','Y','\u958b\u767a1G','01')
INSERT INTO DEPT VALUES('01','08','0009-04-01','0001-01-01','Y','\u958b\u767a2G','01')
INSERT INTO DEPT VALUES('01','09','0009-04-01','0001-01-01','Y','\u958b\u767a3G','01')
INSERT INTO DEPT VALUES('01','10','0009-04-01','0001-01-01','Y','SI1\u90e8','02')
INSERT INTO DEPT VALUES('01','11','0009-04-01','0001-01-01','Y','SI2\u90e8','02')
INSERT INTO DEPT VALUES('01','12','0009-04-01','0001-01-01','Y','SI3\u90e8','02')
INSERT INTO DEPT VALUES('02','02','0009-04-01','0001-01-01','Y','\u958b\u767a1G','01')
INSERT INTO DEPT VALUES('02','03','0009-04-01','0001-01-01','Y','\u958b\u767a2G','01')
INSERT INTO EMP VALUES('01','101','2009-12-28',NULL,'Y','01','user','ee11cbb19052e4b7aac0ca6c23ee','2006-12-25',NULL,'son','seungbeomi')
INSERT INTO TIMESHEET_MM VALUES('01','101','2009-08-01','N','01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO TIMESHEET_MM VALUES('01','101','2009-09-01','N','01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO TIMESHEET_MM VALUES('01','101','2009-10-01','N','01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO TIMESHEET_MM VALUES('01','101','2009-11-01','N','01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO TIMESHEET_MM VALUES('01','101','2009-12-01','N','01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-01','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-02','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-03','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-04','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-05','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-06','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-07','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-08','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-09','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-10','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-11','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-12','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-13','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-14','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-15','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-16','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-17','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-18','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-19','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-20','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-21','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-22','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-23','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-24','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-25','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-26','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-27','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-28','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-29','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-30','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-08-01','2009-08-31','01','A','0800','1800',0,NULL,NULL,100,9.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-01','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-02','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-03','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-04','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-05','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-06','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-07','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-08','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-09','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-10','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-11','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-12','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-13','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-14','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-15','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-16','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-17','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-18','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-19','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-20','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-21','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-22','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-23','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-24','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-25','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-26','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-27','02',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-28','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-29','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-09-01','2009-09-30','01','B','0800','1900',0,NULL,NULL,100,10.00,0,0,0,0,0,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-10-01','2009-10-01','01','A','0800','1800',NULL,NULL,NULL,100,9.00,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-10-01','2009-10-02','01','A','0800','1800',NULL,NULL,NULL,100,9.00,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-12-01','2009-12-01','01','A','0800','1800',NULL,NULL,NULL,100,9.00,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-12-01','2009-12-02','01','A','0800','1800',NULL,NULL,NULL,100,9.00,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-12-01','2009-12-03','01','A','0800','1800',NULL,NULL,NULL,100,9.00,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO TIMESHEET_DD VALUES('01','101','2009-12-01','2009-12-04','01','A','0800','1800',NULL,NULL,NULL,100,9.00,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO FIX_TIME VALUES('01','101','2009-08-01','A','test',15,'0800','1800','1200','1300')
INSERT INTO FIX_TIME VALUES('01','101','2009-08-01','B',NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO FIX_TIME VALUES('01','101','2009-08-01','C',NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO FIX_TIME VALUES('01','101','2009-09-01','A','suite',15,'0800','1800','1200','1300')
INSERT INTO FIX_TIME VALUES('01','101','2009-09-01','B','test',30,'0800','1900','1200','1300')
INSERT INTO FIX_TIME VALUES('01','101','2009-09-01','C','',NULL,NULL,NULL,NULL,NULL)
INSERT INTO CODE_DETAIL VALUES('1','01','2009-12-28',NULL,'Y','sakuseityu')
INSERT INTO CODE_DETAIL VALUES('1','02','2009-12-28',NULL,'Y','syouninmati')
INSERT INTO CODE_DETAIL VALUES('1','03','2009-12-28',NULL,'Y','syouninnzumi')
INSERT INTO CODE_DETAIL VALUES('1','04','2009-12-28',NULL,'Y','kannrisya-hennsyuutyuu')
INSERT INTO CODE_DETAIL VALUES('2','01','2009-12-28',NULL,'Y','tukin')
INSERT INTO CODE_DETAIL VALUES('2','02','2009-12-28',NULL,'Y','yukyuu')
INSERT INTO CODE_DETAIL VALUES('2','03','2009-12-28',NULL,'Y','gozennkyu')
INSERT INTO MESSAGE VALUES('I','0001','SUCCESS')
INSERT INTO MESSAGE VALUES('I','0002','SAVE SUCCESS')
INSERT INTO MESSAGE VALUES('E','0001','FAIL')

