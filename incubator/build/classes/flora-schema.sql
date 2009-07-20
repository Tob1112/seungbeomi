-- GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'mysql' WITH GRANT OPTION;
-- CREATE DATABASE flora DEFAULT CHARACTER SET utf8  COLLATE utf8_general_ci;

-- DROP TABLE BOARD;

CREATE TABLE BOARD (
   BOARDNO		int(11) 			NOT NULL,
   TITLE 		varchar(80) 		NOT NULL,
   NAME 		varchar(10) 		NOT NULL,
   EMAIL 		varchar(30),
   PASSWORD 	varchar(10) 		NOT NULL,
   CREATEDATE 	varchar(14) 		NOT NULL,
   CONTENT 		text 				NOT NULL,
   HITCOUNT 	int(11) DEFAULT '0' NOT NULL,

   PRIMARY KEY (BOARDNO),
   INDEX BOARD_no_idx  (BOARDNO)
);

-- DROP TABLE BOARDFILE;

CREATE TABLE BOARDFILE (
	FILENO			int(11)			NOT NULL,
	BOARDNO			int(11)			NOT NULL,
	FILESIZE		int(11) 		NOT NULL,
	FILENAME		varchar(200)	NOT NULL,
	CONTENTTYPE		varchar(200),
	TEMPFILENAME	varchar(100)	NOT NULL,

	PRIMARY KEY (FILENO)
);

-- DROP TABLE BOARDSEQUENCE;

CREATE TABLE BOARDSEQUENCE (
	VALUE           int(11)         NOT NULL
);

-- DROP TABLE BOARDFILESEQUENCE;

CREATE TABLE BOARDFILESEQUENCE (
	VALUE           int(11)         NOT NULL
);

-- DROP TABLE USERINFO;

CREATE TABLE USERINFO (
	userId          varchar(12)		NOT NULL,
	password		varchar(12)		NOT NULL,
	name			varchar(20)		NOT NULL,
	email			varchar(50),
	PRIMARY KEY               (userId),
	INDEX USERINFO_userId_idx  (userId)
);

