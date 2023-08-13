with
    produtos as (
        select
            id_produto
            , id_fornecedor
            , id_categoria
            , nome_produto
            , quantidade_por_unidade
            , preco_por_unidade
            , unidades_em_estoque
            , unidades_por_ordem
            , nivel_reabastecimento
            , is_discontinuado
        from {{ ref('stg_produtos') }}
    )

    , categorias as (
        select
            categoria_id
            , nome_categoria
            , descricao_categoria
        from {{ ref('stg_categorias') }}
    )

    , fornecedores as (
        select
            id_fornecedor
            , nome_fornecedor
            , contato_fornecedor
            , endereco_fornecedor
            , cep_fornecedor
            , cidade_fornecedor
            , regiao_fornecedor
            , pais_fornecedor
        from {{ ref('stg_fornecedores') }}
    )

    , join_tabelas as (
        select
            produtos.id_produto
            , produtos.id_fornecedor
            , produtos.id_categoria
            , produtos.nome_produto
            , produtos.quantidade_por_unidade
            , produtos.preco_por_unidade
            , produtos.unidades_em_estoque
            , produtos.unidades_por_ordem
            , produtos.nivel_reabastecimento
            , produtos.is_discontinuado
            , categorias.nome_categoria
            , categorias.descricao_categoria
            , fornecedores.nome_fornecedor
            , fornecedores.contato_fornecedor
            , fornecedores.endereco_fornecedor
            , fornecedores.cep_fornecedor
            , fornecedores.cidade_fornecedor
            , fornecedores.regiao_fornecedor
            , fornecedores.pais_fornecedor
        from produtos
        left join categorias on produtos.id_categoria = categorias.categoria_id
        left join fornecedores on produtos.id_fornecedor = fornecedores.id_fornecedor
    )

select *
from join_tabelas
