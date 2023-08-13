with
    fonte_transportadores as (
        select
            cast(shipper_id as string) as transportador_id
            , cast(company_name as string) as nome_empresa
            , cast(phone as string) as telefone
        from {{ source('erp', 'shippers') }}
    )

select *
from fonte_transportadores
