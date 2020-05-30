create or replace function Inserted() returns trigger as
    $$
    --Функция поддерживает актуальность состояния таблиц remains и irlink
    --При добавлении расхода функция осуществляет пересчет остатков
    --в соответствии с учетной политикой, заданной в варианте
    --Каждое изменение остатка логгируется в таблице irlink
    declare
        recept_storage integer;
        recept_date date;
        item record;
        new_value int;

    begin
        --Находим склад с которого был произведен расход
        --а так же дату расхода
            select
                recept.storage,
                recept.ddate
            into recept_storage, recept_date
            from recept
            where recept.id = new.id;

        --находим все остатки расходуемого товара на найденном складе
        --найденные значения помещаем во временную таблицу
        drop table if exists rms;
        create temp table rms(
              id int,
              subid int,
              goods int,
              ddate date, -- прихода
              volume int
        );

        insert into rms(id, subid, goods, ddate, volume)
        select
            r.id,
            r.subid,
            r.goods,
            r.ddate,
            r.volume
        from remains r
        where r.goods = new.goods
        and r.ddate < recept_date
        and r.storage = recept_storage
        order by ddate;

        --в цикле проходим по всем выбранным остаткам
        --осуществляем вычеты согласно политике fifo
        --если остаток равен нулю удаляем запись из таблицы ремейнс
        --после каждого вычета сохраняем информацию в таблицу irlink
        new_value = new.volume;
        for item in select * from rms
        loop
            if (item.volume <= new_value) then
                new_value = new_value - item.volume;
                insert into
                    irlink(i_id, i_subid, r_id, r_subid, goods, volume)
                values
                       (item.id, item.subid, new.id, new.subid, new.goods, item.volume);
                delete from remains where remains.id = item.id;
            else
                insert into
                    irlink(i_id, i_subid, r_id, r_subid, goods, volume)
                values
                       (item.id, item.subid, new.id, new.subid, new.goods, new_value);

                update remains
                set volume = item.volume - new_value
                where remains.id = item.id;
                new_value = 0;
            end if;
        exit when new_value = 0;
        end loop;

        return new;
    end;
    $$ language plpgsql;

create or replace function Inserting() returns trigger as
    $$
    --Функция проверяет корректность расхода товара
    --расход корректен в том случае, если кол-во проданного товара
    --не превышает кол-во товара, оставшегося на складе
    --Если необходимого количества товара нет на складе - кинуть exception
    declare
        recept_storage integer;
        recept_date date;
        sum integer;
    begin
        select
            recept.storage,
            recept.ddate
        into recept_storage, recept_date
        from recept
        where recept.id = new.id;

        sum = (
            select sum(volume)
            from remains
            where remains.goods = new.goods
            and remains.ddate < recept_date
            and remains.storage = recept_storage
        ); --текущий остаток на складе

        if (new.volume  > sum) then
            raise exception 'Remains amount cant be less than check amount';
        end if;

        return new;
    end
    $$ language plpgsql;

drop trigger  if exists onInserted on recgoods;
drop trigger if exists oninserting on recgoods;
create trigger onInserted
after insert on recgoods for each row execute procedure Inserted();

create trigger onInserting
before insert on recgoods for each row execute procedure Inserting();