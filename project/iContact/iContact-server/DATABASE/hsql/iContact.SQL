-- iContact DDL
-- USERS
CREATE TABLE USERS
(
    USER_NAME VARCHAR(30),
    PASSWORD VARCHAR(30) NOT NULL,
    CONSTRAINT PK_USERS PRIMARY KEY(USER_NAME)
)

-- CONTACTS
CREATE TABLE CONTACTS
(
    NAME VARCHAR(30),
    USER_NAME VARCHAR(30),
    PHONE_TYPE CHAR(6), --mobile, home, work, other
    PHONE_VALUE INTEGER(20),
    EMAIL_TYPE CHAR(8), --mobile, computer, work, other
    EMAIL_VALUE VARCHAR(50),
    ADDRESS_TYPE CHAR(5),   --home, work, other
    ADDRESS_VALUE VARCHAR(200),
    NOTES VARCHAR(500),
    STATUS CHAR(1),         --  O:最新, A:追加, M:修正, D:削除
    CONSTRAINT PK_CONTACTS PRIMARY KEY(CONTACT_NAME)
)

INSERT INTO USERS VALUES('son','son')
INSERT INTO USERS VALUES('kim','kim')
INSERT INTO CONTACTS VALUES('son', 'kim1', 'mobile', 1112223333,'computer','kim1@gmail.com','home','home address','note','O')
INSERT INTO CONTACTS VALUES('son', 'kim2', 'home', 2223334444,'mobile','kim2@softbank.ne.jp','work','work address','note','O')
INSERT INTO CONTACTS VALUES('kim', 'son1', 'work', 3334445555,'work','son1@gmail.com','other','other address','note','O')
INSERT INTO CONTACTS VALUES('kim', 'son2', 'other', 4445556666,'other','son2@softbank.ne.jp','other','other address','note','O')
