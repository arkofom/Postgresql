drop table if exists g;
create table if not exists g
(
    id    serial,
    pid   int,
    price int,
    ddate date
);
insert into g(pid, price, ddate)
values (1, 120, '2018-06-06'),
       (2, 130, '2018-07-06'),
       (3, 140, '2018-02-04'),
       (4, 150, '2019-06-06'),
       (2, 160, '2018-10-05'),
       (3, 170, '2018-12-06'),
       (1, 180, '2019-01-10'),
       (5, 190, '2018-12-06'),
       (1, 200, '2018-10-12'),
       (2, 210, '2019-02-06'),
       (3, 220, '2019-03-15');



with a_ as (
    select price, ddate date, row_number() over () as rn
    from (
             select price, ddate
             from g
             where id = 2
               and ddate <= '2018-10-04'
             order by ddate desc
         ) as t
)

select price, date
from a_
where rn = 1;