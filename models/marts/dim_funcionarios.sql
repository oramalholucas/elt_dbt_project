with
    erp_employees as (
        select
            funcionario_id
            , sobrenome
            , nome
            , nome_completo
            , data_nascimento
            , data_contratacao
            , endereco
            , cidade
            , regiao
            , cep
            , pais
            , notas
            , gerente_id
        from {{ ref('stg_funcionarios') }}
    )

    , erp_managers as (
        select *
        from {{ ref('stg_funcionarios') }}
    )

    , join_employee_to_managers as (
        select
            erp_employees.funcionario_id
            , erp_employees.sobrenome
            , erp_employees.nome
            , erp_employees.nome_completo
            , erp_employees.data_nascimento
            , erp_employees.data_contratacao
            , erp_employees.endereco
            , erp_employees.cidade
            , erp_employees.regiao
            , erp_employees.cep
            , erp_employees.pais
            , erp_employees.notas
            , erp_employees.gerente_id
            , erp_managers.nome_completo as gerente_nome_completo
        from erp_employees
        left join erp_managers on erp_employees.gerente_id = erp_managers.funcionario_id
    )

select *
from join_employee_to_managers