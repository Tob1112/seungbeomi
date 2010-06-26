BEGIN TRANSACTION;
CREATE TABLE department (
    id integer not null primary key,
    name varchar(255) not null,
    version integer not null
);
INSERT INTO "department" VALUES(1, 'ACCOUNTING', 1);
INSERT INTO "department" VALUES(2, 'RESEARCH', 1);
INSERT INTO "department" VALUES(3, 'SALES', 1);
INSERT INTO "department" VALUES(4, 'OPERATIONS', 1);

CREATE TABLE employee (
    id integer not null primary key,
    name varchar(255) not null,
    job_type varchar(30) not null,
    salary integer,
    department_id integer,
    version integer not null
);
INSERT INTO "employee" VALUES(1, 'SON1', 'DEVELOPER1', 1000, 1, 1);
INSERT INTO "employee" VALUES(2, 'SON2', 'DEVELOPER2', 1100, 2, 1);
INSERT INTO "employee" VALUES(3, 'SON3', 'DEVELOPER3', 1200, 3, 1);
INSERT INTO "employee" VALUES(4, 'SON4', 'DEVELOPER4', 1300, 1, 1);
INSERT INTO "employee" VALUES(5, 'SON5', 'DEVELOPER5', 1400, 2, 1);
INSERT INTO "employee" VALUES(6, 'SON6', 'DEVELOPER6', 1500, 4, 1);
INSERT INTO "employee" VALUES(7, 'SON7', 'DEVELOPER7', 1600, 1, 1);
INSERT INTO "employee" VALUES(8, 'SON8', 'DEVELOPER8', 1700, 2, 1);
INSERT INTO "employee" VALUES(9, 'SON9', 'DEVELOPER9', 1800, 3, 1);
INSERT INTO "employee" VALUES(10, 'SON10', 'DEVELOPER10', 1900, 4, 1);
COMMIT;