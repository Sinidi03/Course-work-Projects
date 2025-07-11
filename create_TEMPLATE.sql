-- Student Number(s):  10675878, 10673683
-- Student Name(s):    S.M. Sandali Chamathka De Silva, Dona Sinidi Yashara Balasooriya

/*	Database Creation & Population Script (6 marks)
	Write a script to create the database you designed in Task 1 (incorporating any changes you have made since then).  
	Give your columns the same data types, properties and constraints specified in your data dictionary, and name your tables and columns consistently.  
	Include any suitable default values and any necessary/appropriate CHECK or UNIQUE constraints.

	Make sure this script can be run multiple times without resulting in any errors (hint: drop the database if it exists before trying to create it).
	Adapt the code at the start of the “company.sql” file (Module 5) to implement this.  

	See the brief for further information. 
*/

-- Write your creation script here

IF DB_ID('MovieDB') IS NOT NULL             
	BEGIN
		PRINT 'Database exists - dropping.';
		
		USE master;		
		ALTER DATABASE MovieDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		
		DROP DATABASE MovieDB;
	END

GO

PRINT 'Creating database.';

CREATE DATABASE MovieDB;

GO

USE MovieDB;

GO

CREATE TABLE rating (
    RatingId CHAR(4) NOT NULL PRIMARY KEY,
    RatingName VARCHAR(20) NOT NULL UNIQUE,
    MinimumAge INT NOT NULL
);

CREATE TABLE genre (
    GenreId TINYINT NOT NULL PRIMARY KEY IDENTITY(1,1),
    GenreName VARCHAR(25) NOT NULL UNIQUE
);


CREATE TABLE CinemaType (
    CinemaTypeId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    CinemaTypeName VARCHAR(20) NOT NULL UNIQUE
);


CREATE TABLE cinema (
    CinemaId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    CinemaName VARCHAR(15) NOT NULL UNIQUE,
    NoOfRows INT NOT NULL,
    SeatsPerRow INT NOT NULL,
    CinemaTypeId INT NOT NULL,
    FOREIGN KEY (CinemaTypeId) REFERENCES CinemaType(CinemaTypeId)
);

CREATE TABLE movie (
    MovieId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    MovieName VARCHAR(50) NOT NULL UNIQUE,
    ReleaseDate DATE NOT NULL UNIQUE,
    Duration INT NOT NULL,
    Blurb VARCHAR(200) NOT NULL,
    RatingId CHAR(4) NULL,
    FOREIGN KEY (RatingId) REFERENCES rating(RatingId),
    CONSTRAINT MovieName_ReleaseDate_UK UNIQUE(MovieName, ReleaseDate)
);

CREATE TABLE session (
    SessionId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Date_Time DATETIME NOT NULL,
    TicketCost SMALLMONEY NOT NULL,
    MovieId INT NULL,
    CinemaId INT NULL,
    FOREIGN KEY (MovieId) REFERENCES movie(MovieId),
    FOREIGN KEY (CinemaId) REFERENCES cinema(CinemaId)
);

CREATE TABLE movie_genre (
    GenreId TINYINT NOT NULL,
    MovieId INT NOT NULL,
    PRIMARY KEY (GenreId, MovieId),
    FOREIGN KEY (GenreId) REFERENCES genre(GenreId),
    FOREIGN KEY (MovieId) REFERENCES movie(MovieId)
);

CREATE TABLE customer (
    CustomerId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Email VARCHAR(30) NOT NULL UNIQUE,
    PasswordHash VARCHAR(100) NOT NULL,
    FirstName VARCHAR(15) NOT NULL,
    LastName VARCHAR(15) NOT NULL,
    DOB DATETIME NOT NULL CHECK (DOB <= '2013-01-01'),
    ReferrerId INT NULL,
    FOREIGN KEY (ReferrerId) REFERENCES customer(CustomerId),
    CONSTRAINT CHK_Customer_Referrer CHECK (CustomerId <> ReferrerId)
);

