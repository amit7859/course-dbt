
{%- macro event_types(table_name, column_name) -%}


{%-
    set event_types = dbt_utils.get_column_values(
		table = ref(table_name)
		, column = column_name
    )
-%}


{%- for event_type in event_types %}
    ,sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as {{ event_type }}_count
{%- endfor %}

{%- endmacro %}

