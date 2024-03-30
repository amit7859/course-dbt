{{
  config(
    materialized='table'
  )
}}

select 
    event_id,
    session_id,
    user_id,
    page_url,
    created_at,
    product_id
from {{ ref('stg_postgres__events') }} 
where event_type = 'page_view'

