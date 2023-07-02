with
    source_employees as (
        select
            CAST(employee_id AS INT) as funcionario_id
            , CAST(last_name AS STRING) as sobrenome
            , CAST(first_name AS STRING) as nome
            , CAST(first_name || ' ' || last_name AS STRING) as nome_completo
            , CAST(birth_date AS DATE) as data_nascimento
            , CAST(hire_date AS DATE) as data_contratacao
            , CAST(address AS STRING) as endereco
            , CAST(city AS STRING) as cidade
            , CAST(region AS STRING) as regiao
            , CAST(postal_code AS STRING) as cep
            , CAST(country AS STRING) as pais
            , CAST(notes AS STRING) as notas
            , CAST(reports_to AS INT) as gerente_id
        from {{ source('erp', 'employees') }}
    )

select *
from source_employees