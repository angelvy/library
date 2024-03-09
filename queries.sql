-- виводимо книги по роках у жанрі роман
SELECT b.year_publishing, COUNT(*) AS books_count
FROM book b
JOIN book_genre bg ON b.id = bg.book_id
JOIN genre g ON bg.genre_id = g.id
WHERE g.name_ = 'Romance'
GROUP BY b.year_publishing;

-- виводимо книги з рейтингом більше за 4
SELECT a.id, a.name_, b.review
FROM author a
JOIN book_author ba ON a.id = ba.author_id
JOIN book b ON ba.book_id = b.id
WHERE b.review IS NOT NULL
GROUP BY a.id, a.name_, b.review
HAVING AVG(b.review) > 4;