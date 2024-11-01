create table test1 (
       employee_id number,
       working_id number,
       xlld varchar2(30)
);

create table test2 (
       employee_id number,
       working_id number,
       xlld varchar2(30)
);

insert into test1 values (1, 1, '');
insert into test1 values (2, 2, '');
insert into test1 values (3, 3, '');

insert into test2 values (1, 1, 'a01');
insert into test2 values (2, 2, 'b02');
insert into test2 values (3, 3, 'c03');


select *
from test1;

select *
from test2


update test1 b1
set b1.xlld = (select b2.xlld
              from test2 b2
              where b2.employee_id = b1.employee_id
                    and b2.working_id = b1.working_id);
                    
-- xóa bảng
drop table test1;
drop table test2;