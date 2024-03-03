use movie_database
show  mov_year ;
-- 1


select mov_title,mov_year from movie;
select mov_year from movie where mov_title= "American Beauty";
select mov_title from movie where mov_year=1999;
select rev_name from reviewer join mov_title from movie;
 -- 5
select r.rev_name,m.mov_title from reviewer r
join rating rt on r.rev_id=rt.rev_id
join movie m on rt.mov_id=m.mov_id;

-- 6
 select r.rev_name,rt.rev_stars from reviewer r
 join rating rt on r.rev_id=rt.rev_id
 where rt.rev_stars>=7;
 
 
 
 
 
 use movie_database;
 -- 7
 select m.mov_title,rt.num_o_ratings from movie m 
 join rating rt on m.mov_id=rt.mov_id
 where rt.num_o_ratings=0;
 
 select  mov_title from movie where mov_id in
(select mov_id from rating where num_o_ratings=0);

 -- 8
 select mov_title from movie where mov_id in (905, 907, 917);
 

 -- 9
 select mov_title from movie where mov_year in (select mov_year from movie where mov_title="Boogie Nights");
 
 -- 10
 select act_id from actor where act_fname="Woody" and act_lname="Allen";
 
 -- intermediate
 
--  1. Write a query in SQL to list all the information of the actors who played a role in the "Annie Hall";

 select * from actor where act_id in
 ( select act_id from movie_cast where mov_id in (select mov_id from movie where mov_title="Annie Hall"));

--  2. Write a query in SQL to find the name of the director (first and last names) who directed
  #movie that casted a role for "Eyes Wide Shut". (using subquery);

 select dir_fname,dir_lname from director where dir_id in( select dir_id from movie_direction where mov_id in (select mov_id from movie where mov_title="Eyes Wide Shut"));

-- 3 Write a query in SQL to list all the movies which were released in countries other
than the UK.;

SELECT * FROM movie WHERE mov_rel_country <> 'UK';
USE movie_database;
-- 4 Write a query in SQL to find the movie title, year, date of release, director and actor
#forthose movies whose reviewer is unknown.;

Select mov_title,dir_fname,act_fname from movie,director,actor,movie_direction,movie_cast,rating,reviewer
where movie.mov_id=movie_direction.mov_id
and movie_direction.dir_ID=director.dir_id
and movie.mov_id=movie_cast.mov_id
and movie_cast.act_id=actor.act_id
and movie.mov_id=rating.mov_id
and rating.rev_id=reviewer.rev_id
and reviewer.rev_name is null;

Select m.mov_title,m.mov_year,m.mov_dt_rel,d.dir_fname,d.dir_lname,a.act_fname,a.act_lname,r.rev_name from movie m
JOIN movie_direction md ON m.mov_id = md.mov_id
JOIN director d ON md.dir_id=d.dir_id
JOIN  movie_cast mc ON m.mov_id=mc.mov_id
JOIN actor a ON mc.act_id=a.act_id
LEFT JOIN rating rt ON m.mov_id=rt.mov_id
LEFT JOIN reviewer r ON rt.rev_id=r.rev_id
WHERE r.rev_name is null ;

select m.mov_title,mov_year,mov_dt_rel,dir.dir_fname,dir_lname,act.act_fname,act_lname
from movie m
join movie_direction md on m.mov_id=md.mov_id
join director dir on dir.dir_id = md.dir_id
join rating rat on m.mov_id = rat.mov_id
join reviewer rev on rat.rev_id = rev.rev_id
join movie_cast mc on m.mov_id = mc.mov_id
join actor act on mc.act_id = act.act_id
where rev.rev_name is null;

#5 Write a query in SQL to find the titles of all movies directed by the director whose
#first and last name are Woddy Allen.;

select mov_title from movie where mov_id in
 (select mov_id from movie_direction where dir_id in(select dir_id from director where dir_fname= "Woody" and dir_lname= "Allen"));
 
 #6 Write a query in SQL to find all the years which produced at least one movie and that 
#received a rating of more than 3 stars. Show the results in increasing order.

