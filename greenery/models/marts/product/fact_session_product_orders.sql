{{
  config(
    materialized='table'
  )
}}

select distinct
    events.session_id,
    events.user_id,
    events.order_id,
    order_items.product_id,
    order_items.quantity 
from {{ ref('stg_postgres__events') }} as events
inner join {{ ref('stg_postgres__order_items') }} as order_items
on events.order_id = order_items.order_id
where events.event_type = 'checkout'


