-- sql spotify project
-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);
SELECT COUNT (*) FROM spotify;
SELECT COUNT (DISTINCT artist) FROM spotify;
SELECT DISTINCT album_type FROM spotify;
SELECT MAX (duration_min) FROM spotify;
SELECT MIN (duration_min) FROM spotify;
SELECT * FROM spotify 
WHERE duration_min =0 ;
DELETE FROM spotify 
WHERE duration_min =0;
SELECT DISTINCT channel FROM spotify;
SELECT DISTINCT most_played_on FROM spotify;


-- Basic analysis 
--1) total number of tracks 
CREATE VIEW total_tracks AS
SELECT COUNT (track) AS total_tracks_count
FROM spotify;

--2) number of diferent artists
CREATE VIEW different_artists AS
SELECT COUNT (DISTINCT artist) AS different_artist_count
FROM spotify;

-- 3) number of songs with over than 1B views
CREATE VIEW count_songs_over_1B AS
SELECT COUNT(*) AS num_songs
FROM spotify
WHERE stream > 1000000000;
--4) views stats
CREATE VIEW views_stats AS
SELECT 
    MIN(views) AS min_views,
    MAX(views) AS max_views,
    AVG(views) AS avg_views
FROM spotify;
--5) likes stats
CREATE VIEW likes_stats AS
SELECT 
    MIN(likes) AS min_likes,
    MAX(likes) AS max_likes,
    AVG(likes) AS avg_likes
FROM spotify;

--6) comment stats

CREATE VIEW comments_stats AS
SELECT 
    MIN(comments) AS min_comments,
    MAX(comments) AS max_comments,
    AVG(comments) AS avg_comments
FROM spotify;

--7) number of streams for each album type
CREATE VIEW album_type_streams AS
SELECT 
    album_type,
    COUNT(*) AS track_count,
    SUM(stream) AS total_streams
FROM spotify
GROUP BY album_type;

--8) Average of stream per platform 
CREATE VIEW avg_stream_platform AS
SELECT 
    most_played_on,
    COUNT(*) AS track_count,
    AVG(stream) AS avg_streams
FROM spotify
GROUP BY most_played_on;

-- 9)five most streamed songs 
CREATE VIEW most_streamed_songs AS
SELECT 
    track,
	stream
FROM spotify
ORDER BY stream DESC
LIMIT 5;

--10) five most stramed artists
CREATE VIEW most_streamed_artists AS
SELECT 
	artist,
	SUM(stream) AS total_streams
FROM spotify
GROUP BY artist 
ORDER BY total_streams DESC
LIMIT 5;

--11) offical and non offical views
CREATE VIEW avg_stream_platform AS
SELECT 
    official_video,
    COUNT(*) AS track_count,
    AVG(stream) AS avg_streams
FROM spotify
GROUP BY official_video;


-- 12) duration_likes_scatter
CREATE VIEW duration_likes_scatter AS
SELECT 
    track,
    artist,
    duration_min,
    likes
FROM spotify;

--13) energy , valence ,danceability,  vs stream 
CREATE VIEW energy_scatter AS
SELECT danceability, energy, valence, stream
FROM spotify;

--14)average features 
CREATE VIEW average_features AS
SELECT 
    AVG(danceability) AS avg_dance,
    AVG(energy) AS avg_energy,
    AVG(valence) AS avg_valence
FROM spotify	   

--15)average features for top 10% most streamed tracks
CREATE VIEW top_10_percent_features AS
WITH top_tracks AS (
    SELECT *, NTILE(10) OVER (ORDER BY stream DESC) AS decile
    FROM spotify
)
SELECT AVG(danceability) AS avg_dance,
       AVG(energy) AS avg_energy,
       AVG(valence) AS avg_valence
FROM top_tracks
WHERE decile = 1; -- top 10%


--16)Engagement ratio per track
CREATE VIEW  Engagement_ratio_track AS
SELECT 
    track, 
    artist,
    CASE WHEN views > 0 THEN likes::FLOAT / views ELSE 0 END AS like_ratio,
    CASE WHEN views > 0 THEN comments::FLOAT / views ELSE 0 END AS comment_ratio
FROM spotify
ORDER BY like_ratio DESC
LIMIT 10;

--17) relation (streams vs tembo,dancability vs energy)
CREATE VIEW relations AS
SELECT
    track,
    stream,
    energy,
    tempo,
    danceability
FROM spotify


