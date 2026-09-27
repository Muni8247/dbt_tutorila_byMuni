with source_data as (
    select
        *,
        row_number() over (
            partition by id 
            order by updated desc
        ) as row_num
    from
        {{ source('source', 'items') }}
)

select
    *
from
    source_data
where
    row_num = 1