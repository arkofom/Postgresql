drop function if exists seq(int);

create or replace function seq(n int)
    returns table
            (
                num int
            )
as
$$
declare
    i int;
begin
    create temp table t
    (
        num int
    );
    i = 0;
    if (n < 1) then
        return query select * from t;
        drop table t;
    end if;

    loop
        exit when i = n;
        i = i + 1;
        insert into t values (i);
    end loop;

    return query select * from t;
    drop table t;
end;
$$ language plpgsql;

select *
from seq(10);
