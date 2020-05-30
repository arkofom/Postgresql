select *
from (select city.name                                    city,
             region.name                                  region,
             income.ndoc                                  document_number,
             goods_groups.name                            g_group,
             goods.name                                   goods,
             (goods.weight * goods.length * goods.height) volume
      from region
               join city on region.id = city.region
               join client on city.id = client.city
               join income on client.id = income.client
               join incgoods on income.id = incgoods.id
               join goods on incgoods.goods = goods.id
               join goods_groups on goods.g_group = goods_groups.id
      where income.ddate > '01-04-2020'
        and volume > 10) as foo
order by random()
limit 10