create database Banking;
use banking;

desc accounts;
desc branch;
desc customers;
desc employees;
desc transactions;

select * from accounts;
select * from branch;
select * from customers;
select * from employees;
select * from transactions;

#Write a query to list all customers who haven't made any transactions in the last year. How can we make them active again? Provide appropriate region.
#SALMAN SHAIK
SELECT c.* FROM customers AS c
LEFT JOIN accounts AS a 
ON c.customer_id = a.customer_id
LEFT JOIN transactions AS t 
ON a.account_number = t.account_number 
WHERE t.transaction_date NOT BETWEEN 
DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR) 
AND CURRENT_DATE OR t.account_number IS NULL;

#Summarize the total transaction amount per account per month.
#SALMAN SHAIK
SELECT ACCOUNT_NUMBER,
MONTH(TRANSACTION_DATE) AS MONTH,
YEAR(TRANSACTION_DATE) AS YEAR,
SUM(AMOUNT) AS AMOUNT 
FROM TRANSACTIONS 
GROUP BY ACCOUNT_NUMBER,
MONTH(TRANSACTION_DATE),
YEAR(TRANSACTION_DATE)
ORDER BY MONTH(TRANSACTION_DATE),
YEAR(TRANSACTION_DATE);

#Rank branches based on the total amount of deposits made in the last quarter.
#SALMAN SHAIK
select dense_rank() OVER(ORDER BY SUM(T.AMOUNT) DESC) AS RANKING,
B.Branch_name,sum(t.amount) as Total_Amount from transactions as t 
join accounts as a 
on t.account_number=a.account_number
join branch as b 
on a.branch_id=b.branch_id 
where t.transaction_type="Deposit" 
and t.transaction_date<(NOW()-INTERVAL 1 QUARTER)
group by b.branch_name;

#Find the name of the customer who has deposited the highest amount.
#SALMAN SHAIK
SELECT A.ACCOUNT_NUMBER,
CONCAT(C.FIRST_NAME," ",C.LAST_NAME) AS CUSTOMER_NAME, 
SUM(t.amount) AS Total_Deposit
FROM transactions AS t
JOIN accounts AS a 
ON t.account_number = a.account_number
JOIN customers AS c 
ON a.customer_id = c.customer_id
WHERE t.transaction_type = "Deposit"
GROUP BY A.ACCOUNT_NUMBER,CUSTOMER_NAME
ORDER BY Total_Deposit DESC
LIMIT 1;

#Identify any accounts that have made more than two transactions in a single day, which could indicate fraudulent activity. How can you verify any fraudulent transaction?
#SALMAN SHAIK
SELECT ACCOUNT_NUMBER, 
DATE(TRANSACTION_DATE) as Date_of_Transaction, 
COUNT(*) as No_of_Transactions
FROM TRANSACTIONS 
GROUP BY ACCOUNT_NUMBER,
DATE(TRANSACTION_DATE) HAVING COUNT(*)>2;

# Calculate the average number of transactions per customer per account per month over the last year.
#SALMAN SHAIK
SELECT C.CUSTOMER_ID, A.ACCOUNT_NUMBER, 
MONTH(T.TRANSACTION_DATE) AS MONTH,
COUNT(*) AS TOTAL_TRANSACTIONS,
(COUNT(*)/COUNT(DISTINCT MONTH(T.TRANSACTION_DATE))) AS AVG_TRANSACTION_PER_MONTH 
FROM TRANSACTIONS AS T
JOIN ACCOUNTS AS A ON T.ACCOUNT_NUMBER=A.ACCOUNT_NUMBER
JOIN CUSTOMERS AS C ON C.CUSTOMER_ID=A.CUSTOMER_ID
WHERE YEAR(T.TRANSACTION_DATE)=YEAR(DATE_SUB(current_date(),INTERVAL 1 YEAR))
GROUP BY C.CUSTOMER_ID,A.ACCOUNT_NUMBER,MONTH(T.TRANSACTION_DATE)
ORDER BY CUSTOMER_ID,MONTH;

# Write a query to find the daily transaction volume (total amount of all transactions) for the past month.
#SALMAN SHAIK
SELECT 
DATE(TRANSACTION_DATE) AS TRANSACTION_DATE, 
SUM(AMOUNT) AS TOTAL_AMOUNT
FROM TRANSACTIONS
WHERE TRANSACTION_DATE >= DATE_SUB(CURDATE(), INTERVAL DAY(CURDATE()) DAY)
AND TRANSACTION_DATE < CURDATE() - INTERVAL DAY(CURDATE()) - 1 DAY
GROUP BY DATE(TRANSACTION_DATE);

# Calculate the total transaction amount performed by each age group in the past year. (Age groups: 0-17, 18-30, 31-60, 60+)
#SALMAN SHAIK
with ages as (
select customer_id,(year(NOW())-year(date_of_birth)) as customers_age from customers)

select case
when a.customers_age>=0 and a.customers_age<=17 then "0-17"
when a.customers_age>=18 and a.customers_age<=30 then "18-30"
when a.customers_age>=31 and a.customers_age<=60 then "31-60"
else "60+"
end as Customer_Age_Group ,sum(t.amount) as Total_Transaction_Amount from transactions as t
join accounts as acc on t.account_number=acc.account_number
join ages as a on a.customer_id=acc.customer_id
where year(t.transaction_date)=year(date_sub(current_date(),interval 1 year))
group by Customer_Age_Group  order by Customer_Age_Group ;

#Find the branch with the highest average account balance.
#SALMAN SHAIK
SELECT B.BRANCH_NAME as Branch_Name,
AVG(A.BALANCE) AS Highest_Average_Amount 
FROM BRANCH AS B
JOIN ACCOUNTS AS A ON B.BRANCH_ID=A.BRANCH_ID
GROUP BY B.BRANCH_NAME 
ORDER BY AVG(A.BALANCE) DESC LIMIT 1;

# Calculate the average balance per customer at the end of each month in the last year.
#SALMAN SHAIK
SELECT C.CUSTOMER_ID,
date_format(LAST_DAY(T.TRANSACTION_DATE),'%Y-%M') MONTH_YEAR,
AVG(A.BALANCE) AS AVERAGE_BALANCE FROM TRANSACTIONS AS T
JOIN ACCOUNTS AS A ON A.ACCOUNT_NUMBER=T.ACCOUNT_NUMBER
JOIN CUSTOMERS AS C ON C.CUSTOMER_ID=A.CUSTOMER_ID
WHERE T.TRANSACTION_DATE>=NOW()-INTERVAL 1 YEAR
GROUP BY C.CUSTOMER_ID,
YEAR(T.TRANSACTION_DATE),
date_format(LAST_DAY(T.TRANSACTION_DATE),'%Y-%M'),
MONTH(T.TRANSACTION_DATE)
ORDER BY CUSTOMER_ID,YEAR(T.TRANSACTION_DATE) DESC ,
MONTH(T.TRANSACTION_DATE);



