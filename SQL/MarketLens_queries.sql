use marketlens;

CREATE TABLE campaign_performance (
    Campaign_ID VARCHAR(20) PRIMARY KEY,
    Campaign_Name VARCHAR(150),
    Channel VARCHAR(50),
    Campaign_Type VARCHAR(50),
    Start_Date DATETIME,
    End_Date DATETIME,
    Budget DECIMAL(12,2),
    Spend DECIMAL(12,2),
    Impressions BIGINT,
    Clicks BIGINT,
    Leads INT,
    Qualified_Leads INT,
    Customers INT,
    Revenue DECIMAL(12,2)
);

DESCRIBE campaign_performance;

SELECT COUNT(*) AS total_campaigns
FROM campaign_performance;

SELECT * FROM campaign_performance;

SELECT SUM(Leads) AS Total_Leads
FROM campaign_performance;

SELECT SUM(Qualified_Leads) AS Total_Qualified_Leads
FROM campaign_performance;

SELECT SUM(Customers) AS Total_Customers
FROM campaign_performance;

SELECT ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM campaign_performance;

SELECT ROUND(SUM(Spend), 2) AS Total_Spend
FROM campaign_performance;

SELECT ROUND(SUM(Budget), 2) AS Total_Budget
FROM campaign_performance;

SELECT ROUND(SUM(Clicks) / SUM(Impressions) * 100, 2) AS CTR
FROM campaign_performance;

SELECT ROUND(SUM(Spend) / SUM(Leads), 2) AS CPL
FROM campaign_performance;

SELECT ROUND(SUM(Spend) / SUM(Customers), 2) AS CAC
FROM campaign_performance;

SELECT ROUND(SUM(Revenue) / SUM(Spend), 2) AS ROAS
FROM campaign_performance;

SELECT ROUND(((SUM(Revenue) - SUM(Spend)) / SUM(Spend)) * 100,2) AS ROI_Percent
FROM campaign_performance;

SELECT 
    Campaign_ID,
    Campaign_Name,
    Channel,
    Revenue,
    Spend,
    Customers,
    ROUND(Revenue / Spend, 2) AS ROAS
FROM campaign_performance
ORDER BY ROAS DESC;

SELECT 
    Channel,
    SUM(Spend) AS Total_Spend,
    SUM(Revenue) AS Total_Revenue,
    SUM(Customers) AS Total_Customers,
    ROUND(SUM(Revenue) / SUM(Spend), 2) AS ROAS
FROM campaign_performance
GROUP BY Channel
ORDER BY ROAS DESC;

SELECT 
    Campaign_Type,
    SUM(Leads) AS Total_Leads,
    SUM(Customers) AS Total_Customers,
    ROUND(SUM(Spend), 2) AS Total_Spend,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Revenue) / SUM(Spend), 2) AS ROAS
FROM campaign_performance
GROUP BY Campaign_Type
ORDER BY ROAS DESC;

SELECT
    SUM(Impressions) AS Total_Impressions,
    SUM(Clicks) AS Clicks,
    SUM(Leads) AS Leads,
    SUM(Qualified_Leads) AS Qualified_Leads,
    SUM(Customers) AS Total_Customers
FROM campaign_performance;

SELECT
    ROUND(SUM(Clicks) / SUM(Impressions) * 100, 2) AS Click_Rate,
    ROUND(SUM(Leads) / SUM(Clicks) * 100, 2) AS Lead_Conversion_Rate,
    ROUND(SUM(Qualified_Leads) / SUM(Leads) * 100, 2) AS Qualification_Rate,
    ROUND(SUM(Customers) / SUM(Qualified_Leads) * 100, 2) AS Customer_Conversion_Rate
FROM campaign_performance;

SELECT
    Campaign_ID,
    Campaign_Name,
    Channel,
    Campaign_Type,
    Spend,
    Revenue,
    Leads,
    Customers,
    ROUND(Clicks / Impressions * 100, 2) AS CTR,
    ROUND(Spend / Leads, 2) AS CPL,
    ROUND(Spend / Customers, 2) AS CAC,
    ROUND(Revenue / Spend, 2) AS ROAS,
    ROUND((Revenue - Spend) / Spend * 100, 2) AS ROI
