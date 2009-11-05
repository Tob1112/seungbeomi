drop table userinfo;
drop table groups;
drop table group_members;
drop table group_authorities;

create table userinfo(
  user_id varchar(20) primary key,
  password varchar(20) not null,
  name varchar(50) not null,
  email varchar(50) not null,
  --authority varchar(50)[] not null
  group_id varchar(50) not null
);

--create table authorities (
--  userId varchar(100) not null,
--  authority varchar(50) not null
--);

create table groups(
  id varchar(20),
  group_name varchar(50)
);

create table group_members(
  group_id varchar(20),
  username varchar(50)
);

create table group_authorities(
  group_id varchar(20) ,
  authority varchar(50)
);

create unique index ix_auth_userid on userinfo(user_id, group_id);

--alter table authorities add constraint fk_authorities_userinfo foreign key (userid) references userinfo;

--delete from userinfo;

insert into userinfo values('admin','admin','administrator','admin@seungbeomi.net','gid_admin');
insert into userinfo values('son','son','seungbeomi','son@seungbeomi.net','gid_admin');
insert into userinfo values('kim','kim','kim','kim@seungbeomi.net','gid_user');
insert into userinfo values('lee','lee','lee','lee@seungbeomi.net','gid_user');

insert into groups values('gid_admin','admin_groups');
insert into groups values('gid_user','user_groups');

insert into group_members values('gid_admin','admin');
insert into group_members values('gid_admin','son');
insert into group_members values('gid_user','kim');
insert into group_members values('gid_user','lee');

insert into group_authorities values('gid_admin','ADMIN');
insert into group_authorities values('gid_admin','USER');
insert into group_authorities values('gid_user','USER');


--authorities-by-username-query="SELECT userid, authority FROM userinfo WHERE userId = ?"

--select * from userinfo
--where 'ROLE_ADMIN' = any(authority);

--SELECT
--	g.id, g.group_name, ga.authority
--FROM
--	groups g, group_members gm, group_authorities ga
--WHERE
--	gm.username = 'admin'
--AND
--	g.id = ga.group_id
--AND
--	g.id = gm.group_id


