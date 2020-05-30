select distinct key1,
                key2,
                (
                    select sum(data1)
                    from dd x
                    where x.key1 = y.key1
                      and x.key2 = y.key2
                )
                       ssum,
                (
                    select min(data2)
                    from dd x
                    where x.key1 = y.key1
                      and x.key2 = y.key2
                )
                    as mmin
from dd y;