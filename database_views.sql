use music_rd;

CREATE VIEW UserPlaylistDetails AS
    SELECT 
        User.userName,
        Playlist.playlistTitle,
        COUNT(PlaylistSongs.song_id) AS SongCount
    FROM
        User
            LEFT JOIN
        Playlist ON User.user_id = Playlist.user_id
            LEFT JOIN
        PlaylistSongs ON Playlist.playlist_id = PlaylistSongs.playlist_id
    GROUP BY User.user_id , Playlist.playlist_id , Playlist.playlistTitle;
   
CREATE VIEW TopGenres AS
    SELECT 
        Genre.genreName, COUNT(SongGenre.song_id) AS SongCount
    FROM
        Genre
            LEFT JOIN
        SongGenre ON Genre.genre_id = SongGenre.genre_id
    GROUP BY Genre.genre_id , Genre.genreName
    ORDER BY SongCount DESC
    LIMIT 10;

CREATE VIEW ArtistAwardsView AS
    SELECT 
        A.artist_id,
        A.artistName,
        A.nationality,
        A.dateOfBirth,
        AW.award_id,
        AW.awardName,
        AW.year
    FROM
        Artist A
            LEFT JOIN
        Award AW ON A.artist_id = AW.artist_id;

CREATE VIEW LongestSongsView AS
    SELECT 
        Song.songTitle,
        Song.duration,
        Artist.artistName,
        Album.albumTitle
    FROM
        Song
            LEFT JOIN
        Artist ON Song.artist_id = Artist.artist_id
            LEFT JOIN
        Album ON Song.album_id = Album.album_id
    ORDER BY Song.duration DESC
    LIMIT 10;