SELECT DISTINCT mov_year FROM movie WHERE mov_id IN (
SELECT mov_id FROM rating WHERE rev_stars>3) ORDER BY mov_year;

 select mov_year,mov_title from  movie  where mov_id in (select mov_id from rating where rev_stars>3) order by mov_year;

-- 7 7. Write a query in SQL to find the titles of all movies that have no ratings.
 select mov_title from movie where mov_id in(select mov_id from rating where num_o_ratings=0);
 
 
 use movie_database;
 -- 8. Write a query in SQL to find the names of all reviewers who have ratings with a NULL value.
 
 select rev_name from reviewer where rev_id in (select rev_id from rating where num_o_ratings is null);
 
 SELECT r.rev_name
FROM Reviewer r
JOIN Rating ra ON r.rev_id = ra.rev_id
WHERE ra.num_o_ratings IS NULL;

use movie_database;
-- 9 Write a query in SQL to return the reviewer name, movie title, and stars for those movies which are 
#reviewed by a reviewer and must be rated. Sort the result by reviewer name, movie title, and number of stars.

 select rev_name,mov_title,rev_stars from reviewer,movie,rating where rev_name is not null
 and num_o_ratings is not null;
 alter table rating modify rev_stars int;
 
 select r.rev_name,m.mov_title,ra.rev_stars from movie m 
join rating ra on m.mov_id=ra.mov_id
join reviewer r on ra.rev_id=r.rev_id 
 where r.rev_name is not null and ra.num_o_ratings is not null;

select rev_name,mov_title,rev_stars from reviewer,movie, rating where movie.mov_id = rating.mov_id
and rating.rev_id =reviewer.rev_id
and rev_stars <> 0
and rev_name is not null order by rev_name;

-- 10. Write a query in SQL to find the reviewer's name and the title of the movie for those
#reviewers who rated more than one movie.

 SELECT rev_name,mov_title from reviewer,movie,rating
 where rating.mov_id=movie.mov_id
 and rating.rev_id=reviewer.rev_id and num_o_ratings>1;
 
 select r.rev_name,m.mov_title,ra.num_o_ratings from movie m 
 join rating ra on m.mov_id=ra.mov_id
 join reviewer r on ra.rev_id=r.rev_id
 where ra.num_o_ratings>1;
 
 SELECT r.rev_name, m.mov_title,ra.num_o_ratings
FROM reviewer r
JOIN rating ra ON r.rev_id = ra.rev_id
JOIN movie m ON ra.mov_id=m.mov_id
WHERE ra.num_o_ratings > 1
LIMIT 0, 1000;

-- 11 Write a query in SQL to find the movie title, and the highest number of stars that
#movie received and arrange the result according to the group of a movie and the movie
#title appear alphabetically in ascending order.

use movie_database;

select m.mov_title,max(ra.rev_stars) from movie m 
join rating ra on m.mov_id=ra.mov_id 
group by m.mov_title  ORDER BY mov_title asc;

SELECT mov_title, MAX(rev_stars)
FROM movie, rating 
WHERE movie.mov_id = rating.mov_id 
  AND rating.rev_stars IS NOT NULL
GROUP BY mov_title
ORDER BY mov_title;



-- 12. Write a query in SQL to find the names of all reviewers who rated the movie American Beauty.
 select rev_name from reviewer where rev_id in
 (select rev_id from rating where mov_id in(select mov_id from movie where mov_title="American Beauty"));

 select r.rev_name from reviewer r 
 join rating ra on r.rev_id=ra.rev_id
 join movie m on ra.mov_id= m.mov_id
 where m.mov_title="American Beauty";
 
 select rev_name from reviewer
inner join rating using(rev_id)
inner join movie using (mov_id)
where mov_title = 'American Beauty';
 
 SELECT DISTINCT r.rev_name
FROM reviewer r
JOIN rating ra ON r.rev_id = ra.rev_id
JOIN movie m ON ra.mov_id = m.mov_id
WHERE m.mov_title = 'American Beauty';

 
 -- 13. Write a query in SQL to find the titles of all movies which have been reviewed by
#anybody except by Paul Monks.

