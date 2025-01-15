-- CHALLENGE 24 --------------------------------------------
/* 
Find the most popular song with the most plays and least skips, in that order.

A skip is when the song hasn't been played the whole way through.

Submit the song name.

EXAMPLE SCHEMA:
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(255) NOT NULL
);
CREATE TABLE songs (
    song_id INT PRIMARY KEY,
    song_title VARCHAR(255) NOT NULL,
    song_duration INT  -- Duration in seconds, can be NULL if unknown
);
CREATE TABLE user_plays (
    play_id INT PRIMARY KEY,
    user_id INT,
    song_id INT,
    play_time DATE,
    duration INT,  -- Duration in seconds, can be NULL
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (song_id) REFERENCES songs(song_id)
);

EXAMPLE RESULT:
 song_title   | total_plays | total_skips 
----------------+-------------+-------------
 Deck the Halls |           4 |           2
 Silent Night   |           3 |           2
 Jingle Bells   |           3 |           2
 
EXAMPLE SUBMISSION:
Deck the Halls
 
*/
-- SOLUTION --------------------------------------------- 
with base_cte as (
	select 
		up.play_id,
		up.song_id,
		up.duration as play_duration,
		s.song_duration,
		s.song_title
	from user_plays up
	join songs s on up.song_id = s.song_id
),
skips_cte as (
	select 
		song_title,
		count(*) as total_skips
	from base_cte
	where play_duration < song_duration
	group by 1
),
plays_cte as (
	select
		song_title,
		count(*) as total_plays
	from base_cte
	group by 1
)
select 
	s.song_title,
	p.total_plays,
	s.total_skips
from skips_cte s
join plays_cte p on s.song_title = p.song_title
order by total_plays desc, total_skips

-- RESULT -----------------------------------------------
-- All I Want For Christmas Is You
