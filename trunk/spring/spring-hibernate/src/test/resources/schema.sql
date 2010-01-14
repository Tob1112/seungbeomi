DROP TABLE ADDRESS IF EXISTS;
DROP TABLE PERSON IF EXISTS;

CREATE TABLE PERSON (
    ID integer identity primary key,
    NAME varchar(50) not null,
	CREATED timestamp,
	CONSTRAINT IDX_PERSON_ID PRIMARY KEY (ID)
);

CREATE TABLE ADDRESS (
    ID integer identity primary key,
    PERSON_ID integer,
    ADDRESS varchar(255),
	CREATED timestamp,
    CONSTRAINT IDX_ADDRESS_ID PRIMARY KEY (ID),
    CONSTRAINT FK_ADDRESS_PERSON_ID FOREIGN KEY (PERSON_ID) REFERENCES PERSON(ID) on delete cascade
);

INSERT INTO PERSON(ID, NAME, CREATED)
   VALUES(1, 'son', NOW());
INSERT INTO ADDRESS(ID, PERSON_ID, ADDRESS, CREATED)
   VALUES(1, 1, 'pusan', NOW());
INSERT INTO PERSON(ID, NAME, CREATED)
   VALUES(2, 'kim', NOW());
INSERT INTO ADDRESS(ID, PERSON_ID, ADDRESS, CREATED)
   VALUES(2, 2, 'seoul', NOW());
INSERT INTO ADDRESS(ID, PERSON_ID, ADDRESS, CREATED)
   VALUES(3, 2, 'yokohama', NOW());