CREATE TABLE ticket (
    TicketId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    SeatNumber CHAR(3) NOT NULL,
    SessionId INT NULL,
    CustomerId INT NULL,
    FOREIGN KEY (SessionId) REFERENCES session(SessionId),
    FOREIGN KEY (CustomerId) REFERENCES customer(CustomerId),
    CONSTRAINT UQ_Seat_Session UNIQUE (SeatNumber, SessionId),
    CONSTRAINT CHK_Seat_Format CHECK (SeatNumber LIKE '[A-Z][0-9][0-9]')
);

CREATE TABLE review (
    ReviewId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    ReviewText VARCHAR(200) NOT NULL,
    StarRate DECIMAL(2,1) NOT NULL,
    ReviewDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CustomerId INT NOT NULL,
    MovieId INT NOT NULL,
    FOREIGN KEY (CustomerId) REFERENCES customer(CustomerId),
    FOREIGN KEY (MovieId) REFERENCES movie(MovieId)
);

/*	Database Population Statements
	Following the SQL statements to create your database and its tables, you must include statements to populate the database with sufficient test data.
	You are only required to populate the database with enough data to make sure that all views and queries return meaningful results.
	
	You can start working on your views and queries and write INSERT statements as needed for testing as you go.
	The final create.sql should be able to create your database and populate it with enough data to make sure that all views and queries return meaningful results.

	Data has been provided for some of the tables.
	Adapt the INSERT statements as needed, and write your own INSERT statements for the remaining tables.
*/


/*	The following statement inserts the details of 5 classification ratings into a table named "rating".
    It specifies values for columns named "rating", "rating_name" and "min_age".
	If required, change the table and column names to match those in your database.
	You may use NULL instead of 0 for the first three classifications if preferred, but will need to account for this in certain queries if so.
*/

INSERT INTO rating (RatingId, RatingName,MinimumAge)
VALUES ('G',  'General', 0),
       ('PG', 'Parental Guidance', 0),
       ('M',  'Mature', 0),
       ('MA', 'Mature Audiences', 15),
       ('R',  'Restricted', 18);



/*	The following statement inserts the details of 10 genres into a table named "genre".
    It specifies values for a column named "genre_name", and it is assumed that the primary key column is an auto-incrementing integer.
	If required, change the table and column names to match those in your database.
*/

INSERT INTO genre (GenreName)
VALUES ('Action'),     -- Genre 1
       ('Adventure'),  -- Genre 2
       ('Animation'),  -- Genre 3
       ('Comedy'),     -- Genre 4
       ('Crime'),      -- Genre 5
       ('Drama'),      -- Genre 6
       ('Fantasy'),    -- Genre 7
       ('Horror'),     -- Genre 8
       ('Romance'),    -- Genre 9
       ('Sci-Fi');     -- Genre 10



/*	The following statement inserts the details of 3 cinema types into a table named "cinema_type".
    It specifies values for a column named "cinema_type_name", and it is assumed that the primary key column is an auto-incrementing integer.
	If required, change the table and column names to match those in your database.
*/

INSERT INTO CinemaType (CinemaTypeName)
VALUES ('Budget'), 
	   ('Standard'), 
	   ('Gold Class');


-- Write your INSERT statements for the remaining tables here
INSERT INTO cinema (CinemaName, NoOfRows, SeatsPerRow, CinemaTypeId)
VALUES
('Cinema One', 12, 18, 1),     
('Cinema Two', 15, 20, 2),     
('Cinema Luxe', 8, 10, 3),     
('Cinema City', 16, 22, 2),    
('Cinema Central', 20, 25, 1);

