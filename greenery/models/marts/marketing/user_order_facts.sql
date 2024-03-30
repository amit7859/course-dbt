{{
  config(
    materialized='table'
  )
}}


select 
    user_id, 
    min(created_at) as first_order_at, 
    max(created_at) as last_order_at, 
    count(distinct order_id) as num_orders, 
    sum(order_total) as total_orders_value 
from {{ ref('stg_postgres__orders') }} 
group by 1

