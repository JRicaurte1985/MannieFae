--Create user and grant privileges--
create user mf_admin
identified by p4ssw0rd
default tablespace users
temporary tablespace temp
quota 10M on users;
--
grant connect to mf_admin;
grant resource to mf_admin;
grant create session to mf_admin;
grant create table to mf_admin;
grant create view to mf_admin;
--
conn mf_admin/p4ssw0rd;
-- Create and populate tables---
create table lender(
  lender_id number not null,
  lender_name varchar2(100) not null,
  lender_address varchar2(80) not null,
  lender_city varchar2(50) not null,
  lender_state varchar2(2) not null,
  constraint lender_pk primary key (lender_id)
);
--
create sequence lender_seq
start with 1
increment by 1;
--
create or replace trigger lender_trigger
before insert on lender
for each row
begin
  select lender_seq.nextval into :new.lender_id from dual;
end;
--
/
commit;