with
    fonte_regiao as (
        select
            cast(region_id as string) as id_regiao
            , cast(region_description as string) as descricao_regiao
        from {{ source('erp', 'region') }}
    )

select *
from fonte_regiao