INSERT INTO movie (MovieName, ReleaseDate, Duration, Blurb, RatingId)
VALUES 
('Casablanca', '1942-11-26', 102, 'A classic romance in WWII Morocco', 'PG'),
('Dune: Part Two', '2024-03-01',88, 'Epic sci-fi saga continues', 'M'),
('Bad Boys for Life', '2020-01-17', 124, 'Miami detectives on one last case', 'MA'),
('Mean Girls', '2024-01-12', 112, 'High school drama remake', 'PG'),
('Citizen Kane', '1941-05-01', 119, 'The rise and fall of Charles Foster Kane', 'PG'),
('The Godfather', '1972-03-24', 175, 'Mafia family struggles for power', 'MA'),
('Barbie', '2023-07-21', 114, 'A doll''s journey in the real world', 'PG'),
('Spider-Man: No Way Home', '2021-12-17', 148 ,'Multiverse adventure for Spider-Man', 'M'),
('Oppenheimer', '2023-07-22', 180, 'The story of the atomic bomb', 'MA'),
('Inside Out', '2015-06-19', 80, 'Emotions inside a young girl''s mind', 'G'),
('Jurassic World Rebirth', '2025-07-11', 75, 'An expedition risks everything to extract DNA from prehistoric creatures for a medical breakthrough.', 'PG'),
('Mission: Impossible - The Final Reckoning', '2025-06-27', 169, 'Ethan Hunt faces his most dangerous mission yet in the final chapter.', 'R'),
('28 Years Later', '2025-06-20', 118, 'A new chapter in the post-apocalyptic saga, set 28 years after the outbreak.', 'R'),
('Avatar: Fire and Ash', '2025-12-19', 82, 'Jake Sully and Neytiri return to defend Pandora from a new threat.', 'PG'),
('Thunderbolts', '2025-05-02', 127, 'A team of antiheroes and reformed villains are assembled for a high-stakes mission in the Marvel universe.', 'PG'),
('Fantastic Four: The First Steps', '2025-07-25', 140, 'Marvel’s first family embarks on their origin adventure in the MCU.', 'PG');

INSERT INTO session (Date_Time, TicketCost, MovieId, CinemaId)
VALUES
('2025-05-01 19:00:00', 15.00, 2, 1),
('2025-05-02 17:30:00', 12.50, 3, 2),
('2025-05-03 20:15:00', 10.00, 1, 3),
('2025-05-04 18:45:00', 13.00, 4, 4),
('2025-05-05 16:00:00', 11.00, 5, 5),
('2025-05-06 21:00:00', 16.00, 6, 1),
('2025-05-07 15:30:00', 14.00, 7, 2),
('2025-05-08 18:00:00', 13.50, 8, 3),
('2025-05-09 20:00:00', 17.00, 9, 4),
('2025-05-10 14:00:00', 9.00, 10, 5),
('2025-05-11 13:00:00', 12.00, 11, 2),
('2025-05-12 16:30:00', 14.50, 12, 4),
('2025-05-13 19:45:00', 16.00, 13, 2),
('2025-05-14 21:00:00', 15.00, 12, 3),
('2025-05-15 18:15:00', 13.50, 9, 4),
('2025-05-16 17:00:00', 11.00, 10, 5);

INSERT INTO movie_genre (GenreId, MovieId)
VALUES
(6, 1), 
(9, 1),
(2, 2), 
(10, 2),
(1, 3),  
(5, 3),
(4, 4), 
(6, 4),
(6, 5),
(5, 6), 
(6, 6),
(4, 7), 
(7, 7),
(1, 8), 
(10, 8),
(6, 9),
(2, 10),
(6, 10);