FROM campaign_performance
ORDER BY ROAS DESC;

SELECT
    Channel,
    SUM(Impressions) AS Impressions,
    SUM(Clicks) AS Clicks,
    SUM(Leads) AS Leads,
    SUM(Customers) AS Customers,
    ROUND(SUM(Spend), 2) AS Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Clicks) / SUM(Impressions) * 100, 2) AS CTR,
    ROUND(SUM(Spend) / SUM(Leads), 2) AS CPL,
    ROUND(SUM(Spend) / SUM(Customers), 2) AS CAC,
    ROUND(SUM(Revenue) / SUM(Spend), 2) AS ROAS
FROM campaign_performance
GROUP BY Channel
ORDER BY ROAS DESC;

SELECT
    Campaign_Type,
    SUM(Leads) AS Leads,
    SUM(Customers) AS Customers,
    ROUND(SUM(Spend), 2) AS Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Revenue) / SUM(Spend), 2) AS ROAS
FROM campaign_performance
GROUP BY Campaign_Type
ORDER BY ROAS DESC;

SELECT
    Campaign_ID,
    Campaign_Name,
    Budget,
    Spend,
    ROUND((Spend / Budget) * 100, 2) AS Budget_Utilization
FROM campaign_performance
ORDER BY Budget_Utilization DESC;

SELECT
    Campaign_ID,
    Campaign_Name,
    Budget,
    Spend,
    ROUND(Budget - Spend, 2) AS Remaining_Budget
FROM campaign_performance
WHERE Budget > Spend
ORDER BY Remaining_Budget DESC;

SELECT
    Campaign_ID,
    Campaign_Name,
    Budget,
    Spend,
    ROUND(Spend - Budget, 2) AS Overspend
FROM campaign_performance
WHERE Spend > Budget
ORDER BY Overspend DESC;

USE marketlens;

DESCRIBE leads_customers;

SELECT COUNT(*) FROM leads_customers;

SELECT * FROM leads_customers;

SELECT
    Status,
    COUNT(*) AS Total_Leads,
    SUM(Revenue) AS Total_Revenue
FROM leads_customers
GROUP BY Status
ORDER BY Total_Revenue DESC;

SELECT
    Device,
    COUNT(*) AS Total_Leads,
    SUM(Revenue) AS Total_Revenue,
    ROUND(SUM(Revenue) / COUNT(*), 2) AS Revenue_Per_Lead
FROM leads_customers
GROUP BY Device
ORDER BY Total_Revenue DESC;

SELECT
    Age_Group,
    COUNT(*) AS Total_Leads,
    SUM(Revenue) AS Total_Revenue,
    ROUND(SUM(Revenue) / COUNT(*), 2) AS Revenue_Per_Lead
FROM leads_customers
GROUP BY Age_Group
ORDER BY Total_Revenue DESC;

SELECT
    Region,
    COUNT(*) AS Total_Leads,
    SUM(Revenue) AS Total_Revenue
FROM leads_customers
GROUP BY Region
ORDER BY Total_Revenue DESC;

SELECT
    c.Campaign_ID,
    c.Campaign_Name,
    c.Channel,
    c.Spend,
    c.Revenue AS Campaign_Revenue,
    COUNT(l.Lead_ID) AS Total_Leads
FROM campaign_performance c
LEFT JOIN leads_customers l
    ON c.Campaign_ID = l.Campaign_ID
GROUP BY
    c.Campaign_ID,
    c.Campaign_Name,
    c.Channel,
    c.Spend,
    c.Revenue
ORDER BY Total_Leads DESC;

select * from customer_journeys

SELECT COUNT(*) AS Total_Rows
FROM customer_journeys;

SELECT
    First_Touch,
    COUNT(*) AS Customers,
    SUM(Revenue) AS Revenue
