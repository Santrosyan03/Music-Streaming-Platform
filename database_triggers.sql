use music_rd;
-- 1. 
DELIMITER //
   CREATE TRIGGER update_playlist_duration
   AFTER INSERT ON PlaylistSongs
   FOR EACH ROW
   BEGIN
       UPDATE Playlist
       SET TotalDuration = TotalDuration + (SELECT duration FROM Song WHERE song_id = NEW.song_id)
       WHERE playlist_id = NEW.playlist_id;
END;
//
DELIMITER ;
-- 2. 
DELIMITER //
   CREATE TRIGGER prevent_delete_artist
   BEFORE DELETE ON Artist
   FOR EACH ROW
   BEGIN
       DECLARE album_count INT;
       SELECT COUNT(*) INTO album_count FROM Album WHERE artist_id = OLD.artist_id;
       IF album_count > 0 THEN
           SIGNAL SQLSTATE '45000'
           SET MESSAGE_TEXT = 'Cannot delete artist with associated albums';
       END IF;
END;
//
DELIMITER ;

-- 3.
DELIMITER //
   CREATE TRIGGER enforce_playlist_song_limit
   BEFORE INSERT ON PlaylistSongs
   FOR EACH ROW
   BEGIN
       DECLARE playlist_song_count INT;
       SELECT COUNT(*) INTO playlist_song_count FROM PlaylistSongs WHERE playlist_id = NEW.playlist_id;
       IF playlist_song_count >= 50 THEN
           SIGNAL SQLSTATE '45000'
           SET MESSAGE_TEXT = 'Playlist cannot have more than 50 songs';
       END IF;
END;
//
DELIMITER ;