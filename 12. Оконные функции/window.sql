select ndoc,
       ddate,
       goods.name,
       client.name,
       recgoods.volume * recgoods.price as sum,
       avg(recgoods.volume * recgoods.price)
       over (partition by goods order by extract(month from ddate)) as avgerage,
       sum(recgoods.volume * recgoods.price)
       over (partition by ddate order by recgoods.volume * recgoods.price) as day_sum
from recept
         join recgoods on recept.id = recgoods.id
         join client on recept.client = client.id
         join goods on recgoods.goods = goods.id