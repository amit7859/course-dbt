

**How many users do we have?**

``` sql
select count(*) from stg_postgres__users
``` 

There are 130 users. 

**On average, how many orders do we receive per hour?**

``` sql
select count(*) / (datediff(second, to_timestamp(min(created_at)), to_timestamp(max(created_at))) / (60*60)) from stg_postgres__orders
```

Approximately, 7.53 orders per hour

**On average, how long does an order take from being placed to being delivered?**

``` sql
select avg(datediff(second, created_at, delivered_at)) / (60*60) from stg_postgres__orders where delivered_at is not null
```

Approximately, 93.4 hours per order

**How many users have only made one purchase? Two purchases? Three+ purchases?**

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

``` sql

with orders_per_user as (
    select user_id, count(*) as order_count_per_user from stg_postgres__orders group by user_id order by order_count_per_user
    ) 
    select order_count_per_user as count_orders, count(*) as num_users from orders_per_user group by order_count_per_user order by count_orders

```

* 25 users with 1 order each
* 28 users with 2 orders each
* 34 users with 3 orders each 
* 37 users with 4+ orders each 


**On average, how many unique sessions do we have per hour?**

``` sql
with sessions as (select session_id, min(created_at) as session_start_time from stg_postgres__events group by session_id) 
select count(*) / (datediff(second, min(session_start_time), max(session_start_time)) / (60*60)) from sessions 
```

Approximately, 12.06 sessions per hour 


