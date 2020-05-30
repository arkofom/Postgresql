with recursive temp as (
    select g1.id, g1.name, g1.parent, g2.name parent_name
    from goods_groups g1
             join goods_groups g2 on g2.id = g1.parent
    union all
    select goods_groups.id, goods_groups.name, temp.parent, gp.name
    from goods_groups
             join temp on temp.id = goods_groups.parent
             join goods_groups gp on gp.id = temp.parent)

select *
from temp;