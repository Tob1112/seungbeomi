drop table user_info;

CREATE TABLE user_info
(
  id text primary key,
  pw text NOT NULL,
  name text NOT NULL
);

INSERT INTO USER_INFO VALUES('chaeid','chaepw','woonjoo');
INSERT INTO USER_INFO VALUES('sonid','sonpw','seungbeomi');
select * from user_info;

drop table guestbook;

CREATE TABLE guestbook
(
  no serial,
  user_id text NOT NULL,
  title text NOT NULL,
  category text DEFAULT 'IT',	
  postdate date NOT NULL,
  comment text,
  CONSTRAINT guestbook_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES user_info (id) 
);

INSERT INTO GUESTBOOK VALUES(1,'sonid','title','category','2009-06-01','comment');
INSERT INTO GUESTBOOK VALUES(2,'chaeid','title','category','2009-06-01','comment');

select * from guestbook;