-- The procedure `GetBookInfo` retrieves the title and price of a book specified by the `book_id` parameter.
-- The title is stored in the `book_title` output parameter, and the price is stored in the `book_price` output parameter
DELIMITER //

CREATE PROCEDURE GetBookInfo(
    IN book_id INT,
    OUT book_title VARCHAR(255),
    OUT book_price DOUBLE
)
BEGIN
    SELECT title, price INTO book_title, book_price FROM book WHERE id = book_id;
END //

DELIMITER ;


-- The procedure `UpdateBookPrice` updates the price of a book identified by the `book_id` parameter to the value specified by the `new_price` parameter
DELIMITER //

CREATE PROCEDURE UpdateBookPrice(
    INOUT book_id INT,
    IN new_price DOUBLE
)
BEGIN
    UPDATE book SET price = new_price WHERE id = book_id;
END //

DELIMITER ;


-- The procedure `ProcessLoanReturn` updates the return date of a loan specified by `loan_id`.
-- It checks if the loan is overdue by comparing return and due dates.
-- If overdue, it rolls back the transaction; otherwise, it commits the changes
DELIMITER //

CREATE PROCEDURE ProcessLoanReturn(
    IN loan_id INT,
    IN return_date DATE
)
BEGIN
    DECLARE loan_due_date DATE;
    DECLARE loan_returned_date DATE;
    DECLARE overdue BOOLEAN;

    SELECT due_date, return_date INTO loan_due_date, loan_returned_date FROM loan WHERE id = loan_id;

    IF loan_returned_date > loan_due_date THEN
        SET overdue = TRUE;
    ELSE
        SET overdue = FALSE;
    END IF;

    START TRANSACTION;

    UPDATE loan SET return_date = return_date WHERE id = loan_id;

    IF overdue THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END //

DELIMITER ;
