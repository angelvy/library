-- The view "get_rented_books_view" provides information about currently rented books.
-- It displays the title, comma-separated authors, publisher name, release year, loan date in a formatted way,
-- and the number of days until the end of the term.
CREATE VIEW get_rented_books_view AS
    SELECT
        b.title AS title,
        GROUP_CONCAT(a.name_ ORDER BY a.name_ ASC SEPARATOR ', ') AS authors,
        CONCAT(p.name_, ', ', b.year_publishing) AS publisher_and_year,
        MAX(DATE_FORMAT(l.loan_date, '%b, %d %Y')) AS loan_date,
        MAX(DATEDIFF(l.due_date, CURDATE())) AS days_until_end_term
    FROM
        book b
    JOIN
        book_author ba ON b.id = ba.book_id
    JOIN
        author a ON ba.author_id = a.id
    JOIN
        loan l ON b.id = l.book_id
    JOIN
        publisher p ON b.publisher_id = p.id
    WHERE
        l.return_date IS NULL
    GROUP BY
        b.id, b.title, p.name_, b.year_publishing;

-- Indexes are implemented on pertinent columns to enhance search efficiency,
-- including `title` in the `book` table, `name_` in the `author` table, and `return_date` in the `loan` table.
CREATE INDEX idx_book_title ON book (title);
CREATE INDEX idx_author_name ON author (name_);
CREATE INDEX idx_loan_return_date ON loan (return_date);
