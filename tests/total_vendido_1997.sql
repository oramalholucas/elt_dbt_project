{{
    config(
        severity = 'error'
    )
}}
with
    vendas_em_1997 as (
        select sum(total_bruto) as total_vendido
        from {{ ref('fct_vendas') }}
        where data_do_pedido between '1997-01-01' and '1997-12-31'
    )
select total_vendido
from vendas_em_1997
where total_vendido not between 658388.00 and 658389.00
