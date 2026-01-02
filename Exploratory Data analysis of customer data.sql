-- EXPLORATORY DATA ANALYSIS 
-- 1.how many customers purchased goods 2107
SELECT COUNT(DISTINCT customer_id)
FROM customer_copy0 ;

-- 2.HOW MANY CUSTOMERS ARE FEMALE VS MALE
SELECT gender, COUNT(*)
FROM customer_copy0
GROUP BY gender 

-- 3.HOW MANY CUSTOMERS HAVE VALID PHONE NUMBERS
SELECT phone_valid, COUNT(*)
FROM customer_copy0
WHERE phone_valid = 1 ;

-- 4.NUMBER OF UNIQUE CITIES
SELECT COUNT(DISTINCT city) AS unique_city
FROM customer_copy0 ;

-- 5.AVALILABLE CUSTOMER SOURCES
SELECT COUNT(DISTINCT `source`) AS available_sources
FROM customer_copy0 

-- 6.CUSTOMER SIGNUPS PER YEAR
SELECT YEAR(signup_date) AS signup_year, COUNT(*)
FROM customer_copy0
GROUP BY signup_year
ORDER BY signup_year ;

-- 7.DEVICES USED BY  MORE THAN ONE CUSTOMER
SELECT DISTINCT `device_id(s)`, COUNT(*) AS TOTAL
FROM customer_copy0
GROUP BY `device_id(s)`
HAVING TOTAL > 1

-- 8.FIVE STATES WITH THE HIGHEST NUMBER OF CUSTOMERS
SELECT state, COUNT(*) AS total_customers
FROM customer_copy0
GROUP BY state 
ORDER BY total_customers DESC
LIMIT 5 ;

-- 9.TEN CITIES WITH THE HIGHEST NUMBER OF CUSTOMERS
SELECT city, COUNT(*) AS total_customers
FROM customer_copy0
GROUP BY city
ORDER BY total_customers DESC
LIMIT 5 ;

-- 10. MOST COMMON SOURCES
SELECT `source`, COUNT(*) AS tot
FROM customer_copy0
GROUP BY `source`
ORDER BY tot DESC
LIMIT 1 ;

-- 11. HIGHEST SOURCE BY GENDER
SELECT `source`,gender, COUNT(*) AS tot
FROM customer_copy0
GROUP BY gender, `source`
ORDER BY `source`, tot DESC

-- 12. CUSTOMER AGE DISTRIBUTION
SELECT 
	FLOOR(DATEDIFF(CURDATE(), dob) / 365) AS age, 
    COUNT(*) AS customer_with_this_age
FROM customer_copy0
GROUP BY age
ORDER BY age ASC;

-- 13. AVERAGE AGE BY GENDER
SELECT gender,
	ROUND(AVG(DATEDIFF(CURDATE(), dob) / 365), 1) AS avg_age
FROM customer_copy0
GROUP BY gender

-- 14. AVERAGE AGE BY ACQUSITION SOURCE
SELECT `source`,
	ROUND(AVG(DATEDIFF(CURDATE(), dob) / 365), 1) AS avg_age
FROM customer_copy0
GROUP BY `source`;

-- 15. WHICH STATE HAS THE HIGHES NUMBER OF CUSTOMERS WITH INVALID PHONE NO
SELECT state, phone_valid, COUNT(*) AS invalid_cust
FROM customer_copy0
WHERE phone_valid = 0
GROUP BY state
ORDER BY invalid_cust DESC;

-- 16. TOP 5 CITIES WITH CUSTOMERS USING SAME DEVICE_ID
SELECT city, `device_id(s)`, COUNT(*) AS same_device
FROM customer_copy0
GROUP BY city, `device_id(s)`
ORDER BY same_device DESC ;

-- 17. month with highest signups
SELECT SUBSTRING(signup_date, 6,2) AS `month`, COUNT(*) AS customer_signups
FROM customer_copy0
GROUP BY `month`
ORDER BY customer_signups DESC ;

-- 18. WHAT CITY HAS HIGHEST PERCENTAGE OF FEMALE CUSTOMERS
SELECT city,
	COUNT(CASE WHEN gender = 'Female' THEN 1 END) * 100.0 / COUNT(*) AS percent_female
FROM customer_copy0
GROUP BY  city 
ORDER BY percent_female DESC
LIMIT 1 ;

-- 19. WHICH SOURCE BRINGS THE MOST CUSTOMERS
SELECT `source`, COUNT(*) AS count_s
FROM customer_copy
GROUP BY `source` 
ORDER BY count_s DESC
LIMIT 1 ;

-- 20. AGE GROUP CONTRIBUTION BY SOURCE
SELECT `source`, age_group, COUNT(*) AS total
FROM (
  SELECT
	`source`,
    CASE 
		WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-50'
        ELSE '60+'
	END AS age_group
	FROM (
		SELECT 
			`source`,
			FLOOR(DATEDIFF(CURDATE(), dob) / 365) AS age
		FROM customer_copy
        )a
	)b
    GROUP BY `source`, age_group
    ORDER BY `source`, total ;
