-- PRMS DDL
-- COMPANY
CREATE TABLE COMPANY
(
	com_code VARCHAR2(2),
	com_name VARCHAR2(64)
);
ALTER TABLE COMPANY ADD CONSTRAINT PK_COMPANY
	PRIMARY KEY (com_code);

-- DEPT
CREATE TABLE DEPT
(
	com_code VARCHAR2(2),
	dept_code    VARCHAR2(2),
	reg_day  DATE,
	del_day  DATE DEFAULT '1900/01/01',
	latest_flag CHAR(1) DEFAULT 'N',
	dept_name VARCHAR2(64),
	upper_dept_code VARCHAR2(2)
);
ALTER TABLE DEPT ADD CONSTRAINT PK_DEPT
	PRIMARY KEY (com_code, dept_code, reg_day);

-- EMP
CREATE TABLE EMP
(
	com_code VARCHAR2(2),
	emp_no   VARCHAR2(4),
	reg_day  DATE,
	del_day  DATE DEFAULT '1900/01/01',
	latest_flag CHAR(1) DEFAULT 'N',
	dept_code VARCHAR2(2) NOT NULL,
	email    VARCHAR2(64) NOT NULL,
	passwd   VARCHAR2(32) NOT NULL,
	hire_day DATE NOT NULL,
	retire_day DATE,
	last_name VARCHAR2(64) NOT NULL,
	first_name VARCHAR2(64) NOT NULL
);
ALTER TABLE EMP ADD CONSTRAINT PK_EMP 
	PRIMARY KEY (com_code, emp_no, reg_day);

-- TIMESHEET_MM
CREATE TABLE TIMESHEET_MM
(
	com_code  VARCHAR2(2),
	emp_no    VARCHAR2(4),
	yyyymm    DATE,
	fix_flag  CHAR(1) DEFAULT 'N',
	status_code VARCHAR2(2) NOT NULL,
	actual_time_total NUMBER(3,2),
	break_time_total NUMBER(3,2),
	over_time_total NUMBER(3,2),
	night_time_total NUMBER(3,2),
	holiday_time_total NUMBER(3,2),
	late_time_total NUMBER(3,2),
	early_time_total NUMBER(3,2),
	this_month_pv_total NUMBER(3,2),
	absence_days_total NUMBER(3,2)
);
ALTER TABLE TIMESHEET_MM ADD CONSTRAINT PK_TIMESHEET_MM
	PRIMARY KEY (com_code, emp_no, yyyymm);
  
-- TIMESHEET_DD
CREATE TABLE TIMESHEET_DD
(
	com_code VARCHAR2(2),
	emp_no   VARCHAR2(4),
	yyyymm   DATE,
	yyyymmdd  DATE,
	work_pattern_code VARCHAR2(2) NOT NULL,
	fix_time_name CHAR(1) NOT NULL,
  work_start_time VARCHAR2(4),
	work_end_time VARCHAR2(4),
	work_time_total NUMBER(3,2),
	lunch_break_time VARCHAR2(4),
	etc_break_time VARCHAR2(4),
	break_time_total NUMBER(3,2),
	actual_time NUMBER(3,2),
	over_work_time NUMBER(3,2),
	night_work_time NUMBER(3,2),
	holiday_work_time NUMBER(3,2),
	late_time NUMBER(3,2),
	early_time NUMBER(3,2),
	note     VARCHAR2(512)
);
ALTER TABLE TIMESHEET_DD ADD CONSTRAINT PK_TIMESHEET_DD
	PRIMARY KEY (com_code, emp_no, yyyymm, yyyymmdd);

-- FIX_TIME
CREATE TABLE FIX_TIME
(
	com_code  VARCHAR2(2) NOT NULL,
	emp_no   VARCHAR2(4) NOT NULL,
	yyyymm    DATE NOT NULL,
	fix_time_name CHAR(1) NOT NULL,
	client_name VARCHAR2(64),
	time_unit NUMBER(2,2),
	work_start_time VARCHAR2(4),
	work_end_time VARCHAR2(4),
	lunch_start_time VARCHAR2(4),
	lunch_end_time VARCHAR2(4)
);
ALTER TABLE FIX_TIME ADD CONSTRAINT PK_FIX_TIME
	PRIMARY KEY (com_code, emp_no, yyyymm, fix_time_name);
  
-- CODE
CREATE TABLE CODE
(
	code_type VARCHAR2(2),
	code_name VARCHAR2(64)
);
ALTER TABLE CODE ADD CONSTRAINT PK_CODE
	PRIMARY KEY (code_type);

-- CODE_DETAIL
CREATE TABLE CODE_DETAIL
(
	code_type VARCHAR2(2),
	code_detail VARCHAR2(2),
	reg_day DATE,
	del_day DATE,
	latest_flag CHAR(1),
	code_detail_name VARCHAR2(64)
);
ALTER TABLE CODE_DETAIL ADD CONSTRAINT PK_CODE_DETAIL
	PRIMARY KEY (code_type, code_detail, reg_day);
