-- Create Tables
CREATE TABLE Artists (
 Artist_id INT PRIMARY KEY,
 Artist_name NVARCHAR(50)
);
CREATE TABLE Albums (
 Album_id INT PRIMARY KEY,
 Album_title NVARCHAR(50),
 Artist_id INT,
 Release_year INT,
 FOREIGN KEY (Artist_id) REFERENCES Artists(Artist_id)
);
CREATE TABLE Songs (
 Song_id INT PRIMARY KEY,
 Song_title NVARCHAR(50),
 Duration DECIMAL(4, 2),
 Genre NVARCHAR(50),
 Album_id INT,
 FOREIGN KEY (Album_id) REFERENCES Albums(Album_id)
);
-- Insert Data into Artists Table
INSERT INTO Artists (Artist_id, Artist_name) VALUES
(1, 'Aparshakti Khurana'),
(2, 'Ed Sheeran'),
(3, 'Shreya Ghoshal'),
(4, 'Arijit Singh'),
(5, 'Tanishk Bagchi');
-- Insert Data into Albums Table
INSERT INTO Albums (Album_id, Album_title, Artist_id, Release_year) VALUES (1007, 'Album7', 1, 2015),
(1001, 'Album1', 1, 2019),
(1002, 'Album2', 2, 2015),
(1003, 'Album3', 3, 2018),
(1004, 'Album4', 4, 2020),
(1005, 'Album5', 2, 2020),
(1006, 'Album6', 1, 2009);
-- Insert Data into Songs Table
INSERT INTO Songs (Song_id, Song_title, Duration, Genre, Album_id) VALUES
(101, 'Zaroor', 2.55, 'Feel good', 1001),
(102, 'Espresso', 4.10, 'Rhythmic', 1002),
(103, 'Shayad', 3.20, 'Sad', 1003),
(104, 'Roar', 4.05, 'Pop', 1002),
(105, 'Everybody Talks', 3.35, 'Rhythmic', 1003),
(106, 'Dwapara', 3.54, 'Dance', 1002),
(107, 'Sa Re Ga Ma', 4.20, 'Rhythmic', 1004),
(108, 'Tauba', 4.05, 'Rhythmic', 1005),
(109, 'Perfect', 4.23, 'Pop', 1002),
(110, 'Good Luck', 3.55, 'Rhythmic', 1004);


SELECT * FROM Artists
SELECT * FROM Albums
SELECT * FROM Songs
---- PART A

--Retrieve a unique genre of songs.
select distinct genre from SONGS

--Find top 2 albums released before 2010.
select top 2 * from Albums where Release_year < 2010

--Insert Data into the Songs Table. (1245, ‘Zaroor’, 2.55, ‘Feel good’, 1005)
insert into SONGS values
(1245,'Zaroor', 2.55, 'Feel good', 1005)

--Change the Genre of the song ‘Zaroor’ to ‘Happy’
update SONGS set Genre = 'Happy' where Song_title = 'zaroor'

--Delete an Artist ‘Ed Sheeran’
delete from Artists where Artist_name = 'Ed sheeran'
select * from Artists

--Add a New Column for Rating in Songs Table. [Ratings decimal(3,2)]
alter table songs add Ratings decimal(3,2)

--Retrieve songs whose title starts with 'S'.
select song_title from SONGS where Song_title like 'S%'

--Retrieve all songs whose title contains 'Everybody'.
select Song_title from SONGS where Song_title like '%everybody%'

--Display Artist Name in Uppercase.
select upper(artist_name) from Artists

--Find the Square Root of the Duration of a Song ‘Good Luck’
select SQRT(duration) from songs where Song_title = 'good luck'

--Find Current Date.
select getdate()

--Find the number of albums for each artist.
SELECT ARTIST_ID,COUNT(ALBUM_TITLE) AS TOTAL_ALBUMS FROM ALBUMS GROUP BY ARTIST_ID;

--Retrieve the Album_id which has more than 5 songs in it.
SELECT ALBUM_ID,COUNT(SONG_ID) AS NOOFSONGS FROM SONGS GROUP BY ALBUM_ID HAVING COUNT(ALBUM_ID)>3;

--Retrieve all songs from the album 'Album1'. (using Subquery)
SELECT SONG_TITLE FROM SONGS WHERE ALBUM_ID IN(SELECT ALBUM_ID FROM ALBUMS WHERE ALBUM_TITLE='ALBUM1');

