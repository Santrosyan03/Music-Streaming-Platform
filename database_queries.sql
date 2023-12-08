use music_rd;

-- 1
SELECT 
    username
FROM
    user u
WHERE
    EXISTS( SELECT 
            1
        FROM
            playlist p
        WHERE
            u.user_id = p.user_id);
            
-- 2
SELECT 
    songTitle, duration AS 'duration(minutes)'
FROM
    song
ORDER BY duration DESC
LIMIT 3;

-- 3
SELECT 
    u.user_id,
    u.username,
    u.firstName,
    u.lastName,
    p.playlistTitle
FROM
    user u
        LEFT JOIN
    playlist p ON u.user_id = p.user_id;

-- 4
SELECT 
    a.albumTitle, ar.artistName, a.releaseDate
FROM
    album a
        INNER JOIN
    artist ar ON a.artist_id = ar.artist_id
WHERE
    YEAR(a.releaseDate) >= '2022';

-- 5
SELECT DISTINCT
    aw.award_id,
    aw.awardName,
    aw.year,
    ar.artistName,
    s.songTitle,
    al.albumTitle
FROM
    Award aw
        JOIN
    Artist ar ON aw.artist_id = ar.artist_id
        JOIN
    Album al ON ar.artist_id = al.artist_id
        JOIN
    Song s ON al.album_id = s.album_id;
    
-- 6
SELECT 
    g.genre_id,
    g.genreName,
    ROUND(AVG(s.duration), 2) AS 'Average Duration'
FROM
    Genre g
        LEFT JOIN
    SongGenre sg ON g.genre_id = sg.genre_id
        LEFT JOIN
    Song s ON sg.song_id = s.song_id
GROUP BY g.genre_id , g.genreName;

-- 7
SELECT 
    Genre.genreName, COUNT(Song.song_id) AS SongCount
FROM
    Genre
        LEFT JOIN
    SongGenre ON Genre.genre_id = SongGenre.genre_id
        LEFT JOIN
    Song ON SongGenre.song_id = Song.song_id
GROUP BY Genre.genre_id , Genre.genreName
ORDER BY SongCount DESC
LIMIT 1;

-- 8
SELECT 
    a.album_id,
    a.albumTitle,
    ROUND(AVG(s.duration), 2) AS averageDuration,
    ROUND(SUM(s.duration), 2) AS totalDuration
FROM
    Album a
        LEFT JOIN
    Song s ON a.album_id = s.album_id
GROUP BY a.album_id , a.albumTitle;

-- 9
SELECT 
    a.artist_id,
    a.artistName,
    al.album_id,
    al.albumTitle,
    g.genreName
FROM
    Artist a
        JOIN
    Album al ON a.artist_id = al.artist_id
        LEFT JOIN
    Song s ON al.album_id = s.album_id
        LEFT JOIN
    SongGenre sg ON s.song_id = sg.song_id
        LEFT JOIN
    Genre g ON sg.genre_id = g.genre_id;
    
-- 10
SELECT 
    a.artist_id, a.artistName, al.album_id, al.albumTitle
FROM
    Artist a
        JOIN
    Album al ON a.artist_id = al.artist_id
WHERE
    al.album_id IN (SELECT 
            s.album_id
        FROM
            Song s
                JOIN
            SongGenre sg ON s.song_id = sg.song_id
                JOIN
            Genre g ON sg.genre_id = g.genre_id
        WHERE
            g.genreName = 'Pop');
            
-- 11
SELECT 
    SUM(Price) AS TotalPrice
FROM
    Subscription;

-- 12
SELECT 
    u.username, p.playlistTitle, p.description, p.creationDate
FROM
    User u
        JOIN
    Playlist p ON u.user_id = p.user_id
        JOIN
    Subscription s ON u.subscriptionID = s.subscriptionID
WHERE
    s.subscriptionType = 'Premium';
    
-- 13
SELECT DISTINCT
    u.user_id, u.username, p.playlist_id, p.playlistTitle
FROM
    User u
        JOIN
    Playlist p ON u.user_id = p.user_id
WHERE
    p.playlistTitle LIKE '%favorite%';
    
-- 14
SELECT 
    S.song_id, S.songTitle
FROM
    Song S
        LEFT JOIN
    PlaylistSongs PS ON S.song_id = PS.song_id
WHERE
    PS.song_id IS NULL;
    
-- 15 
SELECT 
    g.genreName, COUNT(SG.song_id) AS SongCount
FROM
    Genre g
        LEFT JOIN
    SongGenre sg ON g.genre_id = sg.genre_id
GROUP BY g.genre_id , g.genreName
HAVING COUNT(sg.song_id) > 5
ORDER BY SongCount DESC;
