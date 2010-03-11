-- company
insert into company (com_code, com_name) values ('01', 'ルウガルソン');
insert into company (com_code, com_name) values ('02', 'スイート');
insert into company (com_code, com_name) values ('03', 'ラーニング');

-- dept
insert into dept (com_code, dept_code, reg_day, del_day, latest_flag, dept_name, upper_dept_code) values ('01', '01', '09-04-01', '00-01-01', 'Y', '開発部', '');
insert into dept (com_code, dept_code, reg_day, del_day, latest_flag, dept_name, upper_dept_code) values ('01', '02', '09-04-01', '00-01-01', 'Y', 'SI部', '');
insert into dept (com_code, dept_code, reg_day, del_day, latest_flag, dept_name, upper_dept_code) values ('01','03','09-04-01','00-01-01','Y','総務部', '');
insert into dept (com_code, dept_code, reg_day, del_day, latest_flag, dept_name, upper_dept_code) values ('01','04','09-04-01','00-01-01','Y','営業部', '');
insert into dept (com_code, dept_code, reg_day, del_day, latest_flag, dept_name, upper_dept_code) values ('01','05','09-04-01','00-01-01','Y','研修所', '');
insert into dept (com_code, dept_code, reg_day, del_day, latest_flag, dept_name, upper_dept_code) values ('01','06','09-04-01','00-01-01','Y','企画事業推進G', '');
insert into dept (com_code, dept_code, reg_day, del_day, latest_flag, dept_name, upper_dept_code) values ('01','07','09-04-01','00-01-01','Y','開発1G','01');
insert into dept (com_code, dept_code, reg_day, del_day, latest_flag, dept_name, upper_dept_code) values ('01','08','09-04-01','00-01-01','Y','開発2G','01');
insert into dept (com_code, dept_code, reg_day, del_day, latest_flag, dept_name, upper_dept_code) values ('01','09','09-04-01','00-01-01','Y','開発3G','01');
insert into dept (com_code, dept_code, reg_day, del_day, latest_flag, dept_name, upper_dept_code) values ('01','10','09-04-01','00-01-01','Y','SI1部','02');
insert into dept (com_code, dept_code, reg_day, del_day, latest_flag, dept_name, upper_dept_code) values ('01','11','09-04-01','00-01-01','Y','SI2部','02');
insert into dept (com_code, dept_code, reg_day, del_day, latest_flag, dept_name, upper_dept_code) values ('01','12','09-04-01','00-01-01','Y','SI3部','02');
insert into dept (com_code, dept_code, reg_day, del_day, latest_flag, dept_name, upper_dept_code) values ('02','02','09-04-01','00-01-01','Y','開発1G','01');
insert into dept (com_code, dept_code, reg_day, del_day, latest_flag, dept_name, upper_dept_code) values ('02','03','09-04-01','00-01-01','Y','開発2G','01');

-- emp
insert into emp (com_code, emp_no, reg_day, del_day, latest_flag, dept_code, email, passwd, hire_day, retire_day, last_name, first_name) values ('01', '101', '09-04-01', '00-01-01', 'Y', '07', 'user', 'ee11cbb19052e4b7aac0ca6c23ee', '01-04-01', '', '由宇座','平社員');
insert into emp (com_code, emp_no, reg_day, del_day, latest_flag, dept_code, email, passwd, hire_day, retire_day, last_name, first_name) values ('01', '102', '01-04-01', '00-01-01', 'Y', '01', 'admin', '21232f297a57a5a743894ae4a801fc3', '01-04-01', '', '亜土民','権限者');
insert into emp (com_code, emp_no, reg_day, del_day, latest_flag, dept_code, email, passwd, hire_day, retire_day, last_name, first_name) values ('01', '103', '09-04-01', '00-01-01', 'Y', '07', 'eom', 'ee11cbb19052e4b7aac0ca6c23ee', '01-04-01', '', '厳','駿');
insert into emp (com_code, emp_no, reg_day, del_day, latest_flag, dept_code, email, passwd, hire_day, retire_day, last_name, first_name) values ('01', '104', '09-04-01', '00-01-01', 'Y', '07', 'kuba', 'ee11cbb19052e4b7aac0ca6c23ee', '01-04-01', '', '久場','貴行');
insert into emp (com_code, emp_no, reg_day, del_day, latest_flag, dept_code, email, passwd, hire_day, retire_day, last_name, first_name) values ('01', '105', '09-04-01', '00-01-01', 'Y', '07', 'yh', 'ee11cbb19052e4b7aac0ca6c23ee', '01-04-01', '', '丁', '潤姫');
insert into emp (com_code, emp_no, reg_day, del_day, latest_flag, dept_code, email, passwd, hire_day, retire_day, last_name, first_name) values ('01', '106', '09-04-01', '00-01-01', 'Y', '07', 'jh', 'ee11cbb19052e4b7aac0ca6c23ee', '01-04-01', '', '宋', '珠憲');
insert into emp (com_code, emp_no, reg_day, del_day, latest_flag, dept_code, email, passwd, hire_day, retire_day, last_name, first_name) values ('01', '107', '09-04-01', '00-01-01', 'Y', '07', 'sb', 'ee11cbb19052e4b7aac0ca6c23ee', '01-04-01', '', '孫', '承範');
insert into emp (com_code, emp_no, reg_day, del_day, latest_flag, dept_code, email, passwd, hire_day, retire_day, last_name, first_name) values ('01', '108', '09-04-01', '00-01-01', 'Y', '07', 'wj', 'ee11cbb19052e4b7aac0ca6c23ee', '01-04-01', '', '蔡', '耘調');