FROM customer_journeys
WHERE Converted = 1
GROUP BY First_Touch
ORDER BY Revenue DESC;

SELECT
    Last_Touch,
    COUNT(*) AS Customers,
    SUM(Revenue) AS Revenue
FROM customer_journeys
WHERE Converted = 1
GROUP BY Last_Touch
ORDER BY Revenue DESC;

SELECT
    First_Touch,
    Last_Touch,
    COUNT(*) AS Conversions,
    ROUND(SUM(Revenue), 2) AS Revenue
FROM customer_journeys
WHERE Converted = 1
GROUP BY First_Touch, Last_Touch
ORDER BY Revenue DESC;

SELECT
    First_Touch,
    Second_Touch,
    Third_Touch,
    Last_Touch,
    Revenue,
    ROUND(Revenue * 0.40, 2) AS First_Touch_Credit,
    ROUND(Revenue * 0.20, 2) AS Second_Touch_Credit,
    ROUND(Revenue * 0.20, 2) AS Third_Touch_Credit,
    ROUND(Revenue * 0.20, 2) AS Last_Touch_Credit
FROM customer_journeys
WHERE Converted = 1;

SELECT
    First_Touch AS Channel,
    ROUND(SUM(Revenue * 0.40), 2) AS Attributed_Revenue
FROM customer_journeys
WHERE Converted = 1
GROUP BY First_Touch
ORDER BY Attributed_Revenue DESC;

SELECT
    Channel,
    ROUND(SUM(Attributed_Revenue), 2) AS Weighted_Attributed_Revenue
FROM (
    SELECT First_Touch AS Channel, Revenue * 0.40 AS Attributed_Revenue
    FROM customer_journeys
    WHERE Converted = 1

    UNION ALL

    SELECT Second_Touch AS Channel, Revenue * 0.20 AS Attributed_Revenue
    FROM customer_journeys
    WHERE Converted = 1

    UNION ALL

    SELECT Third_Touch AS Channel, Revenue * 0.20 AS Attributed_Revenue
    FROM customer_journeys
    WHERE Converted = 1

    UNION ALL

    SELECT Last_Touch AS Channel, Revenue * 0.20 AS Attributed_Revenue
    FROM customer_journeys
    WHERE Converted = 1
) AS Attribution
GROUP BY Channel
ORDER BY Weighted_Attributed_Revenue DESC;

SELECT
    Campaign_ID,
    Campaign_Name,
    Channel,
    Spend,
    Revenue,
    Customers,
    ROUND(Spend / NULLIF(Customers, 0), 2) AS CAC,
    ROUND(Revenue / NULLIF(Spend, 0), 2) AS ROAS,
    ROUND(((Revenue - Spend) / NULLIF(Spend, 0)) * 100, 2) AS ROI_Percent
FROM campaign_performance
ORDER BY ROAS DESC;

SELECT
    Campaign_ID,
    Campaign_Name,
    Channel,
    Budget,
    Spend,
    ROUND(Budget - Spend, 2) AS Remaining_Budget,
    ROUND(Revenue / NULLIF(Spend, 0), 2) AS ROAS
FROM campaign_performance
ORDER BY ROAS DESC;

SELECT
    Channel,
    SUM(Impressions) AS Impressions,
    SUM(Clicks) AS Clicks,
    SUM(Leads) AS Leads,
    SUM(Customers) AS Customers,
    ROUND(SUM(Spend), 2) AS Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Clicks) / NULLIF(SUM(Impressions), 0) * 100, 2) AS CTR,
    ROUND(SUM(Spend) / NULLIF(SUM(Leads), 0), 2) AS CPL,
    ROUND(SUM(Spend) / NULLIF(SUM(Customers), 0), 2) AS CAC,
    ROUND(SUM(Revenue) / NULLIF(SUM(Spend), 0), 2) AS ROAS
FROM campaign_performance
GROUP BY Channel
ORDER BY ROAS DESC;

