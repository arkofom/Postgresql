with temp_dates as (
    select date
    from generate_series('2020-03-01' :: date, '2020-03-14', '1 day') date
)
select temp_income.date,
       temp_income.storage,
       temp_income.goods,
       case
           when temp_recept.recept_volume is null then temp_income.income_volume
           when temp_income.income_volume is null then -temp_recept.recept_volume
           else (temp_income.income_volume - temp_recept.recept_volume)
           end as remnants

from (select temp_dates.date,
             income.storage,
             incgoods.goods,
             sum(incgoods.volume) income_volume
      from income
               join incgoods
                    on incgoods.id = income.id
               join temp_dates on income.ddate <= temp_dates.date
      group by temp_dates.date, income.storage, incgoods.goods
     ) temp_income
         full join
     (select temp_dates.date,
             recept.storage,
             recgoods.goods,
             sum(recgoods.volume) recept_volume
      from recept
               join recgoods on recgoods.id = recept.id
               join temp_dates on recept.ddate <= temp_dates.date
      group by temp_dates.date, recept.storage, recgoods.goods
     ) temp_recept
     on temp_recept.storage = temp_income.storage and temp_recept.goods = temp_income.goods
         and temp_recept.date = temp_income.date

order by temp_income.date, temp_income.storage

