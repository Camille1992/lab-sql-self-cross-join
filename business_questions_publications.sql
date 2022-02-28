# use publications
# create 3 business questions and answer them by doing the queries
# has to use joints
# present business plan at the end to the others

# Sales by city (and store)
# TABLES
	# sales: qty
    # store: city, store_name
# JOIN
	# on stor_id
SELECT 
	S.city, S.stor_name,
    SUM(SA.qty) AS sales_volume,
    ROUND((T.price*(1-(T.royalty/100))),2) AS profit_per_unit,
    ROUND(SUM(SA.qty)*(T.price*(1-(T.royalty/100))),2) AS total_profit
FROM
	stores S
	INNER JOIN
		sales SA
	ON
		S.stor_id = SA.stor_id
	INNER JOIN
		titles T
	ON
		T.title_id = SA.title_id
GROUP BY
	S.city, S.stor_name
ORDER BY
	total_profit DESC;
    
# Top 10 best selling authors
# TABLES 
	# authors; key: au_id
    # titleauthor; keys: au_id, title_id
	# sales; keys: stor_id, title_id
SELECT
	CONCAT(A.au_lname, " ", A.au_fname) AS author_name, T.type AS genre,
    SUM(S.qty)*ROUND(SUM(S.qty)*(T.price*(1-(T.royalty/100))),2) AS revenue_per_author
FROM
	authors A
	INNER JOIN
		titleauthor TA
	ON
		A.au_id = TA.au_id
	INNER JOIN
		sales S
	ON
		TA.title_id = S.title_id
	INNER JOIN
		titles T
	ON
		TA.title_id = T.title_id
GROUP BY
	author_name, genre
ORDER BY
	revenue_per_author DESC
LIMIT 
	10;
    
# TEMP TABLE

CREATE TEMPORARY TABLE best_selling_authors
SELECT
	CONCAT(A.au_lname, " ", A.au_fname) AS author_name, T.type AS genre,
    SUM(S.qty)*ROUND(SUM(S.qty)*(T.price*(1-(T.royalty/100))),2) AS revenue_per_author
FROM
	authors A
	INNER JOIN
		titleauthor TA
	ON
		A.au_id = TA.au_id
	INNER JOIN
		sales S
	ON
		TA.title_id = S.title_id
	INNER JOIN
		titles T
	ON
		TA.title_id = T.title_id
GROUP BY
	author_name, genre
ORDER BY
	revenue_per_author DESC
LIMIT 
	10;

SELECT * FROM best_selling_authors;


# Top sales per genre
SELECT
	T.type AS genre,
    SUM(S.qty)*ROUND(SUM(S.qty)*(T.price*(1-(T.royalty/100))),2) AS revenue_per_genre
FROM
	titles T
	INNER JOIN
		sales S
	ON
		T.title_id = S.title_id
GROUP BY
	genre
ORDER BY
	revenue_per_genre DESC, genre ASC;

 