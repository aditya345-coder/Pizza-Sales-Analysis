# Pizza Place Sales Analysis  

This project involves analyzing sales data from a fictitious pizza place over a year. The analysis explores key sales metrics, trends, and insights to inform decision-making. The dataset includes details on order dates, pizza types, sizes, quantities, prices, and ingredients.

---

## Table of Contents
1. [Dataset Overview](#dataset-overview)  
2. [Project Structure](#project-structure)  
3. [Key Questions Explored](#key-questions-explored)  
4. [Summary of Findings](#summary-of-findings)  
5. [Preview of Analysis](#preview-of-analysis)  
6. [Usage Instructions](#usage-instructions)  

---

## Dataset Overview  

The dataset, downloaded from [Maven Analytics](https://mavenanalytics.io/challenges/maven-pizza-challenge/be511a47-85fd-4931-8293-c3bffb577199), consists of four CSV files:  
- **Orders:** Contains the date and time of orders.  
- **Order Details:** Details of each order, including quantity.  
- **Pizzas:** Information on sizes and price.  
- **Pizza Types:** Ingredients for each type of pizza.  

---

## Project Structure  

```
├── reports                          <- Final reports/results of this project.
│   └── PizzaSales.pdf         <- PDF report with final analysis.
│   └── PizzaSales.pbix              <- Power BI report file.
│   └── Pizza Sales SQL Queries.pdf  <- Query report for verification.
│
├── SQL queries                      <- Code for database creation and queries.
│   └── pizza_place_sales_schema.sql <- SQL schema for database creation.
│   └── pizza_place_sales_analysis.sql <- SQL queries for analysis.
│
├── src                              <- Project source files.
    ├── data                         <- Datasets used in this project.
    ├── images                       <- Images for dashboards.
    ├── data_dictionary.csv          <- Data dictionary for the dataset.
│
├── LICENSE                          <- Project license information.
├── README.md                        <- Project README (this file).
```

---

## Key Questions Explored  

The analysis focuses on the following questions:  
1. **Total Revenue:** Total revenue generated over the year.  
2. **Average Order Value:** Average value of each order.  
3. **Total Pizza Sold:** Total number of pizzas sold.  
4. **Total Orders:** Total orders placed over the year.  
5. **Average Pizzas Per Order:** Average number of pizzas ordered per order.  
6. **Daily Trend for Total Orders:** Sales trends by day of the week.  
7. **Monthly Trend for Total Orders:** Seasonal trends in orders.  
8. **% of Sales by Pizza Category:** Contribution of each pizza category to total sales.  
9. **% of Sales by Pizza Size:** Contribution of each pizza size to total sales.  
10. **Top 5 Best Sellers:** Best-selling pizzas by revenue, quantity, and orders.  
11. **5 Lowest Sellers:** Least-selling pizzas by revenue, quantity, and orders.  
12. **Customer Trends:** Number of customers per day and busiest hours.  
13. **Average Daily Orders & Pizzas Sold:** Average orders and pizzas sold daily.  

---

## Summary of Findings  

### Most Occupied Days and Months  
- **Days:** Orders peak on Fridays, Saturdays and Thrusday especially in the evening.  
- **Months:** January and July see the highest number of orders.  

### Sales Performance  
- **Category:** Classical pizzas dominate total orders.
- **Size:** Large pizzas contribute the most to revenue.

### Best Sellers  
- **Revenue:** Thai Chicken Pizza leads in revenue.  
- **Quantity:** Classical Deluxe Pizza tops in total quantities sold.  
- **Total Orders:** Classical Deluxe Pizza is ordered the most.  

### Lowest Sellers  
- **Revenue:** Brie Carre Pizza generates the least revenue.  
- **Quantity:** Brie Carre Pizza is the least sold in quantity.  
- **Total Orders:** Brie Carre Pizza has the fewest orders.  

### Most Occupied Times  
- **Lunch:** 12 PM to 1:30 PM.  
- **Dinner:** 6 PM to 8 PM.  

---

## Preview of Analysis  

---

## Usage Instructions  

1. **Set Up Database**:  
   Use `pizza_place_sales_schema.sql` to create the database and populate it with data from the CSV files.  

2. **Run SQL Queries**:  
   Execute `pizza_place_sales_analysis.sql` to extract insights.  

3. **Power BI Report**:  
   Open `PizzaSales.pbix` in Power BI to explore the dashboards and visualizations.  

4. **Final Reports**:  
   Review findings in `PizzaSales.pdf` for a summarized analysis.  

---

Feel free to explore and modify the analysis to suit your needs!  
