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