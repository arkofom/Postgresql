with "TABLE" as (select temp_table.name, temp_table.id_goods, temp_table.ddate, temp_table.id_partner, count(*)
                 from (
                          select distinct goods.name,
                                          price_list.id_goods,
                                          price_list.ddate,
                                          group_price.id_partner,
                                          price_list.id_prlist
                          from price_list
                                   join goods on goods.id = price_list.id_goods
                                   join group_part on group_part.id_goods_group = goods.id_group
                                   join group_price
                                        on price_list.id_prlist = group_price.id_prlist and
                                           group_price.id_ggroup_part = group_part.id_ggroup_part) temp_table
                 group by temp_table.name, temp_table.id_goods, temp_table.ddate, temp_table.id_partner
                 having count(*) > 1)
select goods.name,
       price_list.id_goods,
       price_list.ddate,
       group_price.id_partner,
       string_agg(price_list.id_prlist::text, ',')
from price_list
         join goods on goods.id = price_list.id_goods
         join group_part on group_part.id_goods_group = goods.id_group
         join group_price
              on price_list.id_prlist = group_price.id_prlist and group_price.id_ggroup_part = group_part.id_ggroup_part
where price_list.id_goods in (select id_goods from "TABLE")
  and price_list.ddate in (select ddate from "TABLE")
  and group_price.id_partner in (select id_partner from "TABLE")
group by goods.name, price_list.id_goods, price_list.ddate, group_price.id_partner;