INSERT INTO customer (Email, PasswordHash, FirstName, LastName, DOB, ReferrerId)
VALUES
('john.doe@gmail.com', '$argon2id$v=19$m=65536,t=4,p=8$abcdef1234567890$G7yF8hD2kUe2G6fE1Wsx5TkQKbB2fP7GbI4WxLgphHM=', 'John', 'Doe', '1990-05-15', NULL),
('jane.smith@yahoo.com', '$argon2id$v=19$m=65536,t=4,p=8$123456abcdef7890$R9mKz8XyW5rMndC6y6Z2joPT3A9WjwWLk6c1f0uSgjY=', 'Jane', 'Smith', '1995-08-20', 1),
('alice.jones@icloud.com', '$argon2id$v=19$m=65536,t=4,p=8$54321abcdef6789$A1J6vZ1u0eK1Wx5Z2UlIcJl5hvV7ZX36A2F1z9o8Zz8=', 'Alice', 'Jones', '2000-11-10', 1),
('bob.white@gmail.com', '$argon2id$v=19$m=65536,t=4,p=8$1a2b3c4d5e6f7g8h$5Y7kpQf24lP8m9Y3zD0q0Z2J9f9yLx0lB21XGbDNOhQ=', 'Bob', 'White', '2002-03-25', NULL),
('charlie.brown@yahoo.com', '$argon2id$v=19$m=65536,t=4,p=8$abcde12345fgh6789$7Oe24jpXZq8XBtV9r7I1hB+98Op3dr9B8N1Sw1VydWs=', 'Charlie', 'Brown', '2003-07-30', 3),
('emily.davis@icloud.com', '$argon2id$v=19$m=65536,t=4,p=8$23456789abcdef$ALvW0ZcS18pPzmKPJy7Kzk4U+1F7dDsBz2sh4A4ZKH4Q=', 'Emily', 'Davis', '2004-12-12', NULL),
('david.miller@gmail.com', '$argon2id$v=19$m=65536,t=4,p=8$abcdefghijklmno$1Qfz+XJQj92YkMh0rXeofFZGeQ7Z8vZlAxGsZwGVvK8=', 'David', 'Miller', '1998-02-18', 4),
('lucy.green@gmail.com', '$argon2id$v=19$m=65536,t=4,p=8$12345abcdef$3zSjrMkwklRgVbxyZ0bSKu28h8l8OqBQ9k3LZQeq3uo=', 'Lucy', 'Green', '2001-04-05', 5),
('natalie.white@gmail.com', '$argon2id$v=19$m=65536,t=4,p=8$9876543210abc$8qVpF1Cws7fpYF8bmzIrQgV8A9BXbItD7+vq52wGV5M=', 'Natalie', 'White', '2002-06-13', 6),
('michael.black@gmail.com', '$argon2id$v=19$m=65536,t=4,p=8$1234abc567$h8r+0g9Hj13VfFzCbbGxLzFYFe+jg5xo5oQ6dqRIpKo=', 'Michael', 'Black', '2003-09-01', NULL),
('zoe.kid1@gmail.com', '$argon2id$v=19$m=65536,t=2,p=1$wJ95K6Eh5ewRKuE4oMi7RA$4UB+LVqNVZ19bpWgV/l84c6LR1t1ru7YP6sNJvsvReA', 'Zoe', 'Kidman', '2012-05-10',3),
('max.junior@gmail.com', '$argon2id$v=19$m=65536,t=2,p=1$UzYc1wLVo8jGpi/dtGcF2g$5hIkFAbAVZx7zC3UcrxW5gWTQ7ylV+tLZK0JP00a+/0', 'Max', 'Junior', '2010-10-25',2),
('ruby.young@gmail.com', '$argon2id$v=19$m=65536,t=2,p=1$s47RU+ImRs4F+0+NzM7TJg$twCeO2HMF6R2avkSDwMF+zTe0BPaS39+Q3D1H+hJgNU', 'Ruby', 'Young', '2009-08-15',NULL);

INSERT INTO ticket (SeatNumber, SessionId, CustomerId)
VALUES 
('M03', 6, 1),
('B15', 5, 2),
('H08', 9, 3),
('K20', 4, 8),
('Z05', 5, 2),
('D07', 1, 6),
('F14', 7, 7),
('J22', 4, 8),
('C03', 9, 3),
('M24', 2, 11),
('L10', 13, 12),
('K12',3,5);

INSERT INTO review (ReviewText, StarRate, CustomerId, MovieId)
VALUES
('Stunning visuals and story', 4.6,1, 2),
('Hilarious remake', 4.5, 2, 4),
('Timeless classic', 4.8, 3, 1),
('Action-packed fun', 4.5,4, 3),
('Masterpiece of cinema', 3.2,5, 5),
('Brilliant acting and direction', 3.5,6, 1),
('Colorful and imaginative', 4.5, 7, 7),
('Best superhero movie yet', 4.2, 8, 8),
('Intense and thought-provoking', 3.5, 9, 9),
('Creative and emotional', 5.0, 10, 10),
('A timeless masterpiece. The romance and drama are unforgettable.', 5, 1, 1),
('The cinematography in Casablanca is stunning for its era.', 4, 2, 1),
('Dune: Part Two is a visual feast with an epic story.', 5, 3, 2),
('Incredible world-building and special effects. Can not wait for more!', 5, 4, 2);

