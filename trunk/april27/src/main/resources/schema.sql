DROP TABLE EMPLOYEE IF EXISTS;

CREATE TABLE EMPLOYEE
(
    EMP_NAME                        VARCHAR(64),
    PASSWORD 						VARCHAR(64),
    EMAIL                           VARCHAR(64)
);

INSERT INTO EMPLOYEE VALUES ('admin','admin','admin@gmail.com');
INSERT INTO EMPLOYEE VALUES ('user','user','user@gmail.com');
INSERT INTO EMPLOYEE VALUES ('son','son','son@gmail.com');