select mov_title from movie  where mov_id in(select mov_id from rating where rev_id in(select rev_id from reviewer where rev_name<>"Paul Monks"));
 
 select m.mov_title from movie m 
 join rating ra on m.mov_id=ra.mov_id
 join reviewer r on ra.rev_id=r.rev_id
 where r.rev_name<>"Paul Monks";
 
 -- 14 Write a query in SQL to return the reviewer name, movie title, and number of stars
#for those movies whose rating is the lowest one.

select  distinct rev_name, mov_title,rev_stars from movie,reviewer,rating where 
rating.mov_id=movie.mov_id and reviewer.rev_id=rating.rev_id and rating.rev_stars=(select min(rev_stars) from rating);

select rev_name,mov_title,rev_stars from reviewer,movie,rating
where rev_stars in(select min(rev_stars) from rating)
and reviewer.rev_id=rating.rev_id
and rating.mov_id = movie.mov_id;

SELECT r.rev_name, m.mov_title, ra.num_o_ratings
FROM movie m
JOIN rating ra ON m.mov_id = ra.mov_id
JOIN reviewer r ON ra.rev_id = r.rev_id
WHERE ra.num_o_ratings = (SELECT MIN(num_o_ratings) FROM rating);

-- 15 Write a query in SQL to find the titles of all movies directed by James Cameron.
select mov_title from movie where mov_id in (select mov_id from movie_direction where dir_id in 
(select dir_id from director where dir_fname="James" and dir_lname="Cameron"));

select m.mov_title from movie m 
join movie_direction md on m.mov_id=md.mov_id
join director d on md.dir_id=d.dir_id
where d.dir_fname="James" and d.dir_lname="Cameron" group by mov_title;

-- 16. Write a query in SQL to find the name of those movies where one or more actors
#acted in two or more movies.

select mov_title from movie where mov_id in (select mov_id from movie_cast where act_id in (select act_id from movie_cast
group by act_id
having count(act_id) >1));

select mov_title from  movie where mov_id in
(select mov_id from movie_cast where act_id in (select act_id from movie_cast group by act_id having count(act_id)>1)); 

alter table rating modify  column num_o_ratings integer;



#advance

-- 1 Write a query in SQL to find the name of all reviewers who have rated their ratings with a NULL value.

select rev_name from reviewer where rev_id in (select rev_id from rating where rev_stars is null);

select rev_name from reviewer r 
join rating ra on r.rev_id=ra.rev_id
where rev_stars is null group by rev_name;

--  2. Write a query in SQL to list the first and last names of all the actors who were cast in
#the movie 'Annie Hall', and the roles they played in that production.

 select act_fname,act_lname,role from actor a 
 join movie_cast mc on a.act_id=mc.act_id
 join movie m on mc.mov_id=m.mov_id
 where m.mov_title="Annie Hall";
 use movie_database;
 
-- 8. Write a query in SQL to list all the movies with year, genres, and name of the
-- director.
Select distinct mov_title,mov_year,gen_title,dir_fname from movie 
join movie_genres using(mov_id)
join genres using(gen_id)
join movie_direction using(mov_id)
join director using(dir_id);

select mov_dt_rel from movie;

-- 9 Write a query in SQL to list all the movies with title, year, date of release, movie
-- duration, and first and last name of the director which released before 1st january
-- 1989, and sort the result set according to release date from highest date to lowest.
select distinct mov_title,mov_year,mov_dt_rel,mov_time,dir_fname,dir_lname from movie
join movie_direction using(mov_id)
join director using(dir_id)
where mov_dt_rel<1989-01-01;

-- 10 Write a query in SQL to compute a report which contains the genres of those
-- movies with their average time and number of movies for each genre.
select distinct gen_title,avg(mov_time),count(gen_title) from movie
join movie_genres using (mov_id)
join genres using (gen_id)
group by gen_title;

select gen_title,avg(mov_time) as Duration,count(gen_title),mov_title as number_of_genres
from genres inner join movie_genres on movie_genres.gen_id = genres.gen_id
inner join movie on movie.mov_id= movie_genres.mov_id
group by gen_title,mov_title;

