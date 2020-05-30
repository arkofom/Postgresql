# Задачи по курсу "Системы обработки аналитической информации"
1. [Цена на дату](https://github.com/arkofom/Postgresql/tree/master/1.%20%C2%A0%D0%A6%D0%B5%D0%BD%D0%B0%20%D0%BD%D0%B0%20%D0%B4%D0%B0%D1%82%D1%83)

2. [Прайсы](https://github.com/arkofom/Postgresql/tree/master/2.%20%D0%9F%D1%80%D0%B0%D0%B9%D1%81%D1%8B)
- Давайте наполним базу псевдослучайными тестовыми данными
- Давайте проверим что прайсы партнеров не пересекаются
- Давайте напишем вывод прайсов конкретного партнера на заданную дату

3. [Запросы](https://github.com/arkofom/Postgresql/tree/master/3.%20%D0%97%D0%B0%D0%BF%D1%80%D0%BE%D1%81%D1%8B)
- Покупки: Город, Дата, Номер документа, Название группы товара, Название товара, Объем. Выборка за второй квартал 2020 года, Объемом более 10 м3
- Продажи: Адрес, Дата, Номер документа, Название склада, Название товара, Вес, Сумма. Выборка за февраль 2020 года по региону Москва, только по товарам по которым были покупки в 2019 году.
- Выбрать 10 случайных записей из запроса с продажами.

4. [Контрольная](https://github.com/arkofom/Postgresql/tree/master/4.%20%D0%9A%D0%BE%D0%BD%D1%82%D1%80%D0%BE%D0%BB%D1%8C%D0%BD%D0%B0%D1%8F)
Переписать запрос без слов GROUP BY используя стандартные возможности SQL

5. [Вставка, изменение и удаление](https://github.com/arkofom/Postgresql/tree/master/5.%20%D0%92%D1%81%D1%82%D0%B0%D0%B2%D0%BA%D0%B0%2C%20%D0%B8%D0%B7%D0%BC%D0%B5%D0%BD%D0%B5%D0%BD%D0%B8%D0%B5%2C%20%D1%83%D0%B4%D0%B0%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5)
- Давайте создадим и заполним таблицу по поставкам в разрезе дней и складов:
Дата, Склад, Сумма руб., Объем м3, Число разных товаров
- Давайте заведем у Склада поле Признак активности.
Написать запрос, который установит Признак = 1, если со склада были продажи более чем на 10000 руб. за последний месяц.
- Давайте удалим из таблицы товаров все товары по которым не было продаж и поставок

6. [Посчитать остатки на складах по всем дням периода с 1 марта 2020 года по 14 марта 2020 года](https://github.com/arkofom/Postgresql/tree/master/6.%20%D0%9E%D1%81%D1%82%D0%B0%D1%82%D0%BA%D0%B8%20%D0%BD%D0%B0%20%D1%81%D0%BA%D0%BB%D0%B0%D0%B4%D0%B0%D1%85%20)

7. [Прогноз продаж через хранимую процедуру](https://github.com/arkofom/Postgresql/tree/master/7.%20%D0%A5%D1%80%D0%B0%D0%BD%D0%B8%D0%BC%D0%B0%D1%8F%20%D0%BF%D1%80%D0%BE%D1%86%D0%B5%D0%B4%D1%83%D1%80%D0%B0)

8. [Триггер](https://github.com/arkofom/Postgresql/tree/master/8.%20%D0%A2%D1%80%D0%B8%D0%B3%D0%B3%D0%B5%D1%80)

9. [Контрольная на создание последовательности](https://github.com/arkofom/Postgresql/tree/master/9.%20%D0%9A%D0%BE%D0%BD%D1%82%D1%80%D0%BE%D0%BB%D1%8C%D0%BD%D0%B0%D1%8F%20%D0%BD%D0%B0%20%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%20%D0%BF%D0%BE%D1%81%D0%BB%D0%B5%D0%B4%D0%BE%D0%B2%D0%B0%D1%82%D0%B5%D0%BB%D1%8C%D0%BD%D0%BE%D1%81%D1%82%D0%B8)

10. [Контрольная. Дерево товаров](https://github.com/arkofom/Postgresql/tree/master/10.%20%D0%9A%D0%BE%D0%BD%D1%82%D1%80%D0%BE%D0%BB%D1%8C%D0%BD%D0%B0%D1%8F%20%D0%B4%D0%B5%D1%80%D0%B5%D0%B2%D0%BE%20%D1%82%D0%BE%D0%B2%D0%B0%D1%80%D0%BE%D0%B2)

11. [Дерево клиентов. Lateral последовательностей](https://github.com/arkofom/Postgresql/tree/master/11.%20%D0%94%D0%B5%D1%80%D0%B5%D0%B2%D0%BE%20%D0%BA%D0%BB%D0%B8%D0%B5%D0%BD%D1%82%D0%BE%D0%B2%2C%20lateral%20%D0%BF%D0%BE%D1%81%D0%BB%D0%B5%D0%B4%D0%BE%D0%B2%D0%B0%D1%82%D0%B5%D0%BB%D1%8C%D0%BD%D0%BE%D1%81%D1%82%D0%B5%D0%B9)

12. [Оконные функции](https://github.com/arkofom/Postgresql/tree/master/12.%20%D0%9E%D0%BA%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D1%84%D1%83%D0%BD%D0%BA%D1%86%D0%B8%D0%B8)

13. [Прогноз через Python](https://github.com/arkofom/Postgresql/tree/master/13.%20%D0%9F%D1%80%D0%BE%D0%B3%D0%BD%D0%BE%D0%B7%20%D1%87%D0%B5%D1%80%D0%B5%D0%B7%20Python)

14. [Соревнование по мерам и измерениям (в классе)](https://github.com/arkofom/Postgresql/tree/master/14.%20%D0%A1%D0%BE%D1%80%D0%B5%D0%B2%D0%BD%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5%20%D0%BF%D0%BE%20%D0%BC%D0%B5%D1%80%D0%B0%D0%BC%20%D0%B8%20%D0%B8%D0%B7%D0%BC%D0%B5%D1%80%D0%B5%D0%BD%D0%B8%D1%8F%D0%BC)

15. [Наполним транзакционную базу, заполним случайными данными, создадим хранилище, напишем ETL, пришлем мне 2 дампа и все скрипты.](https://github.com/arkofom/Postgresql/tree/master/15.%20%D0%A2%D1%80%D0%B0%D0%BD%D0%B7%D0%B0%D0%BA%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D0%B0%D1%8F%20%D0%B1%D0%B0%D0%B7%D0%B0%2C%20%D0%B7%D0%B0%D0%BF%D0%BE%D0%BB%D0%BD%D0%B5%D0%BD%D0%B8%D0%B5%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D0%BC%D0%B8%2C%20%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5%20%D1%85%D1%80%D0%B0%D0%BD%D0%B8%D0%BB%D0%B8%D1%89%D0%B0%2C%20ETL%2C%20%D0%94%D0%B0%D0%BC%D0%BF%D1%8B)

16. [Создать MOLAP icCube и написать MDX](https://github.com/arkofom/Postgresql/tree/master/16.%20MOLAP%20icCube%20%20MDX)
