create table mk_role (
  roleid number primary key, 
  rolename VARCHAR2(10) 
  );
  comment on table mk_role is 'ノ孅à︹';
create table mk_user (  
  ID       NUMBER primary key,
  USERNAME VARCHAR2(10) unique,
  PASSWORD VARCHAR2(20),
  SEX      varchar2(4),
  AGE      NUMBER,
  MOBILE   varchar2(18),
  ADDRESS  VARCHAR2(10),
  roleid   number
);
drop table mk_user;
  comment on table mk_user is 'ノ孅';
  comment on table mk_user.username is 'ノ孅';
  comment on table mk_user.password is '盞?ノmd5?';
  comment on table mk_user.sex is '┦?';
  comment on table mk_user.age is '?';
  comment on table mk_user.mobile is 'も审彮';
  comment on table mk_user.address is '';
  comment on table mk_user.roleid is 'à︹id';
  commit;
  
alter table mk_user add constraint fk_role foreign key (roleid) references mk_role(roleid);
create table mk_product(
  id            number primary key ,
  NAME          VARCHAR2(10) not null,
  UNIT          VARCHAR2(10) not null
);
create table mk_provider(
  ID          NUMBER primary key,
  NAME    VARCHAR2(10),
  CONTACT VARCHAR2(10),
  pro_desc    VARCHAR2(10),
  PHONE   VARCHAR2(10),
  ADDRESS VARCHAR2(10),
  FAX     VARCHAR2(10)
);
create table c_provide(
  id number,
  provider_id number ,
  product_id number ,
  price number,
  primary key  (id),
  foreign key (provider_id) references mk_provider(id),
  foreign key (product_id) references mk_product(id)
);
create table mk_Order(
  ID       NUMBER primary key,
  TIME     DATE,
  ISPAY    NUMBER,
  MONEY    VARCHAR2(10),
  COUNTS   NUMBER,
  order_DESC     VARCHAR2(100),
  c_pid number ,
  foreign key (c_pid) references c_provide(id)
);
commit;
commit;
--each table has its sequence 
create sequence seq_user start with 10
increment by 1
maxvalue 2000 nocycle;
create sequence seq_role start with 10
increment by 1
maxvalue 2000 nocycle;
create sequence seq_product start with 10
increment by 1
maxvalue 2000 nocycle;
create sequence seq_provide start with 10
increment by 1
maxvalue 2000 nocycle;
create sequence seq_provider start with 10
increment by 1
maxvalue 2000 nocycle;
create sequence seq_order start with 10
increment by 1
maxvalue 2000 nocycle;
select seq_user.nextval from dual;

drop sequence seq_bill;

--add user return id generate by seq_user
create or replace function addUser (uname mk_user.username%type, pwd mk_user.password%type, sex mk_user.sex%type,
       birth mk_user.birth%type, mobile mk_user.mobile%type, add mk_user.address%type, rid mk_user.roleid%type
       )return mk_user.id%type
as
       uid mk_user.id%type;
begin
  insert into mk_user (id, username, password, sex, birth, mobile, address, roleid) values 
  (seq_user.nextval, uname, pwd, sex, birth, mobile, add, rid) return id into uid;
  commit;
  return uid;
end;
/
set serveroutput on;
declare
       uid mk_user.id%type;
begin
 uid:= addUser ('shark', '123', '男', 19, '15556925243', '安徽凤台', '1');
 dbms_output.put_line('已添加，ID为：'||uid);
end;
/

--add Provider return id generated by seq_provider
create or replace function addProvider(
       fname mk_provider.name%type, fcontact mk_provider.contact%type, fpro_desc mk_provider.pro_desc%type,
       fphone mk_provider.phone%type, fadd mk_provider.address%type, ffax mk_provider.fax%type
       )return mk_provider.id%type
as
        pid mk_provider.id%type:=0;
begin
  insert into mk_provider(id, name, contact, pro_desc, phone, address, fax) 
  values (seq_provider.nextval, fname, fcontact, fpro_desc,fphone, fadd, ffax)
  returning id into pid;
  commit;
  return pid;
end;
/
  
declare
  pid mk_provider.id%type;
begin
  pid:=addProvider( '魔王Boss', '11223', '便宜到爆','1122334', 'nowhere', '1234567' );
  dbms_output.put_line ('插入的供应商id：'||pid);
end;
/

--add Order return id --seq_order; time -- sysdate; mon autosum;
create or replace procedure addOrder (
       paid mk_order.ispay%type ,vcount mk_order.counts%type, 
       des mk_order.order_desc%type, cpid mk_order.c_pid%type,
       bid out mk_order.id%type, ctime out mk_order.time%type, mon out mk_order.money%type)
as
       cprice c_provide.price%type;
begin
  select price into cprice from c_provide where id=cpid;
  mon := vcount * cprice;
  insert into mk_order (id, time, ispay, money, counts, order_desc, c_pid)
  values (seq_order.nextval, sysdate, paid, mon, vcount, des, cpid)returning id, time into bid, ctime ;
  commit;
end;
/
select * from mk_order
declare
       bid mk_order.id%type; 
       ctime  mk_order.time%type; 
       mon mk_order.money%type; 
begin
       addorder (2, 13, '愉快的交易', '2', bid, ctime, mon );
       dbms_output.put_line(bid ||' createtime:'|| ctime || ' money:'|| mon);
end;
/
select * from mk_order;
commit;

select * from mk_user;
select * from mk_role;
select rolename from mk_role where roleid=1;
select * from mk_user where id = 17;
alter table mk_user add constraint uq_uname unique (username);

create table dateTest(
       ctime date primary key
);
commit;
insert into dateTest values ( To_date('2000-12-19','yyyy-mm-dd'))
select * from mk_user;

update mk_user set sex= '男',
       mobile = '98089089089'
        where id=31;
commit;

 select rolename from mk_role where roleid= 32 
 
 select * from mk_user;