-- 11 Write a query in SQL to find those lowest duration movies along with the year,
-- director's name, actor's name and his/her role in that production.

select distinct min(mov_time) as duration,mov_year,dir_fname,act_fname,role from movie
join movie_cast using (mov_id)
join actor using(act_id)
join movie_direction using(mov_id)
join director using(dir_id) 
group by mov_year,dir_fname,act_fname,ROLE;

select mov_title,mov_year,mov_time,
concat(dir_fname,' ',dir_lname)as dir_name,
concat(act_fname,' ',act_lname) as act_name,role
from movie inner join movie_cast using (mov_id)
inner join actor using (act_id)
inner join movie_direction using (mov_id)
inner join director using(dir_id)
where mov_time in (select min(mov_time) as lowest_duration from movie);

-- 12 Write a query in SQL to find the names of all reviewers who rated the movie
-- American Beauty.
select rev_name,rev_stars from reviewer
join rating using (rev_id)
join movie using (mov_id)
where mov_title="American Beauty";

-- 13 Write a query in SQL to find the titles of all movies which have been reviewed by
-- anybody except by Paul Monks.
select distinct mov_title from movie 
join rating using(mov_id)
join reviewer using (rev_id)
where rev_name<>"Paul Monks";

-- 14 Write a query in SQL to return the reviewer name, movie title, and number of stars
-- for those movies whose rating is the lowest one.
select distinct rev_name,mov_title,min(rev_stars) from movie
join rating using (mov_id)
join reviewer using (rev_id)
group by rev_name,mov_title having rev_name is not null;

SET SQL_SAFE_UPDATES = 0;

update reviewer set rev_name=trim(rev_name);

-- 15 Write a query in SQL to find the titles of all movies directed by James Cameron.
select distinct mov_title from movie 
join movie_direction using (mov_id)
join director using (dir_id)
where dir_fname="James" and dir_lname="Cameron";

-- 
 

 -- 24 Write a query in SQL to generate a report which contains the columns movie title,
#name of the female actor, year of the movie, role, movie genres, the director, date of
#release, and rating of that movie.
select mov_title,act_fname,act_lname,mov_year,role,gen_title,dir_fname,mov_dt_rel,rev_stars from movie m
join movie_genres mg on m.mov_id=mg.mov_id
join genres g on mg.gen_id=g.gen_id
join rating rt on m.mov_id=rt.mov_id
join movie_cast mc on m.mov_id=mc.mov_id
join actor a on mc.act_id=a.act_id
join movie_direction md on m.mov_id=md.mov_id
join director d on md.dir_id=d.dir_id
where act_gender="F";
 -- 23. Write a query in SQL to generate a report which shows the year when most of the
-- Mystery movies are produced, and number of movies and their average rating.
SELECT mov_year,avg(num_o_ratings) from movie,rating where mov_id in 
(select mov_id from movie_genres where gen_id in
(select gen_id from genres where gen_title=" Mystery")) group by mov_year ;

select m.mov_year,count(m.mov_id),avg(rt.rev_stars) from movie m 
join movie_genres mg on m.mov_id=mg.mov_id
join genres g on mg.gen_id=g.gen_id
join rating rt on m.mov_id=rt.mov_id
where g.gen_title=" Mystery"
group by m.mov_year ;

SELECT m.mov_year AS production_year,
       COUNT(m.mov_id) AS number_of_movies,
       AVG(rt.rev_stars) AS average_num_ratings
FROM movie m
JOIN movie_genres mg ON m.mov_id = mg.mov_id
JOIN genres g ON mg.gen_id = g.gen_id
JOIN rating rt ON m.mov_id = rt.mov_id
WHERE g.gen_title = 'Mystery'
GROUP BY m.mov_year
LIMIT 0, 1000;


Select mov_year,gen_title,count(gen_title),avg(rev_stars) from movie
inner join rating using (mov_id)
inner join movie_genres using (mov_id)
inner join genres using(gen_id)
where gen_title ='Mystery'
group by gen_title,mov_year;
use movie_database;

