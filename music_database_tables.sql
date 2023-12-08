CREATE TABLE User (
    user_id INT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(30) NOT NULL,
    registrationDate DATE,
    subscriptionID INT,
    FOREIGN KEY (subscriptionID)
        REFERENCES Subscription (subscriptionID)
);
CREATE TABLE Subscription (
    subscriptionID INT PRIMARY KEY,
    subscriptionType VARCHAR(255) NOT NULL,
    Price DECIMAL(10 , 2 ) NOT NULL,
    duration INT
);
CREATE TABLE Playlist (
    playlist_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    playlistTitle VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    creationDate DATE,
    FOREIGN KEY (user_id)
        REFERENCES User (user_id)
);
CREATE TABLE Song (
    song_id INT PRIMARY KEY,
    songTitle VARCHAR(255) NOT NULL,
    album_id INT,
    artist_id INT,
    duration FLOAT,
    releaseDate DATE,
    FOREIGN KEY (album_id)
        REFERENCES Album (album_id),
    FOREIGN KEY (artist_id)
        REFERENCES Artist (artist_id)
);
CREATE TABLE PlaylistSongs (
    playlist_id INT NOT NULL,
    song_id INT NOT NULL,
    PRIMARY KEY (playlist_id , song_id),
    FOREIGN KEY (playlist_id)
        REFERENCES Playlist (playlist_id),
    FOREIGN KEY (song_id)
        REFERENCES Song (song_id)
);
CREATE TABLE Album (
    album_id INT PRIMARY KEY,
    albumTitle VARCHAR(255) NOT NULL,
    artist_id INT,
    releaseDate DATE,
    FOREIGN KEY (artist_id)
        REFERENCES Artist (artist_id)
);
CREATE TABLE Artist (
    artist_id INT PRIMARY KEY,
    artistName VARCHAR(255) NOT NULL,
    nationality VARCHAR(255),
    dateOfBirth DATE
);
CREATE TABLE Genre (
    genre_id INT PRIMARY KEY,
    genreName VARCHAR(255) NOT NULL
);
CREATE TABLE SongGenre (
    song_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (song_id , genre_id),
    FOREIGN KEY (song_id)
        REFERENCES Song (song_id),
    FOREIGN KEY (genre_id)
        REFERENCES Genre (genre_id)
);
CREATE TABLE Award (
    award_id INT NOT NULL,
    artist_id INT,
    awardName VARCHAR(255) NOT NULL,
    year VARCHAR(30),
    FOREIGN KEY (artist_id)
        REFERENCES Artist (artist_id)
);