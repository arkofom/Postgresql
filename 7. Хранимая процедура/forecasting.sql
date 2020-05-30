drop function if exists moving_average(d1 date, d2 date);

create or replace function moving_average(d1 date, d2 date)
    returns table
            (
                client     int,
                goods      int,
                date       date,
                volume     int,
                prediction double precision
            )
as
$$
declare
    cursor cursor for
        select recept.storage                                                      st,
               recgoods.goods                                                      g,
               recept.ddate                                                        d,
               sum(recgoods.volume * goods.length * goods.height * goods.width) as vol
        from recept
                 join recgoods on recept.id = recgoods.id
                 join goods on recgoods.goods = goods.id
        where recept.ddate >= d1
          and recept.ddate <= d2
        group by recept.storage, recgoods.goods, recept.ddate
    ;
    cnt          int := 0;
    temp_cnt     int := 0;
    pred         double precision;
    prev_storage int;
    prev_goods   int;
--
    storage      int;
    goods        int;
    date         date;
    volume       int;
begin
    create temp table tmp
    (
        goods_id int,
        date     date,
        volume   int
    );
    create temp table to_return
    (
        client     int,
        goods      int,
        date       date,
        volume     int,
        prediction double precision
    );
    open cursor;
    loop
        fetch cursor into storage, goods, date, volume;
        exit when not found;

        if storage != prev_storage or goods != prev_goods then
            temp_cnt := 1;
            truncate tmp;
            insert into tmp values (goods, date, volume);
            insert into to_return (client, goods, date, volume, prediction)
            values (client, goods, date, volume, volume);
        else
            if temp_cnt < 2 then
                temp_cnt = temp_cnt + 1;
                insert into to_return (client, goods, date, volume, prediction)
                values (client, goods, date, volume, volume);
                insert into tmp values (goods, date, volume);
            else
                temp_cnt = temp_cnt + 1;
                insert into to_return (client, goods, date, volume, prediction)
                values (client, goods, date, volume, (select avg(tmp.volume) from tmp));
                delete from tmp where tmp.date in (select tmp.date from tmp order by tmp.date asc limit 1);
                insert into tmp values (goods, date, volume);
            end if;
        end if;
        prev_goods = goods;
        prev_storage = storage;
        cnt := cnt + 1;
    end loop;

    close cursor;
    return query select * from to_return;
    drop table to_return;
    drop table tmp;
end
$$ language plpgsql;

select *
from moving_average('2020-02-01', '2020-12-31');