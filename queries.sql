-- = with non-correlated subqueries result

-- retrieves books published in the latest year
SELECT b.id, b.title, b.isbn, b.edition, b.year_publishing, b.price, b.publisher_id, b.review
FROM book b
WHERE year_publishing = (
    SELECT MAX(year_publishing)
    FROM book
);

-- increases the price of books published in the latest year
UPDATE book
JOIN (
    SELECT MAX(year_publishing) AS MAX_year_publishing
    FROM book
) AS temp ON book.year_publishing = temp.MAX_year_publishing
SET book.price = book.price * 1.1;

-- removes books published by publishers located in London
DELETE FROM book
WHERE publisher_id IN (
    SELECT id
    FROM publisher
    WHERE address LIKE '%London%'
);



-- IN with non-correlated subqueries result

-- retrieves books published by publishers located in London
SELECT b.id, b.title, b.isbn, b.edition, b.year_publishing, b.price, b.publisher_id, b.review
FROM book b
WHERE publisher_id IN (
    SELECT id
    FROM publisher
    WHERE address LIKE '%London%'
);

-- reduces the price of books published by publishers located in London by 10%
UPDATE book
SET price = price * 0.9
WHERE publisher_id IN (
    SELECT id
    FROM publisher
    WHERE address LIKE '%London%'
);

-- deletes books published by publishers located in London from the database
DELETE FROM book
WHERE publisher_id IN (
    SELECT id
    FROM publisher
    WHERE address LIKE '%London%'
);



-- NOT IN with non-correlated subqueries result

-- retrieves books not published by publishers located in London
SELECT b.id, b.title, b.isbn, b.edition, b.year_publishing, b.price, b.publisher_id, b.review
FROM book b
WHERE publisher_id NOT IN (
    SELECT id
    FROM publisher
    WHERE address LIKE '%London%'
);

-- increases the price of books not published by publishers located in London by 10%
UPDATE book
SET price = price * 1.1
WHERE publisher_id NOT IN (
    SELECT id
    FROM publisher
    WHERE address LIKE '%London%'
);

-- deletes books not published by publishers located in London from the database
DELETE FROM book
WHERE publisher_id NOT IN (
    SELECT id
    FROM publisher
    WHERE address LIKE '%London%'
);



-- EXISTS with non-correlated subqueries result

-- retrieves books currently on loan and overdue for a specific customer (customer_id = 1)
SELECT b.id, b.title, b.isbn, b.edition, b.year_publishing, b.price, b.publisher_id, b.review
FROM book b
WHERE EXISTS (
    SELECT 1
    FROM loan l
    WHERE l.customer_id = 1
    AND l.return_date IS NULL
    AND l.due_date < CURDATE()
    AND l.id = b.id
);

-- increases the price of books currently on loan and overdue for a specific customer (customer_id = 1) by 10%
UPDATE book
SET price = price * 1.1  
WHERE EXISTS (
    SELECT 1
    FROM loan l
    WHERE l.customer_id = 1
    AND l.return_date IS NULL
    AND l.due_date < CURDATE()
    AND l.id = book.id
);

-- deletes books currently on loan and overdue for a specific customer (customer_id = 1) from the database
DELETE FROM book
WHERE EXISTS (
    SELECT 1
    FROM loan l
    WHERE l.customer_id = 1
    AND l.return_date IS NULL
    AND l.due_date < CURDATE()
    AND l.id = book.id
);



-- NOT EXISTS with non-correlated subqueries result

-- retrieves books not currently on loan or overdue for a specific customer (customer_id = 1)
SELECT b.id, b.title, b.isbn, b.edition, b.year_publishing, b.price, b.publisher_id, b.review
FROM book b
WHERE NOT EXISTS (
    SELECT 1
    FROM loan l
    WHERE l.customer_id = 1
    AND l.return_date IS NULL
    AND l.due_date < CURDATE()
    AND l.id = b.id
);

-- increases the price of books not currently on loan or overdue for a specific customer (customer_id = 1) by 10%
UPDATE book
SET price = price * 1.1
WHERE NOT EXISTS (
    SELECT 1
    FROM loan l
    WHERE l.customer_id = 1
    AND l.return_date IS NULL
    AND l.due_date < CURDATE()
    AND l.id = book.id
);

