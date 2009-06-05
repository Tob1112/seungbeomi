-- Table: user_info

-- DROP TABLE user_info;

CREATE TABLE user_info
(
  id text NOT NULL,
  pw text NOT NULL,
  "name" text NOT NULL,
  CONSTRAINT user_info_pkey PRIMARY KEY (id)
);


-- Table: guestbook

-- DROP TABLE guestbook;

CREATE TABLE guestbook
(
  "no" serial NOT NULL,
  user_id text NOT NULL,
  title text NOT NULL,
  postdate date NOT NULL,
  category text DEFAULT 'IT'::text,
  "comment" text,
  CONSTRAINT guestbook_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES user_info (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
