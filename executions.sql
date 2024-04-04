-- Call procedure `GetBookInfo` to get information about a book
CALL GetBookInfo(1, @title, @price);
-- Result: Information about the book with id 1 will be retrieved and stored in the @title and @price variables.

CALL GetBookInfo(3, @title, @price);
-- Result: Information about the book with id 3 will be retrieved and stored in the @title and @price variables.

CALL GetBookInfo(5, @title, @price);
-- Result: Information about the book with id 5 will be retrieved and stored in the @title and @price variables.


-- Call procedure `UpdateBookPrice` to update the price of a book
SET @book_id = 2;
CALL GetUpdateBookPrice(@book_id, 12.99);
-- Result: The price of the book with id 2 will be updated to 12.99.

SET @book_id = 4;
CALL GetUpdateBookPrice(@book_id, 14.99);
-- Result: The price of the book with id 4 will be updated to 14.99.

SET @book_id = 8;
CALL GetUpdateBookPrice(@book_id, 15.99);
-- Result: The price of the book with id 8 will be updated to 15.99.


-- Call procedure `ProcessLoanReturn` to process the return of a loan
CALL GetProcessLoanReturnAndUpdateBookPrice(1, '2024-03-28');
-- Result: The return date of the loan with id 1 will be updated to '2024-03-28'. Since it's not overdue, the book price will be reduced by 5%, and the transaction will be committed.

CALL GetProcessLoanReturnAndUpdateBookPrice(3, '2024-01-10');
-- Result: The return date of the loan with id 3 will be updated to '2024-01-10'. Since it's overdue, the transaction will be rolled back.

CALL GetProcessLoanReturnAndUpdateBookPrice(4, '2024-03-15');
-- Result: The return date of the loan with id 4 will be updated to '2024-03-15'. Since it's not overdue, the book price will be reduced by 5%, the transaction will be committed.
