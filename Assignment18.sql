-- 1. Create a SQL view named TopRatedRestaurants that selects the restaurant name, average rating, and total number of reviews from a 
--    table of Zomato-style restaurant reviews, showing only restaurants with an average rating above 4.0.

CREATE VIEW TopRatedRestaurants AS
SELECT
    r.name AS restaurant_name,
    AVG(rr.rating) AS average_rating,
    COUNT(rr.rating) AS total_reviews
FROM Restaurants r
JOIN RestaurantReviews rr
    ON r.restaurant_id = rr.restaurant_id
GROUP BY r.restaurant_id, r.name
HAVING AVG(rr.rating) > 4.0;

-- for check the view :
SELECT * FROM TopRatedRestaurants;

----------------------------------------------------------------------------------------------------------------------------------------
-- 2. Update the TopRatedRestaurants view to also include the city column from the original restaurants table by joining the relevant tables.
--    <br><br><em><strong>Hint:</strong> Use an INNER JOIN to combine data from both tables in your view definition.</em>

CREATE OR REPLACE VIEW TopRatedRestaurants AS
SELECT
    r.name AS restaurant_name,
    r.city,
    AVG(rr.rating) AS average_rating,
    COUNT(rr.rating) AS total_reviews
FROM Restaurants r
INNER JOIN RestaurantReviews rr
    ON r.restaurant_id = rr.restaurant_id
GROUP BY r.restaurant_id, r.name, r.city
HAVING AVG(rr.rating) > 4.0;

-- for check the updatesd view :
SELECT *
FROM TopRatedRestaurants;

----------------------------------------------------------------------------------------------------------------------------------------
-- 3. Try to update the average rating column directly through the TopRatedRestaurants view and observe what error or limitation occurs.
--    Write down the exact error message and explain why this happens based on SQL view limitations.

UPDATE TopRatedRestaurants
SET average_rating = 5.0
WHERE restaurant_name = 'Restaurant A';

-- This will generally fail because
-- SQL views that include aggregate functions (like AVG) and GROUP BY clauses are not updatable. It is calculated by AVG().

----------------------------------------------------------------------------------------------------------------------------------------
-- 4. Create a view called DailyOrderSummary that shows, for each date, the total number of food orders and the total revenue from a 
--    Swiggy-style orders table. Ensure the view only includes dates from the last 30 days.<br><br><em><strong>Constraint:</strong>
--    Use WHERE and GROUP BY clauses in your view definition.</em>

CREATE VIEW DailyOrderSummary AS
SELECT
    order_date,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM SwiggyOrders
WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY order_date;

-- for check the view :
SELECT * FROM DailyOrderSummary;


----------------------------------------------------------------------------------------------------------------------------------------
-- 5. List 3 good practices you should follow when creating SQL views for analytics dashboards, and for each, give a one-line example 
--    related to a Flipkart sales reporting scenario.



-- 1. Keep the view focused and include only the required columns
-- Example: For a Flipkart sales dashboard, create a view containing 
-- only product_name, category, sales_amount, and order_date instead
-- of all columns from the orders table.

-- 2. Use meaningful names for views and calculated columns
-- Example: Use FlipkartSalesSummary as the view name and 
-- total_revenue for SUM(sales_amount) instead of unclear
-- names like view1 or sum1.

-- 3. Avoid unnecessary complex calculations and repeated logic
-- Example: Create a FlipkartCategorySales view that calculates 
-- SUM(sales_amount) for each product category and use this view 
-- for category-wise sales reports.