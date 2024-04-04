CREATE TABLE publisher (
    id INT PRIMARY KEY,
    name_ VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(12),
    website VARCHAR(255)
);

CREATE TABLE book (
    id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(255),
    edition VARCHAR(255),
    year_publishing INT NOT NULL,
    price DOUBLE NOT NULL,
    publisher_id INT,
    review DECIMAL(10, 2),
    FOREIGN KEY (publisher_id) REFERENCES publisher(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE author (
    id INT PRIMARY KEY,
    name_ VARCHAR(255) NOT NULL,
    birthday DATE NOT NULL,
    nationality VARCHAR(255),
    biography TEXT
);

CREATE TABLE genre (
    id INT PRIMARY KEY,
    name_ VARCHAR(255) NOT NULL,
    description_ TEXT NOT NULL
);

CREATE TABLE customer (
    id INT PRIMARY KEY,
    name_ VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(12) NOT NULL,
    email VARCHAR(255) NOT NULL,
    pass VARCHAR(128) NOT NULL
);

CREATE TABLE loan (
    id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    loan_date DATE,
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (author_id) REFERENCES author(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE book_genre (
    book_id INT,
    genre_id INT,
    PRIMARY KEY (book_id, genre_id),
    FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genre(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE loan_log (
    loan_id INT NOT NULL,
    processed_date DATE NOT NULL,
    FOREIGN KEY (loan_id) REFERENCES loan(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (loan_id, processed_date)
);


INSERT INTO publisher (id, name_, address, phone, website)
VALUES
    (1, 'HarperCollins', '195 Broadway, New York, NY 10007', '12122077000', 'https://www.harpercollins.com'),
    (2, 'Signet Classic', '375 Hudson St, New York, NY 10014', '18007260600', 'https://www.signetclassic.com'),
    (3, 'Penguin Classics', '375 Hudson St, New York, NY 10014', '18007333000', 'https://www.penguinclassics.com'),
    (4, 'Scribner', '1230 Avenue of the Americas, New York, NY 10020', '12126987000', 'https://www.scribner.com'),
    (5, 'Harcourt Brace Jovanovich', '6277 Sea Harbor Dr, Orlando, FL 32887', '14073452000', 'https://www.harcourt.com'),
    (6, 'Penguin Random House', '123 Main St, New York, NY', '11234567890', 'www.penguinrandomhouse.com'),
    (7, 'Bloomsbury Publishing', '456 Elm St, London, UK', '442012345678', 'www.bloomsbury.com'),
    (8, 'HarperCollins Publishers', '789 Oak St, San Francisco, CA', '19876543210', 'www.harpercollins.com'),
    (9, 'Hachette Livre', '321 Maple St, Paris, France', '33123456789', 'www.hachette.com'),
    (10, 'Vintage Books', '567 Pine St, Seattle, WA', '15678901234', 'www.vintagebooks.com'),
    (11, 'Ballantine Books', '1745 Broadway, New York, NY', '2127829000', 'www.ballantinebooks.com');

INSERT INTO book (id, title, isbn, edition, year_publishing, price, publisher_id, review)
VALUES
    (1, 'To Kill a Mockingbird', '9780061120084', '50th Anniversary Edition', 1960, 9.99, 1, 4.3),
    (2, '1984', '9780451524935', 'Reprint Edition', 1949, 8.99, 2, 4.2),
    (3, 'Pride and Prejudice', '9780141439518', 'Revised Edition', 1813, 7.99, 3, 4.3),
    (4, 'The Great Gatsby', '9780743273565', 'Revised Edition', 1925, 10.99, 4, 3.9),
    (5, 'To the Lighthouse', '9780156907392', 'First Edition', 1927, 11.99, 5, 3.8),
    (6, 'It', '978-1-101-57270-5', 'First', 1986, 15.99, 6, 4.2),
    (7, 'Harry Potter and the Philosopher''s Stone', '978-1-4088-6238-5', 'First', 1997, 12.99, 7, 4.5),
    (8, '1984', '978-0-452-28423-4', 'First', 1949, 9.99, 8, 4.2),
    (9, 'Murder on the Orient Express', '978-0-062-53609-7', 'First', 1934, 8.99, 9, 4.2),
    (10, 'Norwegian Wood', '978-0-099-49409-3', 'First', 1987, 11.99, 10, 4.0),
    (11, 'Mad Honey', '9781234567890', 'First Edition', 2024, 14.99, 11, 4.1);

INSERT INTO author (id, name_, birthday, nationality, biography)
VALUES
    (1, 'Harper Lee', '1926-04-28', 'American', 'American novelist best known for her novel To Kill a Mockingbird.'),
    (2, 'George Orwell', '1903-06-25', 'British', 'English novelist, essayist, journalist, and critic.'),
    (3, 'Jane Austen', '1775-12-16', 'British', 'English novelist known primarily for her six major novels, including Pride and Prejudice.'),
    (4, 'F. Scott Fitzgerald', '1896-09-24', 'American', 'American novelist, essayist, screenwriter, and short-story writer.'),
    (5, 'Virginia Woolf', '1882-01-25', 'British', 'English writer, considered one of the most important modernist 20th-century authors.'),
    (6, 'Stephen King', '1947-09-21', 'American', 'Stephen King is an American author...'),
    (7, 'J.K. Rowling', '1965-07-31', 'British', 'J.K. Rowling is a British author...'),
    (8, 'Agatha Christie', '1890-09-15', 'British', 'Agatha Christie was an English writer...'),
    (9, 'Haruki Murakami', '1949-01-12', 'Japanese', 'Haruki Murakami is a Japanese writer...'),
    (10, 'Jodi Picoult', '1966-05-19', 'American', 'Picoult has published 28 novels, as well as short stories, and has also written several issues of Wonder Woman.'),
    (11, 'Jennifer Finney Boylan', '1958-06-22', 'American', 'Jennifer Finney Boylan born June 22, 1958 is an American author, transgender activist, professor at Barnard College, and a former contributing opinion writer for the New York Times.');

INSERT INTO genre (id, name_, description_)
VALUES
    (1, 'Fiction', 'Literary works of the imagination, typically dealing with adult themes and suitable for a mature audience.'),
    (2, 'Dystopian', 'A subgenre of science fiction that explores social and political structures in a dark, often post-apocalyptic world.'),
    (3, 'Romance', 'A genre of fiction that focuses on love stories and relationships between characters.'),
    (4, 'Modernist', 'A literary movement characterized by a self-conscious break with traditional styles of poetry and prose.'),
    (5, 'Stream of Consciousness', 'A narrative mode that attempts to depict the multitudinous thoughts and feelings that pass through the mind.'),
    (6, 'Horror', 'Books designed to frighten, scare, disgust, or startle their readers by inducing feelings of horror and terror.'),
    (7, 'Mystery', 'Books where a crime or puzzle is solved by a detective, amateur sleuth, or other means.'),
    (8, 'Fantasy', 'Books that often involve magic, mythical creatures, or supernatural elements.'),
    (9, 'Science Fiction', 'Books that speculate on imagined future scientific or technological advances.'),
    (10, 'Literary Fiction', 'Books that focus more on character development and style than on plot.'),
    (11, 'Novel', 'a fictitious prose narrative of book length, typically representing character and action with some degree of realism.');

INSERT INTO customer (id, name_, address, phone, email, pass)
VALUES
    (1, 'John Doe', '123 Main St, Anytown, USA', '15551234567', 'john.doe@gmail.com', 'password123'),
    (2, 'Jane Smith', '456 Oak St, Sometown, USA', '15559876543', 'jane.smith@gmail.com', 'password456'),
    (3, 'Alice Johnson', '789 Elm St, Othertown, USA', '15555555555', 'alice.johnson@gmail.com', 'password789'),
    (4, 'Bob Brown', '101 Pine St, Anothertown, USA', '15551112222', 'bob.brown@gmail.com', 'passwordabc'),
    (5, 'Emma Davis', '202 Cedar St, Yetanothertown, USA', '15552223333', 'emma.davis@gmail.com', 'passwordxyz'),
    (6, 'Michael Smith', '345 Maple St, New York, USA', '15553334444', 'michael.smith@gmail.com', 'password123'),
    (7, 'Emily Johnson', '678 Elm St, Gotham City, USA', '15554445555', 'emily.johnson@gmail.com', 'password456'),
    (8, 'David Jones', '901 Oak St, Metropolis, USA', '15555556666', 'david.jones@gmail.com', 'password789'),
    (9, 'Sarah Wilson', '123 Pine St, Springfield, USA', '15557778888', 'sarah.wilson@gmail.com', 'passwordabc'),
    (10, 'Chris Evans', '456 Cedar St, Smalltown, USA', '15558889999', 'chris.evans@gmail.com', 'passwordxyz'),
    (11, 'Chris Evans', '456 Cedar St, Smalltown, USA', '15558889999', 'chris.evans@gmail.com', 'passwordxyz');

INSERT INTO loan (id, customer_id, loan_date, due_date, return_date)
VALUES
    (1, 1, '2024-03-07', '2024-04-07', NULL),
    (2, 2, '2024-03-06', '2024-04-06', '2024-03-08'),
    (3, 3, '2024-03-05', '2024-04-05', NULL),
    (4, 4, '2024-03-04', '2024-04-04', NULL),
    (5, 5, '2024-03-03', '2024-04-03', NULL),
    (6, 6, '2024-04-07', '2024-05-07', NULL),
    (7, 7, '2024-08-06', '2024-09-06', '2024-09-08'),
    (8, 8, '2024-03-05', '2024-04-05', NULL),
    (9, 9, '2024-07-04', '2024-08-04', NULL),
    (10, 10, '2023-03-03', '2023-04-03', NULL),
    (11, 11, '2022-03-03', '2022-04-03', NULL);

INSERT INTO book_genre (book_id, genre_id)
VALUES
    (1, 3),
    (2, 2),
    (3, 3),
    (4, 3),
    (5, 1),
    (5, 3),
    (6, 6),
    (7, 7),
    (8, 9),
    (9, 7),
    (10, 3),
    (11, 1);

INSERT INTO book_author (book_id, author_id)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 2),
    (9, 8),
    (10, 9),
    (11, 10),
    (11, 11);

INSERT INTO loan_log (loan_id, processed_date)
VALUES
    (1, '2024-04-08'),
    (2, '2024-03-10'),
    (3, '2024-04-06'),
    (4, '2024-03-20'),
    (5, '2024-04-01');