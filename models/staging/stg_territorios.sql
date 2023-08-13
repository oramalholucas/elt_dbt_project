with
    fonte_territorios as (
        select
            cast(territory_id as string) as territorio_id
            , cast(territory_description as string) as descricao_territorio
            , cast(region_id as string) as regiao_id
        from {{ source('erp', 'territories') }}
    )

select *
from fonte_territorios
