with
    fonte_clientes as (
        select
            cast(customer_id as string) as cliente_id
            , cast(company_name as string) as nome_empresa
            , cast(contact_name as string) as nome_contato
            , cast(contact_title as string) as cargo_contato
            , cast(address as string) as endereco
            , cast(city as string) as cidade
            , cast(region as string) as regiao
            , cast(postal_code as string) as cep
            , cast(country as string) as pais
            , cast(phone as string) as telefone
            , cast(fax as string) as fax
        from {{ source('erp', 'customers') }}
    )

select *
from fonte_clientes
