drop function if exists exp_average(d1 date, d2 date, alpha double precision);

create or replace function exp_average(d1 date, d2 date, alpha double precision)
    returns table
            (
                storage    int,
                goods      int,
                date       date,
                volume     int,
                prediction double precision
            )
as
$$
declare
    cursor cursor for select recept.storage  st,
                             recgoods.goods g,
                             recept.ddate d,
                             sum(recgoods.volume * goods.length * goods.height * goods.width) as vol
                      from recept
                               join recgoods on recept.id = recgoods.id
                               join goods on recgoods.goods = goods.id
                      where recept.ddate >= d1
                        and recept.ddate <= d2
                      group by recept.storage, recgoods.goods, recept.ddate
                      order by recept.storage, recgoods.goods, recept.ddate

    ;
    cnt int := 0;
    prev_prediction double precision;
    prev_storage int := -1;
    prev_goods int := -1;

--
    storage int;
    goods int;
    date date;
    vol int;
begin
    create temp table to_return
    (
        storage    int,
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
            insert into to_return (storage, goods, date, volume, prediction)
            values (storage, goods, date, volume, volume);
            prev_prediction = volume;
        else
            insert into to_return (storage, goods, date, volume, prediction)
            values (storage, goods, date, volume, volume * alpha + (1 - alpha) * prev_prediction);
            prev_prediction = volume * alpha + (1 - alpha) * prev_prediction;
        end if;

        prev_goods = goods;
        prev_storage = storage;
        cnt := cnt + 1;
    end loop;

    close cursor;
    return query select * from to_return;
    drop table to_return;
end
$$ language plpgsql;

select *
from exp_average('2020-02-01', '2020-12-31', 0.1);