/* USERS SCHEMA */
CREATE TABLE USERS (
  USERNAME VARCHAR(20) PRIMARY KEY,
  PASSWORD VARCHAR(20),
  NAME VARCHAR(100),
  EMAIL VARCHAR(50),
  ENABLED BOOLEAN NOT NULL
);
CREATE TABLE AUTHORITIES (
    USERNAME VARCHAR(50) NOT NULL,
    AUTHORITY VARCHAR(50) NOT NULL,
    CONSTRAINT FK_AUTHORITIES_USERS FOREIGN KEY (USERNAME) REFERENCES USERS(USERNAME)
);
CREATE UNIQUE INDEX IX_AUTH_USERNAME ON AUTHORITIES (USERNAME, AUTHORITY);

/* GROUP AUTHORITIES */
CREATE TABLE GROUPS (
  ID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 0) PRIMARY KEY,
  GROUP_NAME VARCHAR_IGNORECASE(50) NOT NULL
);
CREATE TABLE GROUP_AUTHORITIES (
  GROUP_ID BIGINT NOT NULL,
  AUTHORITY VARCHAR(50) NOT NULL,
  CONSTRAINT FK_GROUP_AUTHORITIES_GROUP FOREIGN KEY(GROUP_ID) REFERENCES GROUPS(ID)
);
CREATE TABLE GROUP_MEMBERS (
  ID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 0) PRIMARY KEY,
  USERNAME VARCHAR(50) NOT NULL,
  GROUP_ID BIGINT NOT NULL,
  CONSTRAINT FK_GROUP_MEMBERS_GROUP FOREIGN KEY(GROUP_ID) REFERENCES GROUPS(ID)
);

/* PERSISTENT LOGIN (REMEMBER-ME) SCHEMA */
CREATE TABLE PERSISTENT_LOGINS (
  USERNAME VARCHAR(64) NOT NULL,
  SERIES VARCHAR(64) PRIMARY KEY,
  TOKEN VARCHAR(64) NOT NULL,
  LAST_USED TIMESTAMP NOT NULL
);