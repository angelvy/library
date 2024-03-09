CREATE DATABASE library;
USE library;
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
    FOREIGN KEY (publisher_id) REFERENCES publisher(id)
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
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);

CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(id),
    FOREIGN KEY (author_id) REFERENCES author(id)
);

CREATE TABLE book_genre (
    book_id INT,
    genre_id INT,
    PRIMARY KEY (book_id, genre_id),
    FOREIGN KEY (book_id) REFERENCES book(id),
    FOREIGN KEY (genre_id) REFERENCES genre(id)
);
