
SELECT COUNT(DISTINCT user.id) as MAU, MONTH(transaction.created_at) as month_MAU
FROM user  
LEFT JOIN transaction ON user.id = transaction.user_id
LEFT JOIN transaction_type ON transaction.transaction_type_id = transaction_type.id
WHERE transaction_type.unique_name LIKE'SPEND' AND YEAR(transaction.created_at) >= 2020
GROUP BY MONTH(transaction.created_at)

SELECT COUNT(DISTINCT user.id) as MAU,  MONTH(transaction.created_at) as month_MAU, country.name as country, campaign_category.name as category
FROM user
LEFT JOIN country ON user.country_id = country.id 
LEFT JOIN transaction ON user.id = transaction.user_id
LEFT JOIN transaction_type ON transaction.transaction_type_id = transaction_type.id
LEFT JOIN campaign ON user.id = campaign.user_id
LEFT JOIN campaign_category ON campaign.campaign_category_id = campaign_category.id 
WHERE transaction_type.unique_name LIKE'SPEND' AND YEAR(transaction.created_at) >= 2020
GROUP BY MONTH(transaction.created_at), country.name, campaign_category.name
ORDER BY MAU ASC