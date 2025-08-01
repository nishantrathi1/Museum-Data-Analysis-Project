# Museum-Data-Analysis-Project
Performed end-to-end data analysis on a multi-table art museum dataset using advanced SQL (joins, CTEs, window functions) to derive insights on artist popularity, pricing anomalies, museum operations, and data quality issues.

This project explores a comprehensive art database involving paintings, artists, museums, and operational data. The goal is to derive meaningful business and cultural insights using SQL queries.
## Objective

To answer real-world analytical questions using SQL involving:
- Artwork inventory
- Museum operations
- Artist popularity
- Revenue opportunities
- Data quality and cleanup

## Dataset Overview


 Table Name        Description                                   
 work$           Information about paintings (title, artist, style, etc.) 
 artist$         Artist profiles and nationalities             
 museum$         Museum names, locations, and identifiers      
 museum_hours$   Opening and closing times by day              
 product_size$   Pricing information for artwork               
 canvas_size$    Canvas dimensions and labels                  
 subject$        Subjects represented in each painting         
 image_link$     Image references for artworks                 

##  Business Questions Solved:
- Paintings not on display in any museum
- Museums open all week / open longest per day
- Identify duplicates, nulls, and invalid entries
- Paintings priced 50% below regular price
- Artists featured in multiple countries
- Most and least expensive paintings with artist & museum info
- Top 3 and bottom 3 painting styles
- 
## Sample Query


-- Which artists have paintings displayed in multiple countries?
WITH cte AS (
  SELECT DISTINCT a.full_name, m.country 
  FROM work$ w 
  JOIN artist$ a ON a.artist_id = w.artist_id 
  JOIN museum$ m ON m.museum_id = w.museum_id
)
SELECT full_name, COUNT(country) AS no_of_countries
FROM cte
GROUP BY full_name
HAVING COUNT(country) > 1;


Tools Used
- SQL Server
- Microsoft Excel(for data validation)

Highlights

- Designed 20+ optimized SQL queries for business questions
- Used **window functions**, **CTEs**, **aggregations**, and **joins**
- Demonstrated **data cleaning**, **reporting**, and **insight generation**
