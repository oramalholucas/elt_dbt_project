with
    fonte_estados as (
        select
            cast(state_id as string) as estado_id
            , cast(state_name as string) as nome_estado
            , cast(state_abbr as string) as nome_estado_abreviado
            , cast(state_region as string) as estado_regiao
        from {{ source('erp', 'us_states') }}
    )

select *
from fonte_estados
