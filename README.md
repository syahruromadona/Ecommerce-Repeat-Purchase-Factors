## Executive summary

Repeat customers are the backbone of our business, yet they currently make up only a small portion of our customer base. What factors are most strongly associated with customer repeat purchases in an e-commerce marketplace? I use SQL to clean the data and Python to do analysis. I found that customer-level average item price shows the strongest association with repeat purchasing.

## Business Problem

In competitive e-commerce marketplaces, customer repeat purchasing is a key driver of long-term revenue and customer lifetime value. While firms routinely invest in faster delivery, pricing strategies, and post-purchase experience improvements, it is often unclear which of these factors are most strongly associated with customers returning to make additional purchases. Without clarity on the relative importance of delivery performance, pricing, and customer experience signals, businesses risk allocating resources toward initiatives with limited impact on retention. This analysis seeks to identify which observable customer-level factors are most strongly associated with repeat purchasing behavior, in order to inform prioritization of operational and commercial strategies.

## Methodology

1. SQL query that extracts, cleans, and transforms the data from the database.
2. A funnel analysis in Python to simulate changes and determine the best areas of opportunity.

Data was obtained via [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) which contains 100k orders from 2016 to 2018 made at multiple marketplaces in Brazil.

Operational Definition

- **Repeat customer**: customer with ≥2 distinct orders
- **Delivery speed (days)**: actual delivery date − purchase date
- **Delay**: actual delivery date > estimated delivery date
- **Review score**: mean score per customer
- **Price level**: average item price per order

## 4. Skills

SQL: CTEs, Joins, Case, aggregate functions

Python: Pandas, Matplotlib, Numpy, Writing functions, building a product funnel, statistics

## 5. Analysis Result

- Customer-level average item price shows the strongest association with repeat purchasing; higher-priced purchases are linked to lower repeat probability.
- Delivery reliability (percentage of delayed orders) is negatively associated with repeat behavior, though the effect is materially smaller than price.
- Average delivery speed shows little independent association with repeat purchasing after controlling for other factors.
- Review scores show a weak and counterintuitive association, likely influenced by timing and aggregation effects.

## 6. Limitation

- Observational data; causality cannot be inferred
- Customer-level aggregation may mask product-level dynamics
- Potential confounding from unobserved factors (e.g., customer location)

## 7. Next step

1. Validate price-related repeat behavior at the product level
2. Investigate delivery reliability drivers rather than delivery speed
3. Address timing and aggregation effects in review data
