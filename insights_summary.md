# 📈 Inventory Retail SQL Analysis — Insights Summary

This document highlights the **key business insights** discovered using advanced SQL queries on the retail dataset. These findings can help in data-driven decision-making across sales, inventory, pricing, customer segmentation, and store management.

---

## 🔹 Sales & Demand Insights

- **Total Revenue Generated:**  
  The total units sold and the overall revenue give a comprehensive view of business performance. Total_Quantity = 24,87,289 and Total_Revenue = 13,02,10,063.72 this reflects a strong market presence, from overall product sales across all stores.

  ## 📅 Monthly Revenue for 2024

  | Month   | Revenue          |
  |---------|------------------|
  | Jan     | 10,949,416.27    |
  | Feb     | 10,920,529.92    |
  | Mar     | 11,583,597.19    |
  | Apr     | 10,338,186.67    |
  | May     | 11,148,962.52    |
  | Jun     | 10,999,304.95    |
  | Jul     | 10,838,674.50    |
  | Aug     | 11,093,220.60    |
  | Sep     | 10,306,668.36    |
  | Oct     | 11,097,973.53    |
  | Nov     | 10,379,008.78    |
  | Dec     | 10,554,520.43    |

- **Seasonality Effects Identified:**  
  Demand shows variation across 3 distinct seasonality factors such as Holiday, Weekday & Festival.

- **Top 10 Revenue-Generating Products:**  
  Best-performing products were identified by total revenue, enabling focus on high-demand items for restocking or marketing.
  
  ### 👕 Top 10 Revenue-Generating Products – Apparel Category (by Subcategory)
  | Product ID | Category | Subcategory       | Total Revenue (₹) |
  |------------|----------|-------------------|--------------------|
  | 1717       | Apparel  | Children's Wear   | 108,525.48         |
  | 1589       | Apparel  | Men's Wear        | 80,719.82          |
  | 1539       | Apparel  | Accessories       | 79,436.37          |
  | 1225       | Apparel  | Children's Wear   | 79,167.74          |
  | 1321       | Apparel  | Women's Wear      | 78,470.23          |
  | 2013       | Apparel  | Women's Wear      | 78,439.68          |
  | 2011       | Apparel  | Men's Wear        | 76,772.61          |
  | 1785       | Apparel  | Men's Wear        | 76,628.71          |
  | 1413       | Apparel  | Women's Wear      | 75,882.33          |
  | 1865       | Apparel  | Children's Wear   | 73,945.13          |
  
- **Monthly Sales Trend Analysis:**  
  Revenue trends indicate seasonal spikes and sales cycles, helping plan inventory and promotions.

---

## 🔹 Product & Pricing Analysis

- **Minimum & Maximum Prices:**  
  Product pricing varies significantly, with prices ranging from lowest 5.02 to highest 99.99.

- **Pricing vs Competitors:**  
  Certain products are priced lower than competitors while still maintaining positive customer ratings — a competitive advantage.

- **Top Return Rate Products:**  
  The top 5 products with the highest return rates highlight potential quality or satisfaction issues.
  
  ### 🏆 Top 5 Products with Highest Return Rates
  | Product ID | Subcategory             | Return Rate (%) |
  |------------|--------------------------|-----------------|
  | 8405       | Cycling                  | 20.00           |
  | 7383       | Furniture (Chairs)       | 20.00           |
  | 1593       | Children's Wear          | 19.99           |
  | 1770       | Women's Wear             | 19.99           |
  | 3013       | Ebooks & Digital Media   | 19.99           |


- **Discount vs Return Rate Insight:**  
  A profitability metric was created to analyze whether discounts offered are offset by product return rates.

---

## 🔹 Inventory & Risk Insights

- **Stock-Risk Products:**  
  Products where total demand exceeded reorder thresholds were identified — crucial for avoiding stockouts.

- **High-Demand But Low-Stock Products:**  
  A subset of products has below-threshold stock but above-average demand, indicating urgency for restocking.

- **Warehouse Utilization:**  
  Some stores show over 90% warehouse usage, suggesting a need for space optimization or better logistics planning.

- **Fastest Fulfillment Stores:**  
  Top 5 stores with the lowest order fulfillment times were identified for benchmarking logistics efficiency.
  
  ### 🚚 Store Locations with Lowest Order Fulfillment Times
  | Store Location | Fastest Fulfillment Time (Days) |
  |----------------|-------------------------------|
  | Assam          | 1                             |
  | Delhi          | 1                             |
  | Gujarat        | 1                             |
  | Haryana        | 1                             |
  | Karnataka      | 1                             |

---

## 🔹 Customer & Segment Behavior

- **Revenue by Customer Segments:**  
  Certain segments - Budget, Premium & Regular contribute disproportionately to revenue.

- **Seasonal Preferences by Segment:**  
  Customer behavior varies across different seasonal patterns, which can be targeted in marketing.

---

## 🔹 Manager & Store Performance

- **Top-Performing Locations & Managers:**  
  The highest revenue-generating store and its manager were identified for reward or case study analysis.
  The store managed by Anjali Singh at Delhi generated the highest revenue, indicating strong leadership or a favorable market.

  ### 🚚 Store-wise Revenue Performance with Manager Details
  | Store Location   | Manage rName     | Total Revenue     |
  |------------------|------------------|------------------:|
  | Delhi            | Anjali Singh     | 13,559,279.23     |
  | Maharashtra      | Priya Sharma     | 13,555,646.87     |
  | Telangana        | Ramesh Reddy     | 12,897,589.79     |
  | Haryana          | Karan Kumar      | 12,580,397.76     |
  | Gujarat          | Meera Patel      | 12,338,028.83     |
  | West Bengal      | Sourav Banerjee  | 8,875,271.80      |
  | Assam            | Bikash Dutta     | 8,514,855.94      |
  | Karnataka        | Lakshmi Gowda    | 8,134,472.23      |
  | Tamil Nadu       | Deepa Srinivasan | 8,100,578.38      |
  | Madhya Pradesh   | Vivek Mishra     | 8,086,566.26      |
  | Punjab           | Jaspreet Singh   | 7,951,214.14      |
  | Uttar Pradesh    | Amit Yadav       | 7,887,716.27      |
  | Rajasthan        | Divya Rathore    | 7,728,446.22      |

---

## ✅ Summary

This analysis provides actionable intelligence across the retail pipeline — from identifying sales drivers and optimizing pricing, to mitigating inventory risks and maximizing warehouse efficiency.

> Use this summary in executive reporting, stakeholder presentations, or as a case study for SQL portfolio projects.
