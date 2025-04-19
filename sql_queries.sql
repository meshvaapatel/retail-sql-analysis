USE meshva;

-- Table: demand
CREATE TABLE IF NOT EXISTS demand (
    ProductID INT,
    Date DATE,
    StoreID INT,
    SalesQuantity INT,
    Price DECIMAL(10, 2),
    Promotions VARCHAR(255),
    SeasonalityFactors VARCHAR(255),
    DemandTrend VARCHAR(255),
    CustomerSegments VARCHAR(255),
    StoreLocation VARCHAR(255),
    ManagerID VARCHAR(10)
);

-- Table: inventory
CREATE TABLE IF NOT EXISTS inventory (
    ProductID INT,
    StoreID INT,
    StockLevels INT,
    SupplierLeadTime INT,
    StockoutFrequency INT,
    ReorderPoint INT,
    WarehouseCapacity INT,
    OrderFulfillmentTime INT
);

-- Table: pricing
CREATE TABLE IF NOT EXISTS pricing (
    ProductID INT,
    StoreID INT,
    Price DECIMAL(10, 2),
    CompetitorPrices DECIMAL(10, 2),
    Discounts DECIMAL(10, 2),
    SalesVolume INT,
    CustomerReviews INT,
    ReturnRate DECIMAL(10, 2),
    StorageCost DECIMAL(10, 2)
);

-- Table: manager
CREATE TABLE IF NOT EXISTS manager (
    ManagerID VARCHAR(10),
    ManagerName VARCHAR(255),
    StoreLocation VARCHAR(255)
);

-- Table: Product
CREATE TABLE product (
	ProductID INT,
	Category VARCHAR(255),
    SubCategory VARCHAR(255)
);

-- 1. Calculate the Overall Sales Quantity and Total Revenue Generated
SELECT SUM(SalesQuantity) AS TotalQuntity, SUM(SalesQuantity * Price) AS TotalRevenue
FROM demand;

-- 2. Determine the Count of Unique Seasonality Factors Influencing Demand
SELECT SeasonalityFactors, COUNT(SeasonalityFactors) AS Unique_Seasonality_factors
FROM demand
GROUP BY SeasonalityFactors
HAVING COUNT(SeasonalityFactors);

-- 3. Retrieve All Unique Store Locations from the Dataset
SELECT DISTINCT StoreLocation FROM demand;

-- 4. Count the Number of Managers Assigned to Each Store Location
SELECT StoreLocation, COUNT(DISTINCT ManagerID) AS ManagerCount
FROM demand
GROUP BY StoreLocation;

-- 5. Display All Distinct Product Categories Alongside Their Subcategories
SELECT DISTINCT Category, SubCategory FROM product;

-- 6. Quantify the Number of Products Available Within Each Category
SELECT Category, COUNT(*) AS ProductCount
FROM product
GROUP BY Category;

-- 7. Identify the Minimum and Maximum Prices Recorded in the Pricing Data
SELECT MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice 
FROM pricing;

-- 8. Highlight the Top 10 Best-Performing Products by Revenue, Categorized Accordingly
SELECT p.ProductID, p.Category, p.SubCategory, SUM(d.SalesQuantity * d.Price) AS TotalRevenue
FROM demand d
JOIN product p ON d.ProductID = p.ProductID
GROUP BY p.Category, p.ProductID, p.SubCategory
ORDER BY p.Category, TotalRevenue DESC
limit 10;

-- 9. Analyze Monthly Sales Trends Based on Revenue Over Time
SELECT DATE_FORMAT(Date, '%Y-%m') AS Month, SUM(SalesQuantity * Price) AS MonthlyRevenue
FROM demand
GROUP BY Month
ORDER BY Month;

-- 10. Compare Average Product Prices and Discounts Against Competitor Benchmarks
SELECT ProductID,
    ROUND(AVG(Price), 2) AS AvgOurPrice,
    ROUND(AVG(CompetitorPrices), 2) AS AvgCompetitorPrice,
    ROUND(AVG(Discounts), 2) AS AvgDiscount
FROM pricing
GROUP BY ProductID;

-- 11. Identify Stock-Risk Products Where Sales Volumes Exceed Reorder Points
SELECT d.ProductID, d.StoreID, SUM(d.SalesQuantity) AS TotalQuantity, i.ReorderPoint
FROM demand d
JOIN inventory i ON d.ProductID = i.ProductID AND d.StoreID = i.StoreID
GROUP BY d.ProductID, d.StoreID, i.ReorderPoint
HAVING TotalQuantity > i.ReorderPoint;

