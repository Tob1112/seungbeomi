-- Test Member Accounts
create table Member(firstName varchar(255), lastName varchar(255), email varchar(255), password varchar(255), username varchar(255), gender varchar(255), birthdate varchar(255));
insert into Member (firstName, lastName, email, password, username, gender, birthdate) 
values ('Keith' , 'Donald', 'keith.donald@springsource.com', 'melbourne', 'kdonald', 'M', '1977-12-29');
