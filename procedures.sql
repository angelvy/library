-- The procedure `GetBookInfo` retrieves the title and price of a book specified by the `book_id` parameter.
-- The title is stored in the `book_title` output parameter, and the price is stored in the `book_price` output parameter
DELIMITER //

CREATE PROCEDURE get_book_info_sproc(
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

CREATE PROCEDURE get_update_book_price_sproc(
    IN book_id INT,
    IN new_price DOUBLE
)
BEGIN
    UPDATE book SET price = new_price WHERE id = book_id;
END //

DELIMITER ;


-- The `ProcessLoanReturnAndUpdateBookPrice_` procedure manages loan returns and book price updates.
-- It first retrieves loan details and checks if the return is overdue. Using a transaction, it updates the return date in the `loan`
-- table and inserts a log entry if none exists for the current date. If the loan isn't overdue and lacks a log entry for the date,
-- it reduces the book price by 5%. The transaction is then committed or rolled back based on the overdue status.
DELIMITER //

CREATE PROCEDURE get_process_loan_return_and_update_book_price_sproc(
    IN loan_id INT,
    IN return_date DATE
)
BEGIN
    DECLARE loan_due_date DATE;
    DECLARE book_id INT;
    DECLARE existing_log_count INT;
    DECLARE overdue BOOLEAN DEFAULT FALSE;

    SELECT due_date, book_id INTO loan_due_date, book_id FROM loan WHERE id = loan_id;

    IF return_date > loan_due_date THEN
        SET overdue = TRUE;
    END IF;

    START TRANSACTION;

    UPDATE loan SET return_date = return_date WHERE id = loan_id;

    SELECT COUNT(1) INTO existing_log_count FROM loan_log WHERE loan_id = loan_id AND DATE(processed_date) = CURDATE();

    IF existing_log_count = 0 THEN
        INSERT INTO loan_log (loan_id, processed_date) VALUES (loan_id, NOW());
    END IF;

    IF NOT overdue THEN
        UPDATE book SET price = price * 0.95 WHERE id = book_id;
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END //

DELIMITER ;