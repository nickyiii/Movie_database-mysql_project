# Movie_database-mysql_project
This is my first mysql project of database based on Movies
Description:
This repository houses a comprehensive movie database designed to store and manage information about a vast collection of movies. Whether you're a movie enthusiast, developer, or data analyst, this database provides valuable insights into the world of cinema.

Key Features:

Extensive Movie Details: Includes information such as title, release year, genre, director, and cast.
User Ratings and Reviews: Allows users to rate movies and write reviews, contributing to a dynamic user-driven community.
Genre Classification: Movies are categorized into genres for easy navigation and exploration.
Director and Actor Relationships: Establishes relationships between directors, actors, and the movies they are involved in.
Search and Filtering: Enables users to search for movies based on various criteria and apply filters.
Statistical Insights: Provides statistical analyses, such as average ratings, most popular genres, and top-rated movies.

Approach Use :

Designing a movie database involves careful consideration of the various entities, relationships, and attributes related to movies, actors, directors, genres, and more. Here are some insights to guide you in solving a database based on movies:


Start by identifying the key entities in your movie database. Common entities include Movie, Actor, Director, Genre, and Review.
Define Relationships:

Establish relationships between entities. For example, a Movie is directed by a Director, features multiple Actors, belongs to one or more Genres, and can have multiple Reviews.

Attributes and Data Types:
Determine the attributes for each entity and their respective data types. For instance, a Movie entity may have attributes like Title, ReleaseYear, and Rating. Ensure appropriate data types such as VARCHAR, INT, DATE, etc.

Use Primary and Foreign Keys:
Define primary keys for unique identification of records in each table. Use foreign keys to establish relationships between tables.


Basic Retrieval Queries: Start with simple SELECT queries to retrieve data from single tables. For example:

SELECT * FROM movies;
SELECT * FROM actors;

Joins: Utilize JOIN operations to retrieve data from multiple related tables. For example:

SELECT m.mov_title, a.act_name
FROM movie_actor ma
JOIN movie m ON ma.mov_id = m.mov_id
JOIN actor a ON ma.act_id = a.act_id;


Subqueries: Use subqueries to perform complex operations within SELECT, WHERE, or HAVING clauses. For example:

SELECT mov_title
FROM movie
WHERE mov_id IN (SELECT mov_id FROM rating WHERE rating > 8);


Aggregation: Utilize aggregate functions like SUM, COUNT, AVG, etc., to perform calculations on groups of data. For example:

SELECT genre, COUNT(*) AS num_movies
FROM movie_genre
GROUP BY genre;

Filtering and Sorting: Apply WHERE clause for filtering and ORDER BY clause for sorting the results. For example:

SELECT * FROM movies WHERE year > 2010 ORDER BY year DESC;

