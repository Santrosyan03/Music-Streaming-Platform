use music_rd;

DELIMITER //
CREATE FUNCTION GetUserPlaylistCount(userId INT)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE playlistCount INT;
    SELECT COUNT(*) INTO playlistCount
    FROM Playlist
    WHERE user_id = userId;
    RETURN playlistCount;
END;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION GetArtistSongCount(artist_id INT)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE song_count INT;
    SELECT COUNT(song_id) INTO song_count FROM Song WHERE artist_id = artist_id;
    RETURN song_count;
END; 
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION GetAverageSongDuration()
RETURNS DECIMAL(10, 2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE avg_duration DECIMAL(10, 2);
    SELECT AVG(duration) INTO avg_duration FROM Song;
    RETURN avg_duration;
END; 
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE UpdatePasswordByEmail(IN userEmail VARCHAR(255), IN newPassword VARCHAR(255))
BEGIN
    UPDATE User
    SET Password = newPassword
    WHERE Email = userEmail;
END; 
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE GetPlaylistTotalDuration(IN playlistId INT, OUT totalDuration DECIMAL(10, 2))
BEGIN
    SELECT
        SUM(s.Duration) INTO totalDuration
    FROM
        Song s
    JOIN
        PlaylistContainsSong pcs ON s.song_id = pcs.song_id
    WHERE
        pcs.playlist_id = playlistId;
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE GetUserPlaylists(IN userId INT)
BEGIN
    SELECT
        p.playlist_id,
        p.playlistTitle,
        p.description,
        p.createdDate
    FROM
        Playlist p
    JOIN
        UserCreatesPlaylist ucp ON p.playlist_id = ucp.playlist_id
    WHERE
        ucp.user_id = userId;
END;
//
DELIMITER ;