with
    pedidos as (
        select
            id_pedido
            , id_funcionario
            , id_cliente
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
        from {{ ref('stg_ordens') }}
    )

    , pedido_itens  as (
        select
            id_pedido
            , id_produto
            , desconto_perc
            , preco_da_unidade
            , quantidade
        from {{ ref('stg_ordens_detalhes') }}
    )

    , join_pedidos_itens as (
        select
            pedidos.id_pedido
            , pedidos.id_funcionario
            , pedidos.id_cliente
            , pedidos.id_transportadora
            , pedido_itens.id_produto
            , pedido_itens.desconto_perc
            , pedido_itens.preco_da_unidade
            , pedido_itens.quantidade
            , pedidos.frete
            , pedidos.data_do_pedido
            , pedidos.data_do_envio
            , pedidos.data_requerida_entrega
            , pedidos.destinatario
            , pedidos.endereco_destinatario
            , pedidos.cep_destinatario
            , pedidos.cidade_destinatario
            , pedidos.regiao_destinatario
            , pedidos.pais_destinatario
        from pedido_itens
        left join pedidos on pedido_itens.id_pedido = pedidos.id_pedido
    )

    , chave_vendas as (
        select
            cast((id_pedido || '-' || id_produto) as string) as pk_vendas
            , join_pedidos_itens.id_pedido
            , join_pedidos_itens.id_funcionario
            , join_pedidos_itens.id_cliente
            , join_pedidos_itens.id_transportadora
            , join_pedidos_itens.id_produto
            , join_pedidos_itens.desconto_perc
            , join_pedidos_itens.preco_da_unidade
            , join_pedidos_itens.quantidade
            , join_pedidos_itens.frete
            , join_pedidos_itens.data_do_pedido
            , join_pedidos_itens.data_do_envio
            , join_pedidos_itens.data_requerida_entrega
            , join_pedidos_itens.destinatario
            , join_pedidos_itens.endereco_destinatario
            , join_pedidos_itens.cep_destinatario
            , join_pedidos_itens.cidade_destinatario
            , join_pedidos_itens.regiao_destinatario
            , join_pedidos_itens.pais_destinatario
        from join_pedidos_itens
    )

select *
from chave_vendas
