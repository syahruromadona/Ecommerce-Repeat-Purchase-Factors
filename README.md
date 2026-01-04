## Executive summary

Repeat customers are the backbone of our business, yet they currently make up only a small portion of our customer base. What factors are most strongly associated with customer repeat purchases in an e-commerce marketplace? I use SQL to clean the data and Python to do the analysis. I found that customer-level average item price shows the relative strength of association with repeat purchasing relative to delivery and review-related factors.

## Business Problem

In competitive e-commerce marketplaces, customer repeat purchasing is a key driver of long-term revenue and customer lifetime value. It is often unclear which of these factors are most strongly associated with customers returning to make additional purchases. Without clarity on the relative importance of delivery performance, pricing, and customer experience signals, businesses risk focusing on the wrong metric. This is a diagnostic analysis for focusing on factors that correlate with repeat purchases and not causal drivers.

## Methodology

1. **SQL -** Queries that extracts, cleans, and transforms the data from the database.
2. **Python -** Pandas, Matplotlib, Numpy, Writing functions

Data was obtained via [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) which contains 100k orders from 2016 to 2018 made at multiple marketplaces in Brazil.

Operational Definition

- **Repeat customer**: customer with ≥2 distinct orders
- **Delivery speed (days)**: actual delivery date − purchase date
- **Delay**: actual delivery date > estimated delivery date
- **Review score**: mean score per customer
- **Price level**: average item price per order

## 4. Skills

SQL: CTEs, Joins, Case, aggregate functions
Python: Pandas, Matplotlib, Numpy, Writing functions, statistics

## 5. Analysis Result

Key Findings (Coefficients indicate effect on repeat probability):
| Factor                         | Effect Direction | Magnitude (standardized) |
| ------------------------------ | ---------------- | ------------------------ |
| Avg. Item Price (per customer) | Negative         | -0.12                    |
| % of Delayed Orders            | Negative         | -0.05                    |
| Avg. Delivery Time (days)      | Negligible       | -0.003                   |
| Avg. Review Score              | Weak Positive    | -0.04 (counterintuitive) |


- Customer-level average item price shows the strongest association with repeat purchasing. The effect size is modest and the ‘strongest’ is used in relative sense among other variables rather than absolute predictor.
- Delivery reliability (percentage of delayed orders) is negatively associated with repeat behavior, though the effect is materially smaller than price.
- Average delivery speed shows little independent association with repeat purchasing after controlling for other factors.
- Review scores show a weak and counterintuitive association, likely influenced by timing and aggregation effects.

## 6. Limitation

- This is observational data, results are intended to guide hypothesis formation rather than direct decision-making.
- Customer-level aggregation may mask product-level dynamics
- Potential confounding from unobserved factors (e.g., customer location)

## 7. Next step

1. Validate price-related repeat behavior at the product level
2. Investigate delivery reliability drivers rather than delivery speed
3. Address timing and aggregation effects in review data
