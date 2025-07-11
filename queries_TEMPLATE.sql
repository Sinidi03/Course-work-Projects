-- Student Number(s):	
-- Student Name(s):		

USE name_of_your_database;

/*	Query 1 – Child-Friendly Sessions (2 marks)
	Write a query that selects the movie name, session time and ticket cost of all upcoming sessions (i.e. session time in the future) 
	that have a duration of up to 90 minutes and a classification rating of “G” or “PG”.  Order the results by session time.
*/

-- Write Query 1 here





/*	Query 2 – Best Rated Movies (2 marks)
	Write a query that selects the movie ID number, movie name, blurb, number of reviews, 
	and average star rating (rounded to 1 decimal place) of the top three movies (those with the highest average ratings).
*/

-- Write Query 2 here





/*	Query 3 – Formatted Movie Details (2 marks)
	Write a query that selects three columns of concatenated information about movies, as pictured in the brief.  
	Order the results by the movie duration in descending order.
*/

-- Write Query 3 here





/*	Query 4 – Underage Ticket Sales (3 marks)
	Write a query that that selects the full name (by concatenating their first name and last name) and date of birth of customers, 
	as well as the movie name and minimum age (of the movie’s rating) of any instances where a customer has purchased a ticket to 
	an upcoming session screening a movie that they will be too young to watch.  Calculate the customer’s age at the time of the session
	when determining if they will be too young to watch the movie.  Eliminate any duplicates from the results. 
*/

-- Write Query 4 here





/*	Query 5 – Verified Reviews (3 marks)
	Write a query that selects the review text, star rating, review date (formatted as pictured below), customer first name and customer age
	of any reviews where the customer who wrote the review has purchased a ticket for a session screening the movie that the review was about.
	Only include reviews that were written after the time of the session that the customer purchased a ticket for.
*/

-- Write Query 5 here





/*	Query 6 – Movies Per Genre (3 marks)
	Write a query that selects the number of movies associated with each genre, including a comma-separated list of the movie names, 
	concatenated into a single column formatted exactly as pictured in the brief.  Genres with no movies associated with them should
	also be handled as pictured in the brief.  Order the results by the number of movies in descending order.
*/

-- Write Query 6 here





/*	Query 7 – Invalid Seat Numbers (4 marks)
	Write a query that identifies tickets for upcoming sessions that have invalid seat numbers, based upon the number of rows and 
	seats per row of the cinema and the seat number of the ticket.  e.g. A ticket with a seat number of “F12” would not be valid
	for a session in a cinema that has fewer than 6 rows or fewer than 12 seats per row.  The query should select the session ID and time,
	cinema name, number of rows and seats per row, ticket ID and seat number.  Order the results by session time.
*/

-- Write Query 7 here





/*	Query 8 – Session Statistics (4 marks)
	Write a query that selects the following information about each session:
	•	Movie name, session time, and cinema and cinema type name (concatenated as pictured in the brief).
	•	Number of tickets sold out of the capacity of the cinema (concatenated as pictured in the brief).
	•	Percentage of filled seats (rounded to the nearest whole number).
	•	Ticket revenue of the session (total cost of all tickets sold for the session).

	Ensure that the total revenue is correct even if no tickets have been sold to the session.
	Order the results by the number of tickets sold, in descending order.
*/

-- Write Query 8 here





/*	Query 9 – Customer Statistics (4 marks)
	Write a query that that selects the customer ID and name of customers concatenated into “first name and last initial” format (e.g. “John S.”), 
	as well as how many tickets they have purchased, how much they have spent on tickets, how many reviews they have written, 
	and the date of the first session they purchased a ticket to.  

	Be sure to include all customers, even if they have not written any reviews or purchased any tickets.  
	Order the results by the number of tickets purchased, in descending order.

*/

-- Write Query 9 here




