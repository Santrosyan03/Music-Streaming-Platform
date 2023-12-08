use music_rd;

CREATE INDEX idx_song_release_date ON Song (releaseDate);
CREATE INDEX idx_playlist_user_playlist ON Playlist (user_id, playlist_id);
CREATE INDEX idx_artist_name ON Artist (artistName);   
CREATE INDEX idx_genre_name ON Genre (genreName);
CREATE UNIQUE INDEX idx_user_email ON User (email);