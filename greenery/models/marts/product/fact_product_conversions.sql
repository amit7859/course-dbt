{{
  config(
    materialized='table'
  )
}}

select distinct
    views.session_id,
    views.user_id,
    views.product_id,
    orders.order_id, 
    orders.quantity 
from {{ ref('fact_session_product_views') }} as views 
left join {{ ref('fact_session_product_orders') }} as orders
on views.product_id = orders.product_id
and views.session_id = orders.session_id 