SELECT
    SUM(Impressions) AS Impressions,
    SUM(Clicks) AS Clicks,
    SUM(Leads) AS Leads,
    SUM(Qualified_Leads) AS Qualified_Leads,
    SUM(Customers) AS Customers,

    ROUND(
        SUM(Clicks) / NULLIF(SUM(Impressions), 0) * 100, 2
    ) AS CTR,

    ROUND(
        SUM(Leads) / NULLIF(SUM(Clicks), 0) * 100, 2
    ) AS Lead_Conversion_Rate,

    ROUND(
        SUM(Qualified_Leads) / NULLIF(SUM(Leads), 0) * 100, 2
    ) AS Qualification_Rate,

    ROUND(
        SUM(Customers) / NULLIF(SUM(Qualified_Leads), 0) * 100, 2
    ) AS Customer_Conversion_Rate

FROM campaign_performance;

SELECT
    Campaign_Type,
    SUM(Leads) AS Total_Leads,
    SUM(Qualified_Leads) AS Qualified_Leads,
    SUM(Customers) AS Customers,
    ROUND(SUM(Spend), 2) AS Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Revenue) / NULLIF(SUM(Spend), 0), 2) AS ROAS
FROM campaign_performance
GROUP BY Campaign_Type
ORDER BY ROAS DESC;

SELECT
    DATE_FORMAT(Start_Date, '%Y-%m') AS Campaign_Month,
    COUNT(*) AS Total_Campaigns,
    SUM(Leads) AS Total_Leads,
    SUM(Customers) AS Total_Customers,
    ROUND(SUM(Spend), 2) AS Total_Spend,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Spend), 0), 2
    ) AS ROAS
FROM campaign_performance
GROUP BY DATE_FORMAT(Start_Date, '%Y-%m')
ORDER BY Campaign_Month;

SELECT
    Campaign_ID,
    Campaign_Name,
    Channel,
    ROUND(Spend, 2) AS Spend,
    Leads,
    Customers,
    ROUND(Spend / NULLIF(Leads, 0), 2) AS CPL,
    ROUND(Spend / NULLIF(Customers, 0), 2) AS CAC,
    ROUND(Revenue / NULLIF(Spend, 0), 2) AS ROAS,
    ROUND(
        ((Revenue - Spend) / NULLIF(Spend, 0)) * 100, 2
    ) AS ROI_Percent
FROM campaign_performance
ORDER BY ROI_Percent DESC;

SELECT
    Campaign_ID,
    Campaign_Name,
    Channel,
    Customers,
    ROUND(Revenue, 2) AS Revenue,
    ROUND(Spend, 2) AS Spend,
    ROUND(Revenue / NULLIF(Spend, 0), 2) AS ROAS
FROM campaign_performance
ORDER BY Revenue DESC
LIMIT 10;

SELECT
    Campaign_ID,
    Campaign_Name,
    Channel,
    ROUND(Spend, 2) AS Spend,
    ROUND(Revenue, 2) AS Revenue,
    ROUND(Revenue / NULLIF(Spend, 0), 2) AS ROAS,
    ROUND(
        ((Revenue - Spend) / NULLIF(Spend, 0)) * 100, 2
    ) AS ROI_Percent
FROM campaign_performance
ORDER BY ROAS ASC
LIMIT 10;

SELECT
    Campaign_ID,
    Campaign_Name,
    Channel,
    ROUND(Budget, 2) AS Budget,
    ROUND(Spend, 2) AS Spend,
    ROUND(
        (Spend / NULLIF(Budget, 0)) * 100, 2
    ) AS Budget_Utilization_Percent,
    ROUND(Budget - Spend, 2) AS Remaining_Budget
FROM campaign_performance
ORDER BY Budget_Utilization_Percent DESC;

SELECT
    Channel,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Spend), 2) AS Total_Spend,
    SUM(Leads) AS Total_Leads,
    SUM(Customers) AS Total_Customers,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Spend), 0), 2
    ) AS ROAS
FROM campaign_performance
GROUP BY Channel
ORDER BY Total_Revenue DESC;

