{{
  config(
    materialized='table'
  )
}}



select 
    session_id, 
    user_id, 
    min(created_at) as session_start_at, 
    max(created_at) as session_end_at
    {{ event_types('stg_postgres__events', 'event_type') }} 
from {{ ref('stg_postgres__events') }} 
group by 1, 2

