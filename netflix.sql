1. Count the number of Movies vs TV Shows

   SELECT 
	    type,
	    COUNT(*) as total_content   
    FROM netflix
        GROUP BY type

2. Find the most common rating for movies and TV shows
	
 SELECT
	  type,
      rating,
	 COUNT(*),
	RANK() OVER(PARTITION BY type ORDER BY COUNT(*)) as ranking
  FROM netflix    
	 GROUP BY 1, 2
	  ORDER BY 1, 3 DESC

3. List all movies released in a specific year (e.g., 2020)

  SELECT *
   FROM netflix
   WHERE type = 'Movie'
         AND
         release_year = '2020'

4.Find the top 5 countries with the most content on Netflix

   SELECT
	   UNNEST(STRING_TO_ARRAY(country, ',')) as new_country,
	   COUNT(*) as total_content
	FROM netflix
  GROUP BY 1 
   ORDER BY total_content desc
  LIMIT 5

5. Identify the longest movie or TV show duration

 SELECT *
		FROM netflix
WHERE
    duration = (SELECT MAX(duration)  FROM netflix)

6. Find content added in the last 5 years

 SELECT * FROM netflix
 WHERE
      TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 Years'

7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

  SELECT *
       FROM netflix
WHERE
     director = 'Rajiv Chilaka'

8. List all TV Shows with more than 5 seasons

  SELECT * FROM netflix
WHERE
     type = 'TV Show'
	AND
   SPLIT_PART(duration, ' ',1)::numeric >5

9. Count the number of content items in each genre


SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in, ',')),
	COUNT(show_id) 
	FROM netflix
	 GROUP BY 1

10. Find each  year and  the average numbers of content release by INDIA on ntflix.
	return  top 5 year with highest avg content release! 

 SELECT 
    EXTRaCT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) as Year,
    COUNT(*) as yearly_content,
	ROUND(
	COUNT(*):: numeric /(SELECT count(*) FROM netflix WHERE country = 'India'):: numeric * 100
		,2)	as avg_content_for_year
FROM netflix
   WHERE
        country = 'India'
GROUP BY 1

11. List all movies that are documentaries

 SELECT * FroM netflix
WHERE type = 'Movie'
AND
    listed_in = 'Documentaries'

12. Find all content without a director

SELECT * FROM netflix
WHERE
    director IS NULL

13. Find how many movies actor 'Salaman Khan' appeared in last 10 years!

SELECT * FROM netflix
WHERE casts iLIKE '%Salman khan%'
     AND
      release_year > EXTRACT(Year FROM CURRENT_DATE) - 10

14. Find the top 10 actors who have appeared in the highest number of movies produced in 'India'

SELECT
  -- show_id,
  -- casts,
     UNNEST(STRING_TO_ARRAY(casts, ',')) as actors,
    COUNT(*) as total_content
FROM netflix
	WHERE country = 'India'
   GROUP BY 1
  ORDER BY 2 DESC
 LIMIT 10

15. Categorize the content based on the presence of the keywords 'Kill' and 'violence' in the description field.
	Label content containing these keywords as 'Bad' and all other content as 'Good'. Count how many items fall
    into each category.

WITH new_table
AS
(	
SELECT
	*,
	CASE
	WHEN
	   description ILIKE '%Kill%' OR
	     description ILIKE '%violence%' THEN 'bad_content'
	ELSE 'Good_content'
	END CATEGORY
FROM netflix
)
SELECT CATEGORY,
       COUNT(*) as total_content
FROM new_table
GROUP BY 1




	


	







































   
















































