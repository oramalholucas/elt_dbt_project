with
    fonte_fornecedores as (
        select
            cast(supplier_id as string) id_fornecedor
            , cast(company_name as string) as nome_fornecedor
            , cast(contact_name as string) as contato_fornecedor
            , cast(contact_title as string) as cargo_contato_fornecedor
            , cast(phone as string) as telefone
            , cast(fax as string) as fax
            , cast(homepage as string) as site
            , cast(address as string) as endereco_fornecedor
            , cast(postal_code as string) as cep_fornecedor
            , cast(city as string) as cidade_fornecedor
            , cast(region as string) as regiao_fornecedor
            , cast(country as string) as pais_fornecedor
        from {{ source('erp', 'suppliers') }}
    )
select *
from fonte_fornecedores
