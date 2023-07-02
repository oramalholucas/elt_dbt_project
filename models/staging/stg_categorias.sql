with
    fonte_categories as (
        select
            CAST(category_id AS INT) as categoria_id
            , CAST(category_name AS STRING) as nome_categoria
            , CAST(description AS STRING) as descricao_categoria
        from {{ source('erp', 'categories') }}
    )

select *
from fonte_categories
