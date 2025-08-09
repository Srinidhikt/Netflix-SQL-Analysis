-- 1. Select basic info of first 10 titles
SELECT show_id, title, content_type, director, country, release_yr
FROM netflix_titles
LIMIT 10;

-- 2. Count movies vs TV shows
SELECT content_type, COUNT(*) AS total_count
FROM netflix_titles
GROUP BY content_type;

-- 3. Titles released after 2015
SELECT title, release_yr
FROM netflix_titles
WHERE release_yr > 2015
ORDER BY release_yr DESC;

-- 4. Top 5 countries with most titles
SELECT country, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY country
ORDER BY total_titles DESC
LIMIT 5;

-- 5. Average release year by content type
SELECT content_type, AVG(release_yr) AS avg_release_year
FROM netflix_titles
GROUP BY content_type;

-- 6. Titles with the word "Love" in the title
SELECT title, release_yr
FROM netflix_titles
WHERE title LIKE '%Love%';

-- 7. Subquery: Directors with more than 5 titles
SELECT director, total_titles FROM (
    SELECT director, COUNT(*) AS total_titles
    FROM netflix_titles
    GROUP BY director
) AS sub
WHERE total_titles > 5;

-- 8. Join example (Self join on country to pair titles from same country)
SELECT a.title AS title_a, b.title AS title_b, a.country
FROM netflix_titles a
INNER JOIN netflix_titles b
    ON a.country = b.country AND a.show_id <> b.show_id
LIMIT 10;

-- 9. Aggregate: Count titles per rating
SELECT rating, COUNT(*) AS total
FROM netflix_titles
GROUP BY rating;

-- 10. Create a view for US titles only
CREATE VIEW us_titles AS
SELECT *
FROM netflix_titles
WHERE country = 'United States';

-- 11. Use the view to count US movies vs TV shows
SELECT content_type, COUNT(*) AS total_count
FROM us_titles
GROUP BY content_type;

-- 12. Create index to optimize searches by title
CREATE INDEX idx_title ON netflix_titles(title);