-- deletes books not currently on loan or overdue for a specific customer (customer_id = 1) from the database
DELETE FROM book
WHERE NOT EXISTS (
    SELECT 1
    FROM loan l
    WHERE l.customer_id = 1
    AND l.return_date IS NULL
    AND l.due_date < CURDATE()
    AND l.id = book.id
);



-- = with correlated subqueries result

-- retrieves books with the maximum year of publishing for each publisher
SELECT b.id, b.title, b.isbn, b.edition, b.year_publishing, b.price, b.publisher_id, b.review
FROM book b
WHERE year_publishing = (
    SELECT MAX(year_publishing)
    FROM book
    WHERE publisher_id = b.publisher_id
);

-- increases the price of books to 10% for the books having the maximum publishing year for each publisher
UPDATE book AS b
JOIN (
    SELECT MAX(year_publishing) AS max_year, publisher_id
    FROM book
    GROUP BY publisher_id
) AS max_years ON b.publisher_id = max_years.publisher_id AND b.year_publishing = max_years.max_year
SET b.price = b.price * 1.1;

-- deletes books with the maximum publishing year for each publisher from the database
DELETE FROM book
WHERE (year_publishing, publisher_id) IN (
    SELECT MAX(year_publishing) AS max_year, publisher_id
    FROM book
    GROUP BY publisher_id
);



-- IN with correlated subqueries result

-- retrieves books authored by 'George Orwell'
SELECT b.id, b.title, b.isbn, b.edition, b.year_publishing, b.price, b.publisher_id, b.review
FROM book b
WHERE publisher_id IN (
    SELECT publisher_id
    FROM book_author
    WHERE author_id = (
        SELECT id
        FROM author
        WHERE name_ = 'George Orwell'
    )
);

-- increases the price of books authored by 'George Orwell' by 10%
UPDATE book AS b
JOIN book_author AS ba ON b.id = ba.book_id
JOIN author AS a ON ba.author_id = a.id
SET b.price = b.price * 1.1
WHERE a.name_ = 'George Orwell';

-- deletes books authored by 'George Orwell' from the database
DELETE FROM book
WHERE id IN (
    SELECT book_id
    FROM book_author
    WHERE author_id = (
        SELECT id
        FROM author
        WHERE name_ = 'George Orwell'
    )
);



-- NOT IN with correlated subqueries result

-- retrieves books not authored by 'George Orwell'
SELECT b.id, b.title, b.isbn, b.edition, b.year_publishing, b.price, b.publisher_id, b.review
FROM book b
WHERE b.publisher_id NOT IN (
    SELECT ba.publisher_id
    FROM book ba
    JOIN book_author ba_a ON ba.id = ba_a.book_id
    JOIN author a ON ba_a.author_id = a.id
    WHERE a.name_ = 'George Orwell'
);

-- increases the price of books not authored by 'George Orwell' by 10%
UPDATE book AS b
SET b.price = b.price * 1.1
WHERE b.publisher_id NOT IN (
    SELECT ba.publisher_id
    FROM book ba
    JOIN book_author ba_a ON ba.id = ba_a.book_id
    JOIN author a ON ba_a.author_id = a.id
    WHERE a.name_ = 'George Orwell'
);

-- deletes books not authored by 'George Orwell' from the database
DELETE FROM book
WHERE publisher_id NOT IN (
    SELECT ba.publisher_id
    FROM book ba
    JOIN book_author ba_a ON ba.id = ba_a.book_id
    JOIN author a ON ba_a.author_id = a.id
    WHERE a.name_ = 'George Orwell'
);



-- EXISTS with correlated subqueries result

-- retrieves books currently on loan and overdue for 'John Doe'
SELECT b.id, b.title, b.isbn, b.edition, b.year_publishing, b.price, b.publisher_id, b.review
FROM book b
WHERE EXISTS (
    SELECT 1
    FROM loan l
    WHERE l.customer_id = 1
    AND l.return_date IS NULL
    AND l.due_date < CURDATE()
    AND l.id = b.id
    AND l.customer_id = (
        SELECT id
        FROM customer
        WHERE name_ = 'John Doe'
    )
);

-- increases the price of books currently on loan and overdue for 'John Doe' by 10%
UPDATE book AS b
JOIN loan AS l ON b.id = l.id
SET b.price = b.price * 1.1
WHERE l.customer_id = (
    SELECT id
    FROM customer
    WHERE name_ = 'John Doe'
)
AND l.return_date IS NULL
AND l.due_date < CURDATE();

