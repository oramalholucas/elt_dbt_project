with
    employees as (
        select
            funcionario_id
            , nome_completo
            , gerente_nome_completo
        from {{ ref('dim_funcionarios') }}
    )

    , produtos as (
        select
            id_produto
            , nome_produto
            , nome_categoria
            , nome_fornecedor
            , is_discontinuado
        from {{ ref('dim_produtos') }}
    )

    , pedidos_itens as (
        select
            pk_vendas
            , id_pedido
            , id_funcionario
            , id_produto
            , quantidade
            , preco_da_unidade
            , desconto_perc
            , id_transportadora
            , frete
            , data_do_pedido
            , data_do_envio
            , data_requerida_entrega
            , destinatario
            , endereco_destinatario
            , cep_destinatario
            , cidade_destinatario
            , regiao_destinatario
            , pais_destinatario
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
            joined_tabelas.pk_vendas
            , joined_tabelas.id_pedido
            , joined_tabelas.id_produto
            , joined_tabelas.funcionario_id
            , joined_tabelas.id_transportadora
            , joined_tabelas.desconto_perc
            , joined_tabelas.preco_da_unidade
            , joined_tabelas.quantidade
            , joined_tabelas.frete
            , joined_tabelas.data_do_pedido
            , joined_tabelas.data_do_envio
            , joined_tabelas.data_requerida_entrega
            , joined_tabelas.destinatario
            , joined_tabelas.endereco_destinatario
            , joined_tabelas.cep_destinatario
            , joined_tabelas.cidade_destinatario
            , joined_tabelas.regiao_destinatario
            , joined_tabelas.pais_destinatario
            , joined_tabelas.funcionario_nome_completo
            , joined_tabelas.gerente_nome_completo
            , joined_tabelas.nome_produto
            , joined_tabelas.nome_categoria
            , joined_tabelas.nome_fornecedor
            , joined_tabelas.is_discontinuado
            , (joined_tabelas.preco_da_unidade * joined_tabelas.quantidade) as total_bruto
            , (joined_tabelas.preco_da_unidade * joined_tabelas.quantidade) * (1 - desconto_perc) as total_liquido
            , joined_tabelas.frete / (count(*) over (partition by joined_tabelas.id_pedido)) as frete_divido_pelos_itens
        from joined_tabelas
    )

select *
from transformacoes
