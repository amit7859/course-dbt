{{
  config(
    materialized='table'
  )
}}

select distinct
    session_id,
    user_id,
    page_url,
    product_id
from {{ ref('stg_postgres__events') }} 
where event_type = 'page_view'
