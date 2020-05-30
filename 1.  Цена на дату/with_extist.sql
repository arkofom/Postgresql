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


select price, ddate date
from g g1
where g1.pid = 2
  and g1.ddate <= '2018-10-04'
  and not exists(
        select *
        from g g2
        where g2.pid = g1.pid
          and g1.ddate < g2.ddate
          and g2.ddate <= '2018-10-04'
    );
