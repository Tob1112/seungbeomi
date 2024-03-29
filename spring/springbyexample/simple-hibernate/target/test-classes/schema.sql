DROP TABLE ADDRESS IF EXISTS;
DROP TABLE PERSON IF EXISTS;

CREATE TABLE PERSON (
    ID integer identity primary key,  
    FIRST_NAME varchar(50) not null,
    LAST_NAME varchar(50) not null,
	CREATED timestamp,
	CONSTRAINT IDX_PERSON_ID PRIMARY KEY (ID)
);

CREATE TABLE ADDRESS (
    ID integer identity primary key,
    PERSON_ID integer,  
    ADDRESS varchar(255),
    CITY varchar(50) not null,
    STATE varchar(50) not null,
    ZIP_POSTAL varchar(30) not null,
	CREATED timestamp,
    CONSTRAINT IDX_ADDRESS_ID PRIMARY KEY (ID),
    CONSTRAINT FK_ADDRESS_PERSON_ID FOREIGN KEY (PERSON_ID) REFERENCES PERSON(ID) on delete cascade
);

INSERT INTO PERSON(ID, FIRST_NAME, LAST_NAME, CREATED) 
   VALUES(1, 'Joe', 'Smith', NOW());
INSERT INTO ADDRESS(ID, PERSON_ID, ADDRESS, CITY, STATE, ZIP_POSTAL, CREATED) 
   VALUES(1, 1, '1060 West Addison St.', 'Chicago', 'IL', '60613', NOW());
   
INSERT INTO PERSON(ID, FIRST_NAME, LAST_NAME, CREATED) 
   VALUES(2, 'John', 'Wilson', NOW());
INSERT INTO ADDRESS(ID, PERSON_ID, ADDRESS, CITY, STATE, ZIP_POSTAL, CREATED) 
   VALUES(2, 2, '2 Penn Plz # 15', 'New York', 'NY', '10121', NOW());
INSERT INTO ADDRESS(ID, PERSON_ID, ADDRESS, CITY, STATE, ZIP_POSTAL, CREATED) 
   VALUES(3, 2, '47 Howard St.', 'San Francisco', 'CA', '94103', NOW());
