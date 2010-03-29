conn system/oracle

CREATE TABLESPACE board
datafile 'C:\oracle\board\board.dbf'
size 100M;

CRETAE USER board
IDENTIFIED BY board
default table space board;

conn board/board

DROP TABLE BOARD;

CREATE TABLE BOARD (
   BOARDNO		number(11) 		CONSTRAINT brd_brno_pk PRIMARY KEY 
								USING INDEX (CREATE INDEX brd_no_idx 
								ON BOARD(BOARDNO)),
   TITLE 		varchar2(80) 		NOT NULL,
   NAME 		varchar2(10) 		NOT NULL,
   EMAIL 		varchar2(30),
   PASSWORD 	varchar2(10) 		NOT NULL,
   CREATEDATE 	timestamp			NOT NULL,
   CONTENT 		long				NOT NULL,
   HITCOUNT 	number(11) DEFAULT '0' NOT NULL)
tablespace board;

DROP TABLE BOARDFILE;

CREATE TABLE BOARDFILE (
	FILENO			number(11)		CONSTRAINT brd_file_fln_no PRIMARY KEY,
	BOARDNO			number(11)		NOT NULL,
	FILENAME		varchar(200)	NOT NULL,
	TEMPFILENAME	varchar2(100)	NOT NULL)
tablespace board;

create sequence board_seq
increment by 1
start with 4
maxvalue 10000
nocycle
nocache;

create sequence boardfile_seq
increment by 1
start with 1
maxvalue 10000
nocycle
nocache;