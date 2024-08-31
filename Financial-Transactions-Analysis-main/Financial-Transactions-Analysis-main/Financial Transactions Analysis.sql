-- Retrieve all columns for transactions where the transaction amount is greater than 2000
SELECT * FROM fraud_dataset WHERE transaction_amount > 2000;

-- Calculate the average transaction amount for each merchant
SELECT merchant, AVG(transaction_amount) AS `Average Transaction Amount` 
FROM fraud_dataset 
GROUP BY merchant;

-- Count the number of transactions for each location
SELECT location, COUNT(*) AS `Transaction Count` 
FROM fraud_dataset
GROUP BY location;

-- Find the total transaction amount for each gender
SELECT gender, SUM(transaction_amount) AS `Total Transaction Amount` 
FROM fraud_dataset
GROUP BY gender;

-- Calculate the percentage of fraudulent transactions for each merchant
SELECT merchant, 
SUM(CASE WHEN fraud_label = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100 AS `Fraud Percentage`
FROM fraud_dataset
GROUP BY merchant;

-- Retrieve the transactions where the transaction amount is in the range of 1000 to 2000 (inclusive)
SELECT * FROM fraud_dataset WHERE transaction_amount BETWEEN 1000 AND 2000;

-- Find the average age of customers for each merchant in New York
SELECT merchant, AVG(age) AS `Average Age` 
FROM fraud_dataset
WHERE location = 'New York'
GROUP BY merchant;

-- Count the number of transactions for each age group
SELECT 
CASE 
    WHEN age BETWEEN 20 AND 30 THEN '20-30'
    WHEN age BETWEEN 31 AND 40 THEN '31-40'
    WHEN age BETWEEN 41 AND 50 THEN '41-50'
    ELSE '51+'
END AS `Age Group`,
COUNT(*) AS `Transaction Count`
FROM fraud_dataset
GROUP BY 
CASE 
    WHEN age BETWEEN 20 AND 30 THEN '20-30'
    WHEN age BETWEEN 31 AND 40 THEN '31-40'
    WHEN age BETWEEN 41 AND 50 THEN '41-50'
    ELSE '51+'
END;

-- Find the total transaction amount and the number of transactions for each location
SELECT location, SUM(transaction_amount) AS `Total Transaction Amount`, 
COUNT(*) AS transaction_count
FROM fraud_dataset 
GROUP BY location;

-- Calculate the average age of customers for each gender and location
SELECT gender, location, AVG(age) AS `Average Age`
FROM fraud_dataset
GROUP BY gender, location;

-- Determine the highest transaction amount for each merchant
SELECT merchant, MAX(transaction_amount) AS `Highest Transaction Amount`
FROM fraud_dataset
GROUP BY merchant;

-- Identify the location with the highest total transaction amount
SELECT location
FROM (SELECT location, SUM(transaction_amount) AS total_transaction_amount
      FROM fraud_dataset
      GROUP BY location) AS location_totals
ORDER BY total_transaction_amount DESC
LIMIT 1;

-- Calculate the total number of fraudulent transactions and the percentage of fraud for each location
SELECT location,
SUM(CASE WHEN fraud_label = 1 THEN 1 ELSE 0 END) AS `Total Fraudulent Transactions`,
(SUM(CASE WHEN fraud_label = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS `Fraud Percentage`
FROM fraud_dataset
GROUP BY location;

-- Retrieve the transactions with a transaction amount greater than the average transaction amount
SELECT * FROM fraud_dataset WHERE transaction_amount > (SELECT AVG(transaction_amount) FROM fraud_dataset);

-- Calculate the average age of customers for transactions with fraud (fraud_label = 1) and without fraud (fraud_label = 0)
SELECT CASE WHEN fraud_label = 1 THEN 'Fraudulent' ELSE 'Non-Fraudulent' END AS transaction_type,
AVG(age) AS average_age
FROM fraud_dataset
GROUP BY 
CASE WHEN fraud_label = 1 THEN 'Fraudulent' ELSE 'Non-Fraudulent' END;
