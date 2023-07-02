with
    employees as (
        select *
        from {{ ref('dim_funcionarios') }}
    )
    , produtos as (
        select *
        from {{ ref('dim_produtos') }}
    )
    , pedidos_itens as (
        select *
        from {{ ref('int_vendas_pedidos_itens') }}
    )
    , joined_tabelas as (
        select
            pedidos_itens.pk_vendas
            , pedidos_itens.id_pedido
            , produtos.id_produto
            , employees.funcionario_id
            , pedidos_itens.id_transportadora
            , pedidos_itens.desconto_perc
            , pedidos_itens.preco_da_unidade
            , pedidos_itens.quantidade
            , pedidos_itens.frete
            , pedidos_itens.data_do_pedido
            , pedidos_itens.data_do_envio
            , pedidos_itens.data_requerida_entrega
            , pedidos_itens.destinatario
            , pedidos_itens.endereco_destinatario
            , pedidos_itens.cep_destinatario
            , pedidos_itens.cidade_destinatario
            , pedidos_itens.regiao_destinatario
            , pedidos_itens.pais_destinatario
            , employees.nome_completo as funcionario_nome_completo
            , employees.gerente_nome_completo
            , produtos.nome_produto
            , produtos.nome_categoria
            , produtos.nome_fornecedor
            , produtos.is_discontinuado
        from pedidos_itens
        left join produtos on pedidos_itens.id_produto = produtos.id_produto
        left join employees on pedidos_itens.id_funcionario = employees.funcionario_id
    )
    , transformacoes as (
        select
            *
            , (preco_da_unidade * quantidade) as total_bruto
            , (preco_da_unidade * quantidade) * (1 - desconto_perc) as total_liquido
            , frete / (count(*) over (partition by id_pedido)) as frete_divido_pelos_itens
        from joined_tabelas
    )
select *
from transformacoes
