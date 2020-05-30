drop table if exists partners cascade;
drop table if exists goods_group cascade;
drop table if exists goods cascade;
drop table if exists price_lists cascade;
drop table if exists price_list cascade;
drop table if exists group_parts cascade;
drop table if exists group_part cascade;
drop table if exists group_price cascade;

create table partners
(
    id   serial,
    name text,
    primary key (id)
);
create table goods_group
(
    id   serial,
    name text,
    primary key (id)
);
create table goods
(
    id       serial,
    name     text,
    id_group int references goods_group (id),
    primary key (id)
);
create table price_lists
(
    id   serial,
    name text,
    primary key (id)
);
create table price_list
(
    id        serial,
    id_prlist int references price_lists (id),
    id_goods  int references goods (id),
    price     decimal(18, 4),
    ddate     date,
    primary key (id)
);
create table group_parts
(
    id   serial,
    name text,
    primary key (id)
);
create table group_part
(
    id             serial,
    id_ggroup_part int references group_parts (id),
    id_goods_group int references goods_group (id),
    primary key (id)
);
create table group_price
(
    id             serial,
    id_prlist      int references price_lists (id),
    id_ggroup_part int references group_parts (id),
    id_partner     int references partners (id),
    primary key (id)
);

insert into partners(name)
select ('partner ' || t)::text
from generate_series(1, 20) t;

insert into goods_group(name)
select ('goods group ' || t)::text
from generate_series(1, 10) t;

insert into goods(name, id_group)
select ('goods ' || t)::text,
       (select id
        from goods_group
        where t > 0
        order by random()
        limit 1)
from generate_series(1, 50) t;

insert into price_lists(name)
select ('price_list ' || t)::text
from generate_series(1, 20) t;

insert into price_list(id_prlist, id_goods, price, ddate)
select (select id
        from price_lists
        where t > 0
        order by random()
        limit 1),
       (select id
        from goods
        where t > 0
        order by random()
        limit 1),
       t * 2.5,
       '2020-03-01'::date + t
from generate_series(1, 30) t;

insert into group_parts(name)
select ('group parts ' || t)::text
from generate_series(1, 10) t;

insert into group_part(id_ggroup_part, id_goods_group)
select (select id
        from group_parts
        where t > 0
        order by random()
        limit 1),
       (select id
        from goods_group
        where t > 0
        order by random()
        limit 1)
from generate_series(1, 30) t;

insert into group_price(id_prlist, id_ggroup_part, id_partner)
select (select id
        from price_lists
        where t > 0
        order by random()
        limit 1),
       (select id
        from group_parts
        where t > 0
        order by random()
        limit 1),
       (select id
        from partners
        where t > 0
        order by random()
        limit 1)
from generate_series(1, 30) t;
