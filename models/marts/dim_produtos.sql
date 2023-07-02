with
    produtos as (
        select *
        from {{ ref('stg_produtos') }}
    )
    , categorias as (
        select *
        from {{ ref('stg_categorias') }}
    )
    , fornecedores as (
        select *
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
