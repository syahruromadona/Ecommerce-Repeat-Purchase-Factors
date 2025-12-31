-- Step 1: Customer order aggregation
SELECT
    C.customer_unique_id,
    COUNT(DISTINCT O.order_id) AS total_orders,
    CASE WHEN COUNT(DISTINCT O.order_id) >= 2 THEN 'YES' ELSE 'NO' END AS is_repeat_customer,
    MIN(O.order_purchase_timestamp) AS first_purchase_date,
    MAX(O.order_purchase_timestamp) AS last_purchase_date
FROM olist_customers_dataset C
JOIN olist_orders_dataset O ON C.customer_id = O.customer_id
GROUP BY C.customer_unique_id;


-- Step 2: Delivery performance per customer
WITH temp_list AS (
    SELECT
        customer_unique_id,
        order_id,
        order_delivered_customer_date,
        order_estimated_delivery_date,
        CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END AS is_delayed,
        (JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_purchase_timestamp)) * 24 AS delivery_time_hours
    FROM avg_delivery
    WHERE order_delivered_carrier_date IS NOT NULL
      AND order_delivered_customer_date IS NOT NULL
)
SELECT
    customer_unique_id,
    AVG(delivery_time_hours) AS avg_delivery_time_hour,
    ROUND((SUM(is_delayed) * 1.0 / COUNT(order_id)) * 100, 2) AS pct_delay
FROM temp_list
GROUP BY customer_unique_id;


-- Step 3: Review experience per customer
WITH temp_list AS (
    SELECT
        C.customer_unique_id,
        O.order_id,
        R.review_score,
        CASE WHEN R.review_score <= 2 THEN 1 ELSE 0 END AS is_low_review
    FROM olist_customers_dataset C
    JOIN olist_orders_dataset O ON C.customer_id = O.customer_id
    JOIN olist_order_reviews_dataset R ON O.order_id = R.order_id
)
SELECT
    customer_unique_id,
    ROUND(AVG(review_score), 2) AS avg_review,
    ROUND(SUM(is_low_review) * 100.0 / COUNT(DISTINCT order_id), 2) AS low_review_pct
FROM temp_list
GROUP BY customer_unique_id;


-- Step 4: Price exposure per customer
WITH price_calc AS (
    SELECT
        order_id,
        AVG(price) AS avg_item_price,
        SUM(price + freight_value) AS total_order_value
    FROM olist_order_items_dataset
    GROUP BY order_id
)
SELECT
    C.customer_unique_id,
    ROUND(AVG(P.avg_item_price), 2) AS avg_item_price_customer,
    ROUND(AVG(P.total_order_value), 2) AS avg_order_value_customer
FROM price_calc P
JOIN olist_orders_dataset O ON P.order_id = O.order_id
JOIN olist_customers_dataset C ON O.customer_id = C.customer_id
GROUP BY C.customer_unique_id;


-- Step 5: Final analysis table
SELECT
    C.customer_unique_id,
    C.is_repeat_customer,
    ROUND((D.avg_delivery_time_hour / 24), 2) AS avg_delivery_day,
    D.pct_delay,
    R.avg_review,
    P.avg_item_price_customer,
    C.total_orders
FROM customer_aggregation AS C
LEFT JOIN delivery_perfomance_table AS D ON C.customer_unique_id = D.customer_unique_id
LEFT JOIN review_experience_table AS R ON C.customer_unique_id = R.customer_unique_id
LEFT JOIN price_exposure_table AS P ON C.customer_unique_id = P.customer_unique_id;


-- Sanity check
SELECT
    COUNT(*) AS customers,
    SUM(is_repeat_customer = 'YES') AS repeat_customers,
    SUM(avg_review IS NULL) AS no_reviews,
    SUM(avg_delivery_time_hour IS NULL) AS no_delivery
FROM final_table;

-- Total customers: 96096
-- Repeat customers: 2997
-- No review: 716
-- No delivery: 2741