-- deletes books currently on loan and overdue for 'John Doe' from the database
DELETE FROM book
WHERE id IN (
    SELECT l.id
    FROM loan AS l
    WHERE l.customer_id = (
        SELECT id
        FROM customer
        WHERE name_ = 'John Doe'
    )
    AND l.return_date IS NULL
    AND l.due_date < CURDATE()
);



-- NOT EXISTS with correlated subqueries result

-- retrieves books not currently on loan or overdue for 'John Doe'
SELECT b.id, b.title, b.isbn, b.edition, b.year_publishing, b.price, b.publisher_id, b.review
FROM book b
WHERE NOT EXISTS (
    SELECT 1
    FROM loan l
    WHERE l.customer_id = 1
    AND l.return_date IS NULL
    AND l.due_date < CURDATE()
    AND l.id = b.id
    AND l.customer_id = (
        SELECT id
        FROM customer
        WHERE name_ = 'John Doe'
    )
);

-- increases the price of books not currently on loan or overdue for 'John Doe' by 10%
UPDATE book AS b
SET price = price * 1.1
WHERE NOT EXISTS (
    SELECT 1
    FROM loan l
    WHERE l.customer_id = 1
    AND l.return_date IS NULL
    AND l.due_date < CURDATE()
    AND l.id = b.id
    AND l.customer_id = (
        SELECT id
        FROM customer
        WHERE name_ = 'John Doe'
    )
);

-- deletes books not currently on loan or overdue for 'John Doe' from the database
DELETE FROM book
WHERE id NOT IN (
    SELECT l.id
    FROM loan AS l
    WHERE l.customer_id = (
        SELECT id
        FROM customer
        WHERE name_ = 'John Doe'
    )
    AND l.return_date IS NULL
    AND l.due_date < CURDATE()
);



-- UNION
-- combines American authors and New York publishers, categorizes, and sorts
SELECT name_
FROM (
    SELECT name_, 'author' AS category
    FROM author
    WHERE nationality = 'American'
    UNION
    SELECT name_, 'publisher' AS category
    FROM publisher
    WHERE address LIKE '%New York%'
) AS combined
ORDER BY name_;



-- UNION ALL
-- retrieve books before 2000 from New York publishers, combine with post-2000 books from other publishers
SELECT title
FROM (
    SELECT title, 'pre_2000' AS era
    FROM book
    WHERE year_publishing < 2000
    AND publisher_id IN (
        SELECT id
        FROM publisher
        WHERE address LIKE '%New York%'
    )
    UNION ALL
    SELECT title, 'post_2000' AS era
    FROM book
    WHERE year_publishing >= 2000
    AND publisher_id IN (
        SELECT id
        FROM publisher
        WHERE address NOT LIKE '%New York%'
    )
) AS combined
ORDER BY era, title;



-- EXCEPT
-- authors not published in London, excluding British publishers
SELECT a.name_
FROM author a
WHERE a.id IN (
    SELECT ba.author_id
    FROM book_author ba
    JOIN book b ON ba.book_id = b.id
    WHERE b.publisher_id NOT IN (
        SELECT id
        FROM publisher
        WHERE address LIKE '%London%'
    )
)
EXCEPT
SELECT p.name_
FROM publisher p
WHERE p.id IN (
    SELECT b.publisher_id
    FROM book b
    JOIN book_author ba ON b.id = ba.book_id
    JOIN author a ON ba.author_id = a.id
    WHERE a.nationality = 'British'
);



-- INTERSECT
-- authors published in London intersected with British publishers
SELECT a.name_
FROM author a
WHERE a.id IN (
    SELECT ba.author_id
    FROM book_author ba
    JOIN book b ON ba.book_id = b.id
    WHERE b.publisher_id IN (
        SELECT id
        FROM publisher
        WHERE address LIKE '%London%'
    )
)
INTERSECT
SELECT p.name_
FROM publisher p
WHERE p.id IN (
    SELECT b.publisher_id
    FROM book b
    JOIN book_author ba ON b.id = ba.book_id
    JOIN author a ON ba.author_id = a.id
    WHERE a.nationality = 'British'
);






