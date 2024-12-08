# Banking Data Analysis Using SQL

This project leverages **SQL** to analyze banking data, providing insights into customer behavior, transaction trends, branch performance, and fraud detection. The analysis aims to enhance operational efficiency, customer engagement, and risk management.

## Features

1. **Customer Engagement:**
   - Identify customers who haven't made transactions in the last year.
   - Suggest strategies to make them active again based on regional data.

2. **Transaction Analysis:**
   - Summarize total transaction amounts per account per month.
   - Calculate daily transaction volumes for the past month.

3. **Branch Performance:**
   - Rank branches by total deposits made in the last quarter.
   - Identify the branch with the highest average account balance.

4. **Fraud Detection:**
   - Detect accounts with more than two transactions in a single day.
   - Propose methods to verify potential fraudulent activity.

5. **Demographic Insights:**
   - Analyze total transaction amounts across age groups (0-17, 18-30, 31-60, 60+).

6. **Activity and Balance Trends:**
   - Calculate the average number of transactions per customer per account per month over the last year.
   - Compute average balances per customer at the end of each month in the last year.

## SQL Queries Included

1. **Inactive Customers:** Query to list customers who haven't made transactions in the last year.
2. **Monthly Transactions:** Summarize total transaction amounts per account per month.
3. **Branch Ranking:** Rank branches based on deposits in the last quarter.
4. **Top Depositor:** Identify the customer with the highest deposit amount.
5. **Fraud Detection:** Detect accounts with more than two transactions in a single day.
6. **Daily Volume:** Calculate daily transaction volumes for the past month.
7. **Age Group Analysis:** Total transaction amounts performed by each age group.
8. **Top Branch:** Find the branch with the highest average account balance.
9. **Monthly Averages:** Calculate average balances per customer at month-end over the last year.

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/Salman-Shaik28/banking-data-analysis.git
   ```

2. Import your database structure and data into a MySQL environment.

3. Run the provided SQL queries to perform the analyses.

4. Review the results and insights generated from the queries.

## Tools Used

- **Database:** MySQL
- **SQL Techniques:** Joins, Group By, Aggregations, Ranking, and Conditional Filtering

## Outcomes

- Enhanced understanding of customer behavior and branch performance.
- Detection and mitigation of potential fraudulent activities.
- Data-driven insights for improved banking operations and decision-making.
