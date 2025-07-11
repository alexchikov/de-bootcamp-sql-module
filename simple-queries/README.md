 # SQL: Simple queries

---

- [SQL: Simple queries](#sql-simple-queries)
  - [Структура SQL запроса](#структура-sql-запроса)
  - [Фильтрация данных](#фильтрация-данных)
  - [Встроенные функции](#встроенные-функции)
  - [Группировка](#группировка)
  - [NULL](#null)


---

**SQL (Structured Query Language)** &mdash; предметно-ориентированный язык, используемый для управления данными, особенно в системах управления реляционными базами данных (СУБД).

## Структура SQL запроса


Структура SQL запроса не так уж и сложна и может быть представлена следующим образом:

```sql
[SELECT] col
[FROM] t
JOIN t2 ON join_condition
WHERE condition
GROUP BY col1, col2
HAVING another_condition
ORDER BY col
```

В квадратных скобках отмечены операторы обязательные для каждого запроса (хотя если вы хотите просто, что-то вывести, то можно обойтись даже и без `FROM`).

Теперь рассмотрим, в каком порядке будут выполняться операторы из нашего SQL запроса:
1. Первым будет обработан оператор `FROM`. Он указывает на место, откуда необходимо получить данные. Также сюда можно отнести и оператор `JOIN`, если он используется. В нем мы также можем указать другой источник данных, который хотим присоединить к первому.
2. Далее будет обработан оператор `WHERE`. Он отвечает за фильтрацию источника по заданому условию.
3. После этого будет выполнен оператор группировки `GROUP BY`. Он группирует данные по определенным столбцам. Затем мы можем, например, применить к этим группам агрегирующие функции.
4. После этого будет обработан оператор `HAVING`. Он проводит фильтрацию уже по сгруппированным данным.
5. Затем обрабатывается оператор `SELECT`, казалось бы указанный самым первым в запросе, но он будет обработан одним из последних. В нем мы указываем данные которые хотим получить в результате выполнения запроса.
6. Последним будет обработан `ORDER BY`. Здесь мы указываем столбцы, по которым хотим провести сортировку данных, полученных в результате всех предыдущих шагов. Для описания характера сортировки (то есть по убыванию или по возрастанию) используются ключевые слова `ASC` или `DESC`, что означает соответственно ascending или descending. Однако слово `ASC` можно не указывать, так как сортировка по умолчанию проводится по возрастанию.

## Фильтрация данных

Для фильтрации данных используются оператор `WHERE` и реже `HAVING`. Для того, чтобы отфильтровать данные, необходимо задать условие, по которому будут отбираться данные. Это могут быть разные условия и для каждой специфики существуют различные операторы сравнения или условия:
1. Самые базовые это математические операторы сравнения `>`, `<`, `=` и `!=`. Они, соответственно, означают "больше", "меньше", "равно" и "не равно". Таким образом, с помощью таких операторов мы можем проверять на равенство значения определенных столбцов или сравнивать математические значения. Пример запроса с такими операторами:
   ```sql
   SELECT id
   FROM some_table
   WHERE id = 5
   ```
2. Также можно использовать сложные условия для фильтрации данных с помощью `AND` и `OR`. Пример запроса с таким условием:
   ```sql
   SELECT id
   FROM some_table
   WHERE customer_name = 'Вася' OR (id >= 2 AND id < 5)
   ```
3. Для того, чтобы указывать несколько значений для сравнения в условии, вместо того, чтобы использовать несколько выражений с `OR`, мы можем использовать оператор `IN`. Пример того, как это упрощает структуру запроса:
   ```sql
   -- Пример запроса с несколькими OR
   SELECT id
   FROM some_table
   WHERE customer_name = 'Вася' 
      OR customer_name = 'Саша' 
      OR customer_name = 'Акакий' 
      OR customer_name = 'Никита'
   ```
   ```sql
   -- Пример того, как можно упростить структуру запроса с помощью IN
   SELECT id
   FROM some_table
   WHERE customer_name IN ('Вася', 'Саша', 'Акакий', 'Никита')
   ```
4. Для отрицания же, в SQL существует оператор `NOT`. Так, например, в связке с оператором `IN` можно исключать какие-то значения из выборки. Пример:
   ```sql
   SELECT id
   FROM some_table
   WHERE customer_name NOT IN ('Вася', 'Саша')
   ```
5. Также, для выборки значений в определенных границах можно использовать оператор `BETWEEN`. Структура оператора такая `BETWEEN нижняя_граница AND верхняя_граница`. Пример:
   ```sql
   SELECT id
   FROM some_table
   WHERE id BETWEEN 1 AND 5
   ```
6. Ну и последний способ фильтровать выборку &mdash; оператор `LIKE`. `LIKE` позволяет фильтровать значения по заданному регулярному выражению. Например, нам нужно найти всех пользователей по имени `"Дмитрий"`. Для этого можно написать такой запрос:
   ```sql
   SELECT id
   FROM some_table
   WHERE customer_name LIKE "Дмитрий%"
   ```
   `%` в выражении означает, что на этом месте может появиться один или более символов. Также есть `_` &mdash; он означает, что на этом месте может быть либо пропуск, либо один символ, не более;

## Встроенные функции

При составлении SQL-запроса мы можем использовать встроенные в SQL функции. Например такие, как `UPPER()`, `LOWER()`, `DATE_ADD()`, `DATE_TRUNC()` и другие. Ниже приведена картинка с основными функциями и их описанием:

![Основные функции в SQL](https://miro.medium.com/v2/resize:fit:828/format:webp/1*u_GC6aocrChC1v5UlxEGuQ.png)

## Группировка

Теперь поговорим о группировке в SQL. Группировка данных помогает объединять строки с одинаковыми значениями в указанных полях, чтобы потом можно было посчитать что-то отдельно для каждой группы. Для этого используется оператор `GROUP BY`.

Группировка в SQL работает с записями таблицы, объединяя их в отдельные группы для последующего анализа.

При работе с группами возможны два варианта:
* вывести поле, по которому происходит группировка &mdash; его значение будет одинаковым для всей группы;
* применить к другим полям агрегатные функции, такие как `COUNT()`, `MAX()`, `MIN()` или `AVG()`, чтобы обобщить данные внутри каждой группы.

![Основные агрегирующие функции в SQL](https://miro.medium.com/v2/resize:fit:1106/1*83CDz5YWSLnHleVHu94F5g.png)

Пример запроса с группировкой:

```sql
SELECT gender, age, city, SUM(some_value) AS total_value
FROM some_table
GROUP BY gender, age, city
```

## NULL

`NULL` в SQL используется, когда значение не указано в поле. 