--Retrieve all albums name from the artist ‘Aparshakti Khurana’ (using Subquery)
SELECT ALBUM_TITLE FROM ALBUMS WHERE ARTIST_ID IN(SELECT ARTIST_ID FROM ARTISTS WHERE ARTIST_NAME='Aparshakti Khurana');

--Retrieve all the song titles with its album title.
SELECT SONGS.SONG_TITLE,ALBUMS.ALBUM_TITLE
FROM ALBUMS JOIN SONGS
ON ALBUMS.ALBUM_ID=ALBUMS.ALBUM_ID;

--Find all the songs which are released in 2020.
SELECT SONGS.SONG_TITLE,ALBUMS.RELEASE_YEAR
FROM ALBUMS JOIN SONGS 
ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
WHERE RELEASE_YEAR=2020;

--Create a view called ‘Fav_Songs’ from the songs table having songs with song_id 101-105.
CREATE VIEW FAV_SONGS AS SELECT SONG_ID,SONG_TITLE FROM SONGS WHERE SONG_ID BETWEEN 101 AND 105;

--19. Update a song name to ‘Jannat’ of song having song_id 101 in Fav_Songs view.
UPDATE FAV_SONGS SET SONG_TITLE='JANNAT' WHERE SONG_ID=101;

--20. Find all artists who have released an album in 2020.
SELECT ARTISTS.ARTIST_NAME,ALBUMS.RELEASE_YEAR FROM ARTISTS JOIN ALBUMS ON ARTISTS.ARTIST_ID=ALBUMS.ARTIST_ID WHERE RELEASE_YEAR=2020;

--21. Retrieve all songs by Shreya Ghoshal and order them by duration.
SELECT ARTISTS.ARTIST_NAME,SONGS.DURATION,ALBUMS.ALBUM_ID FROM ARTISTS 
JOIN ALBUMS ON ARTISTS.ARTIST_ID=ALBUMS.ARTIST_ID
JOIN SONGS ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
WHERE ARTIST_NAME='SHREYA GHOSHAL' ORDER BY DURATION;




--Part – B

--22. Retrieve all song titles by artists who have more than one album.
SELECT SONGS.Song_title , COUNT(Albums.Album_id) AS TOTAL 

FROM Albums JOIN Songs ON 

Albums.Album_id = Songs.Album_id
 WHERE Albums.Album_id>1
 GROUP BY SONGS.Song_title

 --23. Retrieve all albums along with the total number of songs.
SELECT ALBUMS.ALBUM_TITLE,COUNT(SONGS.SONG_TITLE) AS TOTALSONGS FROM ALBUMS JOIN SONGS
ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID GROUP BY ALBUM_TITLE;

--24. Retrieve all songs and release year and sort them by release year.
SELECT SONGS.SONG_TITLE,ALBUMS.RELEASE_YEAR
FROM ALBUMS JOIN SONGS
ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
ORDER BY RELEASE_YEAR;

--25. Retrieve the total number of songs for each genre, showing genres that have more than 2 songs.
SELECT GENRE,COUNT(SONG_TITLE) AS MORETHAN2SONGS
FROM SONGS
GROUP BY GENRE
HAVING COUNT(SONG_TITLE)>2;

--26. List all artists who have albums that contain more than 3 songs.
SELECT ARTISTS.ARTIST_NAME,COUNT(SONGS.SONG_TITLE)
FROM ARTISTS JOIN ALBUMS
ON ARTISTS.ARTIST_ID=ALBUMS.ARTIST_ID
JOIN SONGS ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
GROUP BY ARTIST_NAME
HAVING COUNT(SONGS.SONG_TITLE)>3;

--Part – C

--27. Retrieve albums that have been released in the same year as 'Album4'
select Album_title from Albums where Release_year in (select Release_year from Albums where Album_title = 'Ablum4')

--28. Find the longest song in each genre
SELECT GENRE,MAX(DURATION)
FROM SONGS
GROUP BY GENRE;

--29. Retrieve the titles of songs released in albums that contain the word 'Album' in the title.
SELECT Songs.Song_title , Albums.Release_year 
FROM Albums JOIN SONGS 
ON 
Albums.Album_id = Songs.Album_id
WHERE Album_title LIKE '%Album%'


--30. Retrieve the total duration of songs by each artist where total duration exceeds 15 minutes.
SELECT ARTISTS.ARTIST_NAME,SUM(SONGS.DURATION) AS TOTAL_DURATION
FROM ARTISTS JOIN ALBUMS ON ARTISTS.ARTIST_ID=ALBUMS.ARTIST_ID
JOIN SONGS ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
GROUP BY ARTIST_NAME
HAVING SUM(SONGS.DURATION)>15.00;

