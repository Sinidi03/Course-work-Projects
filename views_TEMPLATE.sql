-- Student Number(s):  10675878, 10673683
-- Student Name(s):    S.M. Sandali Chamathka De Silva, Dona Sinidi Yashara Balasooriya 

USE movieDB;
GO

/*	Movie View (2 marks)
	Create a view that selects the following details of all movies (use column aliases as appropriate):
	•	All of the columns from the movie table except the blurb
	•	The movie’s classification rating and minimum age
	•	A column containing the names of the genres associated with the movie, as shown in the brief
*/

USE movieDB;
GO

CREATE VIEW MovieView AS
SELECT 
    m.MovieId,
    m.MovieName,
    m.ReleaseDate,
    m.Duration,
    m.RatingId,
    r.RatingName AS Classification,
    r.MinimumAge AS Minimum_Age,
    STRING_AGG(g.GenreName, ', ') AS Genres
FROM movie m
LEFT OUTER JOIN rating r ON m.RatingId = r.RatingId
INNER JOIN movie_genre mg ON m.MovieId = mg.MovieId
INNER JOIN genre g ON mg.GenreId = g.GenreId
GROUP BY 
    m.MovieId,
    m.MovieName,
    m.ReleaseDate,
    m.Duration,
    m.RatingId,
    r.RatingName,
    r.MinimumAge;
GO


/*	Session View (3 marks)
	Create a view that selects the following details of all sessions (use column aliases as appropriate):
	•	All of the columns from the session table
	•	The name and classification rating of the movie being shown
	•	The cinema name, capacity and cinema type name of the cinema that the session is in
			• Determine the capacity by multiplying the number of rows by the seats per row
	•	The number of tickets sold for the session (this should be 0 if no tickets have been sold)

*/
CREATE VIEW SessionView AS
SELECT 
    s.SessionId,
    s.Date_Time,
    s.TicketCost,
    s.MovieId,
    m.MovieName,
    r.RatingName AS Classification,
    s.CinemaId,
    c.CinemaName,
    ct.CinemaTypeName,
    (CAST(c.NoOfRows AS int) * c.SeatsPerRow) AS Capacity,
    ISNULL(ticket_count.NumTickets, 0) AS TicketsSold

FROM 
    session s

INNER JOIN movie m ON s.MovieId = m.MovieId
LEFT OUTER JOIN rating r ON m.RatingId = r.RatingId

INNER JOIN cinema c ON s.CinemaId = c.CinemaId
INNER JOIN CinemaType ct ON c.CinemaTypeId = ct.CinemaTypeId

LEFT OUTER JOIN (
    SELECT SessionId, COUNT(*) AS NumTickets
    FROM ticket
    GROUP BY SessionId
) AS ticket_count ON s.SessionId = ticket_count.SessionId;



--	If you wish to create additional views to use in the queries which follow, include them in this file.