--  22. Write a query in SQL to find the highest-rated Mystery movie, and report the title,
-- year, and rating.  
select max(r.rev_stars) as max_rating,m.mov_title,m.mov_year,g.gen_title from movie m
join movie_genres mg on m.mov_id=mg.mov_id
join genres g on mg.gen_id=g.gen_id
join rating r on m.mov_id=r.mov_id
where g.gen_title="Mystery"
group by m.mov_title, m.mov_year,g.gen_title;

SELECT MAX(r.rev_stars) AS max_review_stars, m.mov_title, m.mov_year, g.gen_title
FROM movie m
JOIN movie_genres mg ON m.mov_id = mg.mov_id
JOIN genres g ON mg.gen_id = g.gen_id
JOIN rating r ON m.mov_id = r.mov_id
WHERE g.gen_title = 'Mystery'
GROUP BY m.mov_id, m.mov_title, m.mov_year, g.gen_title
ORDER BY max_review_stars DESC
LIMIT 1;


-- 21. Write a query in SQL to find the highest-rated movie, and report its title, year,
-- rating, and releasing country.
select max(rt.rev_stars) as highest_rating,m.mov_title,m.mov_year,m.mov_rel_country from movie m 
join rating rt on m.mov_id=rt.mov_id
group by m.mov_title,m.mov_year,m.mov_rel_country;

-- 20. Write a query in SQL to find the movie in which the actor appeared whose first and
-- last name are 'Harrison' and 'Ford'.
select m.mov_title,a.act_fname,a.act_lname from movie m 
join movie_cast mc on m.mov_id=mc.mov_id
join actor a on mc.act_id=a.act_id
where act_fname="Harrison" and act_lname="Ford";

select mov_title from movie where mov_id in
 (select mov_id from movie_cast where act_id in(select act_id from actor where act_fname="Harrison"));
 
 -- 19. Write a query in SQL to find the cast list for the movie Chinatown.
 select a.act_fname,a.act_lname,a.act_gender,m.mov_title from movie m 
 join movie_cast mc on m.mov_id=mc.mov_id
 join actor a on mc.act_id=a.act_id
 where m.mov_title="Chinatown";
 
 -- 18. Write a query in SQL to find the first and last name of an actor with their role in the
-- movie which was also directed by themselves.
select a.act_fname,a.act_lname, m.mov_title,mc.role from movie m 
join movie_cast mc on m.mov_id=mc.mov_id
join actor a on mc.act_id=a.act_id
join movie_direction md on m.mov_id=md.mov_id
join director d  on md.dir_id=d.dir_id
where dir_fname=act_fname and dir_lname=act_lname;

Select distinct act_lname,role,mov_title from actor
inner join movie_cast using(act_id)
inner join movie using(mov_id)
inner join movie_direction using(mov_id)
inner join director using(dir_id)
where trim(act_fname)=trim(dir_fname);

update actor set act_fname = trim(act_fname);
--  17. Write a query in SQL to find the first and last name of a director and the movie he or
-- she directed, and the actress appeared whose first name was Claire and last name was
-- Danes along with her role in that movie. 
select d.dir_fname,d.dir_lname,m.mov_title,mc.role from movie m 
 join movie_cast mc on m.mov_id = mc.mov_id
 JOIN actor a on mc.act_id=a.act_id
 join movie_direction md on m.mov_id=md.mov_id
 join director d on md.dir_id=d.dir_id
 where trim(act_fname)="Claire" and trim(act_lname)="Danes";
 
 select dir_fname,dir_lname,role,mov_title,act_fname from actor
 inner join movie_cast using(act_id)
 inner join movie using(mov_id)
 inner join movie_direction using (mov_id)
 inner join director using(dir_id)
 where trim(act_fname)="Claires" and trim(act_lname)="Danes";
 
 -- 16 Write a query in SQL to find the movie title, actor first and last name, and the role
-- for those movies where one or more actors acted in two or more movie-- 

select m.mov_title,a.act_fname,a.act_lname,mc.role from movie m 
join movie_cast mc on m.mov_id=mc.mov_id
join actor a on mc.act_id=a.act_id
group by m.mov_title
having count(a.act_id)>1 and count(m.mov_id)>1;


