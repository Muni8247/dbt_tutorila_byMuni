with bronze_sales as
(
    select
        sales_id,
        product_sk,
        customer_sk, -- Fixed typo from 'custome_sk'
        {{ multiply('unit_price', 'quantity') }} as calulated_gross_amount,
        gross_amount,
        payment_method
    from
        {{ ref("bronze_factsales") }}
),
products as
(
    select
        product_sk,
        category
    from
        {{ ref("bronze_dimproduct") }}
),
customer as
(
    select
        customer_sk,
        gender
    from
        {{ ref("bronze_dimcustomer") }}
),
joined_query as(
select 
    sales.sales_id,
    sales.product_sk,
    sales.customer_sk, -- Fixed typo from 'custome_sk'
    sales.gross_amount,
    sales.payment_method,
    product.category,
    customer.gender
from
    bronze_sales as sales -- Added alias 'sales'
join
    products as product on sales.product_sk = product.product_sk -- Added alias 'product'
join
    customer on sales.customer_sk = customer.customer_sk
)

select 
    category,
    gender,
    sum(gross_amount) as total_gross_amount
from
    joined_query
group by
    category,
    gender
order by
    total_gross_amount desc