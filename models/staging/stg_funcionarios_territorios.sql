with
    fonte_funcionarios_territorios as (
        select
            cast(employee_id as string) as funcionario_id
            , cast(territory_id as string) as territorio_id
        from {{ source('erp', 'employee_territories') }}
    )

select *
from fonte_funcionarios_territorios
