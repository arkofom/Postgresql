with product as (select price_list.id_goods,
                        goods.name,
                        goods.id_group,
                        group_part.id_ggroup_part,
                        price_list.price,
                        price_list.ddate,
                        price_list.id_prlist
                 from price_list
                          join goods on goods.id = price_list.id_goods
                          join group_part on group_part.id_goods_group = goods.id_group)

select distinct product.name, product.price
from group_price
         join product
              on product.id_prlist = group_price.id_prlist and group_price.id_ggroup_part = product.id_ggroup_part
where group_price.id_partner = 4
  and product.ddate = '2020-03-04';
