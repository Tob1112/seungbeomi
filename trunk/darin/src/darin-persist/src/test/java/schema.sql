DROP TABLE authorities;
DROP TABLE userinfo;

CREATE TABLE userinfo(
  userId VARCHAR(20) PRIMARY KEY,
  password VARCHAR(20),
  name VARCHAR(100),
  email VARCHAR(50),
  enabled BOOLEAN NOT NULL
);

CREATE TABLE authorities (
	userid VARCHAR(50) NOT NULL,
	authority VARCHAR(50) NOT NULL
);
CREATE UNIQUE INDEX ix_auth_username ON authorities (name, authority);

ALTER TABLE authorities ADD CONSTRAINT fk_authorities_userinfo FOREIGN KEY (name) REFERENCES userinfo;

INSERT INTO userinfo VALUES('admin','admin','administrator','admin@seungbeomi.net', true);
INSERT INTO userinfo VALUES('son','son','seungbeomi','son@seungbeomi.net', true);
INSERT INTO authorities VALUES ('admin', 'ROLE_ADMIN');
INSERT INTO authorities VALUES ('son', 'ROLE_USER');

select * from userinfo;
select * from authorities;
