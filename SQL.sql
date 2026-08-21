CREATE DATABASE customer_churn;
USE customer_churn;
SELECT DATABASE();
CREATE TABLE customer_churn_data (
    customerID VARCHAR(20),
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(25),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(25),
    OnlineBackup VARCHAR(25),
    DeviceProtection VARCHAR(25),
    TechSupport VARCHAR(25),
    StreamingTV VARCHAR(25),
    StreamingMovies VARCHAR(25),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(30),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges DECIMAL(10,2),
    Churn VARCHAR(5),
    tenureGroup VARCHAR(20)
);
SHOW TABLES;
SELECT * 
FROM cleaned_customer_churn
LIMIT 10;
SELECT COUNT(*) AS total_records
FROM cleaned_customer_churn;
DESCRIBE cleaned_customer_churn;
SELECT COUNT(*) AS total_customers
FROM cleaned_customer_churn;
SELECT 
    Churn,
    COUNT(*) AS customer_count
FROM cleaned_customer_churn
GROUP BY Churn;
SELECT 
    Churn,
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM cleaned_customer_churn),
        2
    ) AS percentage
FROM cleaned_customer_churn
GROUP BY Churn;
SELECT 
    gender,
    Churn,
    COUNT(*) AS customer_count
FROM cleaned_customer_churn
GROUP BY gender, Churn
ORDER BY gender, Churn;
SELECT 
    gender,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_customer_churn
GROUP BY gender;
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_customer_churn
GROUP BY Contract
ORDER BY churn_rate DESC;
SELECT 
    tenureGroup,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_customer_churn
GROUP BY tenureGroup
ORDER BY churn_rate DESC;
SELECT 
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_customer_churn
GROUP BY InternetService
ORDER BY churn_rate DESC;
SELECT 
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_customer_churn
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;
SELECT 
    Churn,
    COUNT(*) AS customers,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM cleaned_customer_churn
GROUP BY Churn;
SELECT 
    Churn,
    COUNT(*) AS customers,
    ROUND(AVG(tenure), 2) AS avg_tenure
FROM cleaned_customer_churn
GROUP BY Churn;
SELECT 
    TechSupport,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_customer_churn
GROUP BY TechSupport
ORDER BY churn_rate DESC;
SELECT
    CASE
        WHEN MonthlyCharges < 30 THEN 'Low'
        WHEN MonthlyCharges < 70 THEN 'Medium'
        ELSE 'High'
    END AS charge_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_customer_churn
GROUP BY charge_group
ORDER BY churn_rate DESC;
SELECT
    customerID,
    gender,
    tenure,
    tenureGroup,
    Contract,
    InternetService,
    MonthlyCharges,
    PaymentMethod,
    Churn
FROM cleaned_customer_churn
WHERE Contract = 'Month-to-month'
  AND MonthlyCharges >= 70
  AND tenure <= 12
  AND Churn = 'Yes'
ORDER BY MonthlyCharges DESC;
SELECT
    Contract,
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM cleaned_customer_churn
GROUP BY Contract, InternetService
ORDER BY churn_rate DESC;
SELECT
    ROUND(SUM(MonthlyCharges), 2) AS monthly_revenue_lost
FROM cleaned_customer_churn
WHERE Churn = 'Yes';
SELECT
    Contract,
    InternetService,
    tenureGroup,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS retained_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(AVG(tenure), 2) AS avg_tenure
FROM cleaned_customer_churn
GROUP BY Contract, InternetService, tenureGroup
ORDER BY churn_rate DESC;
USE customer_churn;

CREATE OR REPLACE VIEW churn_analysis AS
SELECT
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents,
    tenure,
    tenureGroup,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    MonthlyCharges,
    TotalCharges,
    Churn
FROM cleaned_customer_churn;
SELECT *
FROM churn_analysis
LIMIT 10;
SELECT COUNT(*) AS total_customers
FROM churn_analysis;