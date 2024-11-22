CREATE TABLE users (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    passwordHash BINARY(32) NOT NULL,
    userRole ENUM("member", "librarian", "admin")
);

CREATE TABLE authors (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL DEFAULT "Unknown",
    lastName VARCHAR(50) NOT NULL DEFAULT "Unknown",
    dateOfBirth Date
);

CREATE TABLE editors (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL 
);

CREATE TABLE categories (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    type ENUM("category", "genre")
);

CREATE TABLE book_categories (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    bookId INT NOT NULL,
    categoryId INT NOT NULL,
    FOREIGN KEY (bookId) REFERENCES books,
    FOREIGN KEY (categoryId) REFERENCES categories
) ;

CREATE TABLE authored_by (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    authorId INT NOT NULL,
    bookId INT NOT NULL,
    FOREIGN KEY (authorId) REFERENCES authors,
    FOREIGN KEY (bookId) REFERENCES books
);

CREATE TABLE languages (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) UNIQUE NOT NULL,
    code CHAR(2) UNIQUE NOT NULL /*ISO-639-1 Language codes*/
);

CREATE TABLE books (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	isbn VARCHAR(14) NOT NULL UNIQUE,
    title VARCHAR(100) NOT NULL, 
    pubYear date,
    numAvailableCopies INT UNSIGNED NOT NULL,
    NbrPages INT UNSIGNED,
    languageId INT,
    editorId INT,
    FOREIGN KEY (languageId) REFERENCES languages,
    FOREIGN KEY (editorId) REFERENCES editors
);

CREATE TABLE borrowings (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dateBorrowed DATE NOT NULL,
    dateIntendedReturn DATE NOT NULL,
    dateActualReturn DATE,
    status ENUM("not returned", "returned"),
    clientId INT NOT NULL,
    librarianId INT NOT NULL, /*references the librarian responsible*/
    FOREIGN KEY (clientId) REFERENCES users,
    FOREIGN KEY (librarianId) REFERENCES users
);