-- 12. Spot Products with Low Stock Levels Yet High Market Demand
SELECT d.ProductID, p.SubCategory
FROM demand d
JOIN product p ON d.ProductID = p.ProductID
JOIN inventory i ON d.ProductID = i.ProductID
WHERE i.StockLevels < i.ReorderPoint AND d.SalesQuantity > (SELECT AVG(SalesQuantity) FROM demand)
GROUP BY d.ProductID, p.SubCategory;

-- 13. List the Top 5 Products with the Highest Return Rates by Subcategory
SELECT p.ProductID, s.SubCategory, p.ReturnRate
FROM pricing p
JOIN product s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ReturnRate, s.SubCategory
ORDER BY p.ReturnRate DESC
LIMIT 5;

-- 14. Examine Demand Trends Across Store Locations and Their Frequency
SELECT StoreLocation, DemandTrend, COUNT(*) AS TrendCount
FROM demand
GROUP BY StoreLocation, DemandTrend;

-- 15. Extract Products with Above-Average Sales Volumes for Deeper Insight
SELECT *
FROM pricing
WHERE SalesVolume > (SELECT AVG(SalesVolume) FROM pricing);

-- 16. Rank Stores Based on Fastest Order Fulfillment Times (Top 5)
SELECT i.StoreID, d.StoreLocation, MIN(OrderFulfillmentTime) AS FastestTime
FROM inventory i
JOIN demand d ON i.StoreID = d.StoreID
GROUP BY i.StoreID, d.StoreLocation
ORDER BY FastestTime DESC
LIMIT 5;

-- 17. Find Managers Overseeing Multiple Store Locations	
SELECT ManagerID, COUNT(DISTINCT StoreLocation) AS StoreCount
FROM demand
GROUP BY ManagerID
HAVING StoreCount > 1;

-- 18. Estimate Product Profit Margins Based on Discounts Versus Return Rates
SELECT ProductID, Discounts, ReturnRate, (Discounts - ReturnRate) AS ProfitIndicator
FROM pricing;

-- 19. Evaluate Total Revenue Distribution Across Various Customer Segments
SELECT CustomerSegments, SUM(SalesQuantity * Price) AS TotalRevenue
FROM demand
GROUP BY CustomerSegments
ORDER BY TotalRevenue DESC;

-- 20. Analyze Revenue Distribution Influenced by Different Seasonality Factors
SELECT SeasonalityFactors, SUM(SalesQuantity * Price) AS TotalRevenue
FROM demand
GROUP BY SeasonalityFactors;

-- 21. Assess Warehouse Utilization by Comparing Stock Levels to Capacity
SELECT StoreID, 
       SUM(StockLevels) AS TotalStock, 
       SUM(WarehouseCapacity) AS TotalCapacity,
       ROUND(SUM(StockLevels)/SUM(WarehouseCapacity) * 100, 2) AS UtilizationPercent
FROM inventory
GROUP BY StoreID;

-- 22. Identify Products Priced Lower Than Competitors Yet Rated Highly by Customers
SELECT ProductID, Price, CompetitorPrices, CustomerReviews
FROM pricing
WHERE Price < CompetitorPrices AND CustomerReviews >= 3;

-- 23. Determine the Top-Performing Categories and Subcategories Based on Sales Revenue
SELECT p.Category, p.SubCategory, SUM(d.SalesQuantity * d.Price) AS TotalRevenue
FROM demand d
JOIN product p ON d.ProductID = p.ProductID
GROUP BY p.Category, p.SubCategory
ORDER BY TotalRevenue DESC;

-- 24. Retrieve the top-performing loacation and its manager.
SELECT d.StoreLocation, m.ManagerName, SUM(SalesQuantity * Price) AS TotalRevenue
FROM demand d
JOIN manager m ON d.ManagerID = m.ManagerID
GROUP BY StoreLocation, ManagerName
ORDER BY TotalRevenue DESC;

-- 25. Retrieve top 10 product Categories that experience the highest StockoutFrequency.
SELECT d.ProductID, p.Category, i.StockoutFrequency
FROM demand d
JOIN inventory i ON d.ProductID = i.ProductID
JOIN product p ON d.ProductID = p.ProductID
GROUP BY d.ProductID, p.Category, i.StockoutFrequency
ORDER BY i.StockoutFrequency DESC
limit 10;