SELECT
    Channel,
    SUM(Leads) AS Total_Leads,
    SUM(Customers) AS Total_Customers,
    ROUND(
        SUM(Customers) / NULLIF(SUM(Leads), 0) * 100,
        2
    ) AS Customer_Conversion_Rate
FROM campaign_performance
GROUP BY Channel
ORDER BY Customer_Conversion_Rate DESC;

SELECT
    Campaign_Type,
    SUM(Leads) AS Total_Leads,
    SUM(Customers) AS Total_Customers,
    ROUND(SUM(Spend), 2) AS Total_Spend,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Spend), 0), 2
    ) AS ROAS
FROM campaign_performance
GROUP BY Campaign_Type
ORDER BY Total_Revenue DESC;

SELECT
    SUM(Leads) AS Total_Leads,
    SUM(Qualified_Leads) AS Total_Qualified_Leads,
    SUM(Customers) AS Total_Customers,
    ROUND(
        SUM(Qualified_Leads) / NULLIF(SUM(Leads), 0) * 100, 2
    ) AS Qualification_Rate,
    ROUND(
        SUM(Customers) / NULLIF(SUM(Leads), 0) * 100, 2
    ) AS Overall_Conversion_Rate
FROM campaign_performance;

SELECT
    Channel,
    Device,
    COUNT(*) AS Total_Leads,
    SUM(CASE WHEN Status = 'Customer' THEN 1 ELSE 0 END) AS Total_Customers,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(
        SUM(CASE WHEN Status = 'Customer' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0) * 100, 2
    ) AS Conversion_Rate
FROM leads_customers
GROUP BY Channel, Device
ORDER BY Total_Revenue DESC;

SELECT
    Campaign_ID,
    Campaign_Name,
    Region,
    COUNT(*) AS Total_Leads,
    SUM(CASE
        WHEN Status = 'Customer' THEN 1
        ELSE 0
    END) AS Total_Customers,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(
        SUM(CASE
            WHEN Status = 'Customer' THEN 1
            ELSE 0
        END) / NULLIF(COUNT(*), 0) * 100,
        2
    ) AS Conversion_Rate
FROM leads_customers
GROUP BY
    Campaign_ID,
    Campaign_Name,
    Region
ORDER BY Total_Revenue DESC;

SELECT
    Campaign_ID,
    Campaign_Name,
    Channel,
    ROUND(Budget, 2) AS Budget,
    ROUND(Spend, 2) AS Spend,
    ROUND(Revenue, 2) AS Revenue,
    ROUND(Revenue / NULLIF(Spend, 0), 2) AS ROAS,
    CASE
        WHEN Revenue / NULLIF(Spend, 0) >= 3 THEN 'Increase Budget'
        WHEN Revenue / NULLIF(Spend, 0) >= 1.5 THEN 'Maintain Budget'
        ELSE 'Review / Reduce Budget'
    END AS Budget_Action
FROM campaign_performance
ORDER BY ROAS DESC;

SELECT
    COUNT(*) AS Total_Campaigns,
    SUM(Impressions) AS Total_Impressions,
    SUM(Clicks) AS Total_Clicks,
    SUM(Leads) AS Total_Leads,
    SUM(Qualified_Leads) AS Total_Qualified_Leads,
    SUM(Customers) AS Total_Customers,
    ROUND(SUM(Spend), 2) AS Total_Spend,
    ROUND(SUM(Budget), 2) AS Total_Budget,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,

    ROUND(
        SUM(Clicks) / NULLIF(SUM(Impressions), 0) * 100, 2
    ) AS CTR,

    ROUND(
        SUM(Spend) / NULLIF(SUM(Leads), 0), 2
    ) AS CPL,

    ROUND(
        SUM(Spend) / NULLIF(SUM(Customers), 0), 2
    ) AS CAC,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Spend), 0), 2
    ) AS ROAS,

    ROUND(
        (SUM(Revenue) - SUM(Spend))
        / NULLIF(SUM(Spend), 0) * 100, 2
    ) AS ROI_Percent

FROM campaign_performance;



