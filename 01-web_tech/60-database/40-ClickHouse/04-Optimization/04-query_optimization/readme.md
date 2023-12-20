# Query Optimization


### Limit By

```
SELECT
    rebate_price,
    count(rebate_price)
FROM
(
    SELECT rebate_price
    FROM
    (
        SELECT
            discount_id,
            item_id,
            discount_type_id,
            model_id,
            rebate_price
        FROM promotion_discountitemsearch_co_all
        WHERE (shop_id = 7758521) AND (identifier < 200000000)
        ORDER BY
            discount_id ASC,
            item_id ASC,
            discount_type_id ASC,
            model_id ASC,
            cqs_version DESC
        LIMIT 1 BY (discount_id, item_id, discount_type_id, model_id)
    )
)
GROUP BY rebate_price;
```
```
SELECT 
  rebate_price,
  count(rebate_price)
FROM
(
        SELECT
            discount_id,
            item_id,
            discount_type_id,
            model_id,
            rebate_price
        FROM promotion_discountitemsearch_co_all
        WHERE (shop_id = 7758521) AND (identifier < 200000000)
        ORDER BY
            discount_id ASC,
            item_id ASC,
            discount_type_id ASC,
            model_id ASC,
            cqs_version DESC
        LIMIT 1 BY (discount_id, item_id, discount_type_id, model_id)
)
GROUP BY rebate_price;
```

