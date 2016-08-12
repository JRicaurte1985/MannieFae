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
--
create table borrower(
  borrower_id number not null,
  first_name varchar(30) not null,
  last_name varchar(30) not null,
  address varchar(100) not null,
  city varchar(35) not null,
  state varchar(2) not null,
  ss_number varchar(9) not null,
  constraint borrower_pk primary key(borrower_id) 
);
--
create sequence borrower_seq
start with 1
increment by 1;
--
create or replace trigger borrower_trig
before insert on borrower
for each row
begin
  select borrower_seq.nextval into :new.borrower_id from dual;
end;
--
/
--
create table commitment(
  commitment_id number not null,
  apr number not null,
  total_amount number not null,
  date_created date not null,
  verified number not null,
  constraint commitment_pk primary key(commitment_id)
);
--
create sequence commitment_seq
start with 1
increment by 1;
--
create or replace trigger commitment_trigger
before insert on commitment
for each row
begin
  select commitment_seq.nextval into :new.commitment_id from dual;
end;
--
/
--
create table loan(
  loan_id number not null,
  principal number not null,
  apr number not null,
  term number not null,
  start_date date not null,
  borrower_id number not null,
  lender_id number not null,
  commitment_id number not null,
  constraint loan_pk primary key(loan_id),
  constraint b_fk foreign key (borrower_id) references borrower(borrower_id),
  constraint l_fk foreign key (lender_id) references lender(lender_id),
  constraint c_pk foreign key (commitment_id) references commitment(commitment_id)
);
--
create sequence loan_seq
start with 1
increment by 1;
--
create or replace trigger loan_trigger
before insert on loan
for each row
begin
  select loan_seq.nextval into :new.loan_id from dual;
end;
--
/
--
commit;