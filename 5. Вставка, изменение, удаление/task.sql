drop table if exists temp;
create table temp
(
    date       date,
    warehouse  int,
    ssum       int,
    volume     int,
    uniq_goods int
);

-- вставка
insert into temp(date, warehouse, ssum, volume, uniq_goods)
select income.ddate,
       income.storage,
       sum(incgoods.volume * incgoods.price)                            as ssum,
       sum(goods.height * goods.width * goods.length * incgoods.volume) as volume,
       count(distinct incgoods.goods)
from income
         join incgoods on income.id = incgoods.id
         join goods on goods.id = incgoods.goods
group by income.ddate, income.storage;

-- изменение
alter table storage
    add column active int;
with warehourse_sales as (
    select recept.storage, sum(recgoods.volume * recgoods.price) as ssum
    from recept
             join recgoods on recept.id = recgoods.id
    where recept.ddate > date_trunc('month', current_date - interval '1' month)
    group by recept.storage
    having sum(recgoods.volume * recgoods.price) > 10000)

update storage
set active = 1
where id in (select storage from warehourse_sales);

select *
from storage;

-- удаление
delete
from goods
where id not in (select goods from recgoods)
  and id not in (select goods from incgoods)
returning id;