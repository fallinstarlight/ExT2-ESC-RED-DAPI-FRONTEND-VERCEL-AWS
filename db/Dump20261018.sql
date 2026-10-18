CREATE DATABASE  IF NOT EXISTS `music_catalog` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `music_catalog`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: music_catalog
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `album_genres`
--

DROP TABLE IF EXISTS `album_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album_genres` (
  `album_id` bigint unsigned NOT NULL,
  `genre_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`album_id`,`genre_id`),
  KEY `fk_album_genres_genre` (`genre_id`),
  CONSTRAINT `fk_album_genres_album` FOREIGN KEY (`album_id`) REFERENCES `albums` (`album_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_album_genres_genre` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album_genres`
--

LOCK TABLES `album_genres` WRITE;
/*!40000 ALTER TABLE `album_genres` DISABLE KEYS */;
INSERT INTO `album_genres` VALUES (1,1),(2,1),(4,1),(5,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(17,1),(19,1),(20,1),(21,1),(22,1),(25,1),(27,1),(28,1),(29,1),(30,1),(44,1),(45,1),(46,1),(47,1),(49,1),(57,1),(58,1),(60,1),(62,1),(65,1),(66,1),(70,1),(72,1),(85,1),(1,2),(3,3),(4,3),(5,3),(7,3),(8,3),(29,3),(30,3),(46,3),(49,3),(84,3),(85,3),(4,4),(5,4),(70,4),(4,5),(4,6),(5,6),(6,6),(4,7),(29,7),(30,7),(5,8),(46,8),(5,9),(5,10),(35,10),(5,11),(11,12),(12,12),(13,12),(15,12),(17,12),(26,12),(28,12),(35,12),(46,12),(58,12),(70,12),(81,12),(82,12),(83,12),(11,13),(12,13),(13,13),(15,13),(17,13),(18,14),(19,15),(25,15),(29,15),(30,15),(46,15),(49,15),(62,15),(63,15),(65,15),(66,15),(85,15),(19,16),(66,16),(20,17),(24,17),(25,17),(27,17),(29,17),(30,17),(46,17),(47,17),(65,17),(66,17),(21,18),(22,18),(26,18),(27,18),(30,18),(31,18),(35,18),(36,18),(37,18),(40,18),(42,18),(67,18),(68,18),(69,18),(81,18),(21,19),(22,19),(21,20),(22,20),(26,20),(46,20),(23,21),(47,21),(49,21),(65,21),(24,22),(25,22),(47,22),(49,22),(65,22),(66,22),(24,23),(25,23),(25,24),(47,24),(25,25),(25,26),(26,27),(27,28),(29,28),(30,28),(27,29),(84,29),(30,30),(31,31),(31,32),(35,32),(36,32),(31,33),(35,33),(51,33),(31,34),(32,34),(33,34),(34,34),(31,35),(36,35),(35,36),(81,36),(36,37),(40,37),(41,37),(42,37),(80,37),(37,38),(52,38),(37,39),(37,40),(73,40),(74,40),(77,40),(78,40),(37,41),(40,41),(42,41),(37,42),(38,43),(39,44),(40,44),(42,44),(40,45),(42,45),(46,46),(46,47),(46,48),(46,49),(46,50),(47,51),(49,51),(50,51),(49,52),(56,53),(56,54),(56,55),(56,56),(56,57),(59,58),(64,59),(75,60),(76,60),(75,61),(75,62),(76,63),(79,64),(81,65),(81,66);
/*!40000 ALTER TABLE `album_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `albums` (
  `album_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `release_year` smallint unsigned DEFAULT NULL,
  `primary_artist_id` bigint unsigned NOT NULL,
  `rating` decimal(3,2) DEFAULT NULL,
  `cover_url` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`album_id`),
  KEY `idx_albums_name` (`name`),
  KEY `idx_albums_year` (`release_year`),
  KEY `idx_albums_artist` (`primary_artist_id`),
  CONSTRAINT `fk_albums_primary_artist` FOREIGN KEY (`primary_artist_id`) REFERENCES `artists` (`artist_id`) ON DELETE RESTRICT,
  CONSTRAINT `chk_album_rating` CHECK (((`rating` is null) or ((`rating` >= 0) and (`rating` <= 10))))
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums`
--

LOCK TABLES `albums` WRITE;
/*!40000 ALTER TABLE `albums` DISABLE KEYS */;
INSERT INTO `albums` VALUES (1,'A Saucerful of Secrets',1968,1,NULL,'photos/albums/A Saucerful of Secrets.jpg'),(2,'Animals',1977,1,NULL,'photos/albums/Animals.jpg'),(3,'Atom Heart Mother',1970,1,NULL,'photos/albums/Atom Heart Mother.jpg'),(4,'Meddle',1971,1,NULL,'photos/albums/Meddle.jpg'),(5,'Soundtrack From the Film “More”',1969,1,NULL,'photos/albums/Soundtrack From the Film “More”.jpg'),(6,'The Dark Side of the Moon',1973,1,NULL,'photos/albums/The Dark Side of the Moon.jpg'),(7,'The Division Bell',1994,1,NULL,'photos/albums/The Division Bell.jpg'),(8,'The Piper at the Gates of Dawn',1967,1,NULL,'photos/albums/The Piper at the Gates of Dawn.jpg'),(9,'The Wall',1979,1,NULL,'photos/albums/The Wall.jpg'),(10,'Wish You Were Here',1975,1,NULL,'photos/albums/Wish You Were Here.jpg'),(11,'Hybrid Theory',2000,2,NULL,'photos/albums/Hybrid Theory.jpg'),(12,'Meteora',2003,2,NULL,'photos/albums/Meteora.jpg'),(13,'Minutes to Midnight',2007,2,NULL,'photos/albums/Minutes to Midnight.jpg'),(14,'A Thousand Suns',2010,2,NULL,'photos/albums/A Thousand Suns.jpg'),(15,'Living Things',2012,2,NULL,'photos/albums/Living Things.jpg'),(16,'The Hunting Party',2014,2,NULL,'photos/albums/The Hunting Party.jpg'),(17,'One More Light',2017,2,NULL,'photos/albums/One More Light.jpg'),(18,'From Zero',2024,2,NULL,'photos/albums/From Zero.jpg'),(19,'Alienation',2025,3,NULL,'photos/albums/Alienation.jpg'),(20,'EXPLOSIONS',2022,3,NULL,'photos/albums/EXPLOSIONS.jpg'),(21,'Human',2015,3,NULL,'photos/albums/Human.jpg'),(22,'Life Starts Now',2009,3,NULL,'photos/albums/Life Starts Now.jpg'),(23,'One-X',2006,3,NULL,'photos/albums/One-X.jpg'),(24,'Outsider',2018,3,NULL,'photos/albums/Outsider.jpg'),(25,'Three Days Grace',2003,3,NULL,'photos/albums/Three Days Grace.jpg'),(26,'Transit of Venus',2012,3,NULL,'photos/albums/Transit of Venus.jpg'),(27,'DIVISIONS',2019,4,NULL,'photos/albums/DIVISIONS.jpg'),(28,'SILOS',2025,4,NULL,'photos/albums/SILOS.jpg'),(29,'Transmissions',2014,4,NULL,'photos/albums/Transmissions.jpg'),(30,'Vessels',2017,4,NULL,'photos/albums/Vessels.jpg'),(31,'ODYSSEY',2026,5,NULL,'photos/albums/ODYSSEY.jpg'),(32,'Ashes',2016,5,NULL,'photos/albums/Ashes.jpg'),(33,'Awake',2017,5,NULL,'photos/albums/Awake.jpg'),(34,'Fallen Embers',2021,5,NULL,'photos/albums/Fallen Embers.jpg'),(35,'Ascend',2019,5,NULL,'photos/albums/Ascend.jpg'),(36,'ILLENIUM',2023,5,NULL,'photos/albums/ILLENIUM.jpg'),(37,'> album title goes here <',2012,6,NULL,'photos/albums/album title goes here.jpg'),(38,'for lack of a better name',2009,6,NULL,'photos/albums/for lack of a better name.jpg'),(39,'Kx5',2023,6,NULL,'photos/albums/Kx5.jpg'),(40,'Random Album Title',2008,6,NULL,'photos/albums/Random Album Title.jpg'),(41,'When the Summer Dies',2021,6,NULL,'photos/albums/When the Summer Dies.jpg'),(42,'while(1<2)',2014,6,NULL,'photos/albums/while 1 2.jpg'),(43,'Apostrophe (’)',1974,7,NULL,'photos/albums/Apostrophe (’).jpg'),(44,'Joe\'s Garage: Acts I, II & III',1995,7,NULL,'photos/albums/Joe\'s Garage_ Acts I, II & III.jpg'),(45,'Hot Rats',1969,7,NULL,'photos/albums/Hot Rats.jpg'),(46,'Sheik Yerbouti',2012,7,NULL,'photos/albums/Sheik Yerbouti.jpg'),(47,'Undertow',1993,8,NULL,'photos/albums/Undertow.jpg'),(48,'Ænima',1996,8,NULL,'photos/albums/Ænima.jpg'),(49,'Lateralus',2005,8,NULL,'photos/albums/Lateralus.jpg'),(50,'10,000 Days',2006,8,NULL,'photos/albums/10,000 Days.jpg'),(51,'The Invasion',2013,9,NULL,'photos/albums/The Invasion.jpg'),(52,'Apex',2018,9,NULL,'photos/albums/Apex.jpg'),(53,'Titans',2023,9,NULL,'photos/albums/Titans.jpg'),(54,'Zombie',2023,9,NULL,'photos/albums/Zombie.jpg'),(55,'Onyx',2022,9,NULL,'photos/albums/Onyx.jpg'),(56,'Among My Swan',1996,11,NULL,'photos/albums/Among My Swan.jpg'),(57,'Seasons of Your Day',2013,11,NULL,'photos/albums/Seasons of Your Day.jpg'),(58,'She Hangs Brightly',1990,11,NULL,'photos/albums/She Hangs Brightly.jpg'),(59,'So Tonight That I Might See',1993,11,NULL,'photos/albums/So Tonight That I Might See.jpg'),(60,'Led Zeppelin III',1970,12,NULL,'photos/albums/Led Zeppelin III.jpg'),(61,'Led Zeppelin IV',1971,12,NULL,'photos/albums/Led Zeppelin IV.jpg'),(62,'Physical Graffiti',1975,12,NULL,'photos/albums/Physical Graffiti.jpg'),(63,'Presence',1994,12,NULL,'photos/albums/Presence.jpg'),(64,'Dark Before Dawn',2015,13,NULL,'photos/albums/Dark Before Dawn.jpg'),(65,'Dear Agony',2010,13,NULL,'photos/albums/Dear Agony.jpg'),(66,'Phobia',2006,13,NULL,'photos/albums/Phobia.jpg'),(67,'Discovery',2001,14,NULL,'photos/albums/Discovery.jpg'),(68,'Human After All',2005,14,NULL,'photos/albums/Human After All.jpg'),(69,'Random Access Memories',2013,14,NULL,'photos/albums/Random Access Memories.jpg'),(70,'Revolver',1990,15,NULL,'photos/albums/Revolver.jpg'),(71,'Magical Mystery Tour',1967,15,NULL,'photos/albums/Magical Mystery Tour.jpg'),(72,'Sgt. Pepper\'s Lonely Hearts Club Band',1967,15,NULL,'photos/albums/Sgt. Pepper\'s Lonely Hearts Club Band.jpg'),(73,'Madvillainy',2014,16,NULL,'photos/albums/Madvillainy.jpg'),(74,'MM..Food',2004,16,NULL,'photos/albums/MM..Food.jpg'),(75,'Operation: Doomsday',1999,16,NULL,'photos/albums/Operation Doomsday.jpg'),(76,'The College Dropout',2004,17,NULL,'photos/albums/The College Dropout.jpg'),(77,'Graduation',2007,17,NULL,'photos/albums/Graduation.jpg'),(78,'My Beautiful Dark Twisted Fantasy',2010,17,NULL,'photos/albums/My Beautiful Dark Twisted Fantasy.jpg'),(79,'Colour the Small One',2004,18,NULL,'photos/albums/Colour the Small One.jpg'),(80,'Adventure',2015,19,NULL,'photos/albums/Adventure.jpg'),(81,'Good Faith',2019,19,NULL,'photos/albums/Good Faith.jpg'),(82,'Bad',1987,20,NULL,'photos/albums/Bad.jpg'),(83,'Thriller',1982,20,NULL,'photos/albums/Thriller.jpg'),(84,'Deloused in the Comatorium',2003,21,NULL,'photos/albums/Deloused in the Comatorium.jpg'),(85,'Frances the Mute',2005,21,NULL,'photos/albums/Frances the Mute.jpg');
/*!40000 ALTER TABLE `albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist_genres`
--

DROP TABLE IF EXISTS `artist_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist_genres` (
  `artist_id` bigint unsigned NOT NULL,
  `genre_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`artist_id`,`genre_id`),
  KEY `fk_artist_genres_genre` (`genre_id`),
  CONSTRAINT `fk_artist_genres_artist` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`artist_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_artist_genres_genre` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist_genres`
--

LOCK TABLES `artist_genres` WRITE;
/*!40000 ALTER TABLE `artist_genres` DISABLE KEYS */;
INSERT INTO `artist_genres` VALUES (1,1),(2,1),(3,1),(4,1),(7,1),(8,1),(11,1),(12,1),(13,1),(15,1),(21,1),(1,2),(1,3),(4,3),(7,3),(8,3),(21,3),(1,4),(15,4),(1,5),(1,6),(1,7),(4,7),(1,8),(7,8),(1,9),(1,10),(5,10),(1,11),(2,12),(3,12),(4,12),(5,12),(7,12),(11,12),(15,12),(19,12),(20,12),(2,13),(2,14),(3,15),(4,15),(7,15),(8,15),(12,15),(13,15),(21,15),(3,16),(13,16),(3,17),(4,17),(7,17),(8,17),(13,17),(3,18),(4,18),(5,18),(6,18),(14,18),(19,18),(3,19),(3,20),(7,20),(3,21),(8,21),(13,21),(3,22),(8,22),(13,22),(3,23),(3,24),(8,24),(3,25),(3,26),(3,27),(4,28),(4,29),(21,29),(4,30),(5,31),(5,32),(5,33),(9,33),(5,34),(5,35),(5,36),(19,36),(5,37),(6,37),(19,37),(6,38),(9,38),(6,39),(6,40),(16,40),(17,40),(6,41),(6,42),(6,43),(6,44),(6,45),(7,46),(7,47),(7,48),(7,49),(7,50),(8,51),(8,52),(11,53),(11,54),(11,55),(11,56),(11,57),(11,58),(13,59),(16,60),(17,60),(16,61),(16,62),(17,63),(18,64),(19,65),(19,66);
/*!40000 ALTER TABLE `artist_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artists`
--

DROP TABLE IF EXISTS `artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artists` (
  `artist_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `artistic_name` varchar(200) NOT NULL,
  `artist_type` enum('solo','band','other') NOT NULL DEFAULT 'solo',
  `description` text,
  `active_from_year` smallint unsigned DEFAULT NULL,
  `active_to_year` smallint unsigned DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `photo_url` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`artist_id`),
  KEY `idx_artists_name` (`artistic_name`),
  KEY `idx_artists_type_active` (`artist_type`,`is_active`),
  CONSTRAINT `chk_artist_years` CHECK (((`active_from_year` is null) or (`active_to_year` is null) or (`active_to_year` >= `active_from_year`)))
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artists`
--

LOCK TABLES `artists` WRITE;
/*!40000 ALTER TABLE `artists` DISABLE KEYS */;
INSERT INTO `artists` VALUES (1,'Pink Floyd','band','English rock band formed in London in 1965, distinguished for extended compositions, sonic experimentation, and philosophical lyrics.',1965,2014,0,'photos/artists/Pink Floyd.jpg'),(2,'Linkin Park','band','American rock band formed in Agoura Hills, California in 1996. Known for blending alternative rock, nu metal, and electronic elements.',1996,NULL,1,'photos/artists/Linkin Park.jpg'),(3,'Three Days Grace','band','Canadian rock band formed in Norwood, Ontario in 1997. Known for their post-grunge and alternative metal sound.',1997,NULL,1,'photos/artists/Three Days Grace.jpg'),(4,'STARSET','band','American rock band formed in Columbus, Ohio in 2013 by Dustin Bates. Known for their cinematic, space-themed rock sound.',2013,NULL,1,'photos/artists/STARSET.jpg'),(5,'ILLENIUM','solo','American electronic music producer and DJ (Nicholas D. Miller), known for melodic dubstep and emotional bass music.',2008,NULL,1,'photos/artists/ILLENIUM.jpg'),(6,'Deadmau5','solo','Canadian electronic music producer and DJ (Joel Zimmerman), a prominent figure in progressive house and electro house.',2000,NULL,1,'photos/artists/Deadmau5.jpg'),(7,'Frank Zappa','solo','American composer, guitarist, and bandleader known for his eclectic, experimental, and prolific output spanning rock, jazz, and classical music.',1955,1993,0,'photos/artists/Frank Zappa.jpg'),(8,'Tool','band','American progressive metal band formed in Los Angeles in 1990. Known for their complex, atmospheric sound and intricate musicianship.',1990,NULL,1,'photos/artists/Tool.jpg'),(9,'Excision','solo','Canadian dubstep producer and DJ (Jeff Abel), known for his heavy bass sound and immersive stage productions.',2006,NULL,1,'photos/artists/Excision.jpg'),(10,'Flux Pavilion','solo','English dubstep producer and DJ (Joshua Steele), a key figure in the UK bass music scene.',2008,NULL,1,'photos/artists/Flux Pavilion.jpg'),(11,'Mazzy Star','band','American alternative rock band formed in Santa Monica, California in 1988, known for their dreamy, psychedelic folk sound.',1988,NULL,0,'photos/artists/Mazzy Star.jpg'),(12,'Led Zeppelin','band','English rock band formed in London in 1968, widely considered pioneers of hard rock and heavy metal.',1968,1980,0,'photos/artists/Led Zeppelin.jpg'),(13,'Breaking Benjamin','band','American rock band formed in Wilkes-Barre, Pennsylvania in 1999, known for their post-grunge and alternative metal sound.',1999,NULL,1,'photos/artists/Breaking Benjamin.jpg'),(14,'Daft Punk','band','French electronic music duo formed in Paris in 1993, known for their influential house and disco-influenced sound.',1993,2021,0,'photos/artists/Daft Punk.jpg'),(15,'The Beatles','band','English rock band formed in Liverpool in 1960, widely regarded as the most influential band of all time.',1960,1970,0,'photos/artists/The Beatles.jpg'),(16,'MF DOOM','solo','British-American rapper and producer (Daniel Dumile), known for his complex wordplay and masked persona.',1997,2020,0,'photos/artists/MF DOOM.jpg'),(17,'Kanye West','solo','American rapper, producer, and fashion designer, known for his influential and genre-spanning discography.',1996,NULL,1,'photos/artists/Kanye West.jpg'),(18,'Sia','solo','Australian singer-songwriter known for her distinctive voice and successful pop songwriting career.',1993,NULL,1,'photos/artists/Sia.jpg'),(19,'Madeon','solo','French electronic music producer and DJ (Hugo Leclercq), known for his energetic and melodic electro house style.',2010,NULL,1,'photos/artists/Madeon.jpg'),(20,'Michael Jackson','solo','American singer, songwriter, and dancer, known as the \"King of Pop\" and one of the most significant cultural figures of the 20th century.',1964,2009,0,'photos/artists/Michael Jackson.jpg'),(21,'The Mars Volta','band','American progressive rock band formed by Omar Rodríguez-López and Cedric Bixler-Zavala.',2001,NULL,1,'photos/artists/The Mars Volta.jpg');
/*!40000 ALTER TABLE `artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `band_members`
--

DROP TABLE IF EXISTS `band_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `band_members` (
  `band_artist_id` bigint unsigned NOT NULL,
  `person_id` bigint unsigned NOT NULL,
  `member_role` varchar(150) DEFAULT NULL,
  `joined_year` smallint unsigned DEFAULT NULL,
  `left_year` smallint unsigned DEFAULT NULL,
  PRIMARY KEY (`band_artist_id`,`person_id`),
  KEY `idx_band_members_person` (`person_id`),
  CONSTRAINT `fk_band_members_artist` FOREIGN KEY (`band_artist_id`) REFERENCES `artists` (`artist_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_band_members_person` FOREIGN KEY (`person_id`) REFERENCES `people` (`person_id`) ON DELETE CASCADE,
  CONSTRAINT `chk_band_member_years` CHECK (((`joined_year` is null) or (`left_year` is null) or (`left_year` >= `joined_year`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `band_members`
--

LOCK TABLES `band_members` WRITE;
/*!40000 ALTER TABLE `band_members` DISABLE KEYS */;
INSERT INTO `band_members` VALUES (1,1,'Guitar, Vocals',1965,1968),(1,2,'Bass, Vocals',1965,1985),(1,3,'Guitar, Vocals',1968,1995),(1,4,'Drums',1965,1995),(1,5,'Keyboards, Vocals',1965,1981),(2,6,'Vocals',1999,2017),(2,7,'Vocals, Rap, Keyboards',1996,NULL),(2,8,'Guitar',1996,NULL),(2,9,'Drums',1996,2017),(2,10,'Turntables, Samples',1996,NULL),(2,11,'Bass',1996,NULL),(3,12,'Vocals',1997,2013),(3,13,'Bass',1997,NULL),(3,14,'Drums',1997,NULL),(3,15,'Guitar',2003,NULL),(3,16,'Vocals',2013,NULL),(4,17,'Vocals, Keyboards',2013,NULL),(4,18,'Guitar',2013,NULL),(4,19,'Drums',2013,NULL),(4,20,'Bass, Keyboards',2013,NULL),(8,21,'Vocals',1990,NULL),(8,22,'Guitar',1990,NULL),(8,23,'Drums',1990,NULL),(8,24,'Bass',1995,NULL),(8,25,'Bass',1990,1995),(11,26,'Vocals',1988,NULL),(11,27,'Guitar',1988,2020),(12,28,'Vocals',1968,1980),(12,29,'Guitar',1968,1980),(12,30,'Bass, Keyboards',1968,1980),(12,31,'Drums',1968,1980),(13,32,'Vocals, Guitar',1999,NULL),(13,33,'Guitar',1999,2010),(13,34,'Bass',1999,2010),(13,35,'Drums',1999,2005),(14,36,'Production, Programming',1993,2021),(14,37,'Production, Programming',1993,2021),(15,38,'Vocals, Guitar',1960,1970),(15,39,'Bass, Vocals',1960,1970),(15,40,'Guitar',1960,1970),(15,41,'Drums',1962,1970);
/*!40000 ALTER TABLE `band_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `genre_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`genre_id`),
  UNIQUE KEY `uq_genres_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (61,'Abstract Hip-Hop'),(59,'Alt Rock'),(13,'Alternatif et Indé'),(14,'Alternative'),(56,'Alternative country'),(22,'Alternative Metal'),(17,'Alternative Rock'),(27,'Ambient'),(8,'Art Rock'),(46,'Avant-Garde'),(9,'Blues'),(47,'Blues Rock'),(4,'Classic Rock'),(48,'Comedy'),(50,'Comedy Rock'),(37,'Dance'),(36,'Dance-Pop'),(49,'Doo-Wop'),(64,'Downtempo'),(53,'Dream pop'),(33,'Dubstep'),(62,'East Coast Hip-Hop'),(35,'Edm'),(38,'Electro'),(39,'Electro House'),(18,'Electronic'),(28,'Electronic Rock'),(65,'Electropop'),(10,'Experimental'),(5,'Folk Rock'),(66,'French House'),(34,'Future Bass'),(24,'Grunge'),(15,'Hard Rock'),(23,'Heavy Metal'),(40,'Hip Hop'),(60,'Hip-Hop'),(45,'House'),(20,'Jazz'),(32,'Melodic Dubstep'),(21,'Metal'),(30,'Metalcore'),(54,'Neo-psychedelia'),(25,'New Age'),(26,'Nu Metal'),(12,'Pop'),(16,'Post-Grunge'),(29,'Post-Hardcore'),(52,'Post-Metal'),(11,'Progressive'),(41,'Progressive House'),(51,'Progressive Metal'),(3,'Progressive Rock'),(2,'Psychedelic'),(57,'Psychedelic folk'),(6,'Psychedelic Rock'),(63,'Rap'),(1,'Rock'),(58,'Shoegaze'),(55,'Slowcore'),(7,'Space Rock'),(42,'Tech House'),(44,'Techno'),(19,'Trance'),(31,'Trap Edm'),(43,'Unknown');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `people` (
  `person_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(200) NOT NULL,
  `stage_name` varchar(200) DEFAULT NULL,
  `biography` text,
  `photo_url` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`person_id`),
  KEY `idx_people_full_name` (`full_name`),
  KEY `idx_people_stage_name` (`stage_name`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (1,'Syd Barrett',NULL,'English singer, guitarist, and original creative force of Pink Floyd.',NULL),(2,'Roger Waters',NULL,'English bassist, lyricist, and co-founder of Pink Floyd.',NULL),(3,'David Gilmour',NULL,'English guitarist and vocalist of Pink Floyd.',NULL),(4,'Nick Mason',NULL,'English drummer and co-founder of Pink Floyd.',NULL),(5,'Richard Wright',NULL,'English keyboardist and co-founder of Pink Floyd.',NULL),(6,'Chester Bennington',NULL,'American singer, lead vocalist of Linkin Park from 1999 until his death in 2017.',NULL),(7,'Mike Shinoda',NULL,'American musician, rapper, and producer, co-founder of Linkin Park.',NULL),(8,'Brad Delson',NULL,'American guitarist and founding member of Linkin Park.',NULL),(9,'Rob Bourdon',NULL,'American drummer and founding member of Linkin Park (1996-2017).',NULL),(10,'Joe Hahn',NULL,'American DJ, turntablist, and founding member of Linkin Park.',NULL),(11,'Dave Farrell',NULL,'American bassist and founding member of Linkin Park.',NULL),(12,'Adam Gontier',NULL,'Canadian singer, original lead vocalist of Three Days Grace (1997-2013).',NULL),(13,'Brad Walst',NULL,'Canadian bassist and founding member of Three Days Grace.',NULL),(14,'Neil Sanderson',NULL,'Canadian drummer and founding member of Three Days Grace.',NULL),(15,'Barry Stock',NULL,'Canadian guitarist, joined Three Days Grace in 2003.',NULL),(16,'Matt Walst',NULL,'Canadian singer, lead vocalist of Three Days Grace since 2013.',NULL),(17,'Dustin Bates',NULL,'American singer, songwriter, and founder of STARSET.',NULL),(18,'Brock Richards',NULL,'American guitarist of STARSET.',NULL),(19,'Adam Gilbert',NULL,'American drummer of STARSET.',NULL),(20,'Ron DeChant',NULL,'American bassist and keyboardist of STARSET.',NULL),(21,'Maynard James Keenan',NULL,'American singer and primary lyricist of Tool.',NULL),(22,'Adam Jones',NULL,'American guitarist and founding member of Tool.',NULL),(23,'Danny Carey',NULL,'American drummer and founding member of Tool.',NULL),(24,'Justin Chancellor',NULL,'English bassist of Tool, joined in 1995.',NULL),(25,'Paul D\'Amour',NULL,'American bassist, original member of Tool (1990-1995).',NULL),(26,'Hope Sandoval',NULL,'American singer and lyricist of Mazzy Star.',NULL),(27,'David Roback',NULL,'American guitarist and co-founder of Mazzy Star.',NULL),(28,'Robert Plant',NULL,'English singer and lyricist of Led Zeppelin.',NULL),(29,'Jimmy Page',NULL,'English guitarist and producer of Led Zeppelin.',NULL),(30,'John Paul Jones',NULL,'English bassist and keyboardist of Led Zeppelin.',NULL),(31,'John Bonham',NULL,'English drummer of Led Zeppelin.',NULL),(32,'Benjamin Burnley',NULL,'American singer, guitarist, and founder of Breaking Benjamin.',NULL),(33,'Aaron Fink',NULL,'American guitarist, former member of Breaking Benjamin.',NULL),(34,'Mark Klepaski',NULL,'American bassist, former member of Breaking Benjamin.',NULL),(35,'Jeremy Hummel',NULL,'American drummer, former member of Breaking Benjamin.',NULL),(36,'Thomas Bangalter',NULL,'French musician and producer, one half of Daft Punk.',NULL),(37,'Guy-Manuel de Homem-Christo',NULL,'French musician and producer, one half of Daft Punk.',NULL),(38,'John Lennon',NULL,'English singer, songwriter, and founding member of The Beatles.',NULL),(39,'Paul McCartney',NULL,'English singer, songwriter, and founding member of The Beatles.',NULL),(40,'George Harrison',NULL,'English guitarist and founding member of The Beatles.',NULL),(41,'Ringo Starr',NULL,'English drummer and member of The Beatles.',NULL);
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tracks`
--

DROP TABLE IF EXISTS `tracks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tracks` (
  `track_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `album_id` bigint unsigned NOT NULL,
  `track_number` smallint unsigned DEFAULT NULL,
  `duration_seconds` int unsigned DEFAULT NULL,
  PRIMARY KEY (`track_id`),
  UNIQUE KEY `uq_track_number_per_album` (`album_id`,`track_number`),
  KEY `idx_tracks_name` (`name`),
  KEY `idx_tracks_album` (`album_id`),
  CONSTRAINT `fk_tracks_album` FOREIGN KEY (`album_id`) REFERENCES `albums` (`album_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1046 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tracks`
--

LOCK TABLES `tracks` WRITE;
/*!40000 ALTER TABLE `tracks` DISABLE KEYS */;
INSERT INTO `tracks` VALUES (1,'Let There Be More Light',1,1,337),(2,'Remember a Day',1,2,273),(3,'Set the Controls for the Heart of the Sun',1,3,328),(4,'Corporal Clegg',1,4,253),(5,'A Saucerful of Secrets',1,5,717),(6,'See‐Saw',1,6,277),(7,'Jugband Blues',1,7,181),(8,'Pigs on the Wing, Part 1',2,1,86),(9,'Dogs',2,2,1025),(10,'Pigs (Three Different Ones)',2,3,686),(11,'Sheep',2,4,619),(12,'Pigs on the Wing, Part 2',2,5,89),(13,'Atom Heart Mother',3,1,1424),(14,'If',3,2,270),(15,'Summer \'68',3,3,329),(16,'Fat Old Sun',3,4,322),(17,'Alan\'s Psychedelic Breakfast',3,5,780),(18,'One of These Days',4,1,359),(19,'A Pillow of Winds',4,2,311),(20,'Fearless',4,3,369),(21,'San Tropez',4,4,224),(22,'Seamus',4,5,137),(23,'Echoes',4,6,1411),(24,'Cirrus Minor',5,1,318),(25,'The Nile Song',5,2,207),(26,'Crying Song',5,3,214),(27,'Up the Khyber',5,4,133),(28,'Green Is the Colour',5,5,179),(29,'Cymbaline',5,6,290),(30,'Party Sequence',5,7,67),(31,'Main Theme',5,8,328),(32,'Ibiza Bar',5,9,199),(33,'More Blues',5,10,133),(34,'Quicksilver',5,11,434),(35,'A Spanish Piece',5,12,65),(36,'Dramatic Theme',5,13,135),(37,'Speak to Me',6,1,68),(38,'Breathe',6,2,169),(39,'On the Run',6,3,231),(40,'Time',6,4,410),(41,'The Great Gig in the Sky',6,5,284),(42,'Money',6,6,383),(43,'Us and Them',6,7,470),(44,'Any Colour You Like',6,8,206),(45,'Brain Damage',6,9,227),(46,'Eclipse',6,10,132),(47,'Cluster One',7,1,356),(48,'What Do You Want From Me',7,2,262),(49,'Poles Apart',7,3,423),(50,'Marooned',7,4,330),(51,'A Great Day for Freedom',7,5,257),(52,'Wearing the Inside Out',7,6,409),(53,'Take It Back',7,7,372),(54,'Coming Back to Life',7,8,379),(55,'Keep Talking',7,9,371),(56,'Lost for Words',7,10,315),(57,'High Hopes',7,11,511),(58,'Astronomy Domine',8,1,253),(59,'Lucifer Sam',8,2,187),(60,'Matilda Mother',8,3,189),(61,'Flaming',8,4,166),(62,'Pow R. Toc H.',8,5,266),(63,'Take Up Thy Stethoscope and Walk',8,6,186),(64,'Interstellar Overdrive',8,7,581),(65,'The Gnome',8,8,134),(66,'Chapter 24',8,9,222),(67,'The Scarecrow',8,10,131),(68,'Bike',8,11,204),(69,'In the Flesh?',9,1,200),(70,'The Thin Ice',9,2,147),(71,'Another Brick in the Wall, Part 1',9,3,192),(72,'The Happiest Days of Our Lives',9,4,111),(73,'Another Brick in the Wall, Part 2',9,5,239),(74,'Mother',9,6,335),(75,'Goodbye Blue Sky',9,7,167),(76,'Empty Spaces',9,8,128),(77,'Young Lust',9,9,210),(78,'One of My Turns',9,10,217),(79,'Don\'t Leave Me Now',9,11,256),(80,'Another Brick in the Wall, Part 3',9,12,74),(81,'Goodbye Cruel World',9,13,77),(82,'Hey You',9,201,280),(83,'Is There Anybody Out There?',9,202,162),(84,'Nobody Home',9,203,203),(85,'Vera',9,204,93),(86,'Bring the Boys Back Home',9,205,87),(87,'Comfortably Numb',9,206,382),(88,'The Show Must Go On',9,207,97),(89,'In the Flesh',9,208,256),(90,'Run Like Hell',9,209,264),(91,'Waiting for the Worms',9,210,237),(92,'Stop',9,211,31),(93,'The Trial',9,212,319),(94,'Outside the Wall',9,213,106),(95,'Shine On You Crazy Diamond, Parts 1–5',10,1,813),(96,'Welcome to the Machine',10,2,452),(97,'Have a Cigar',10,3,308),(98,'Wish You Were Here',10,4,335),(99,'Shine On You Crazy Diamond, Parts 6–9',10,5,750),(100,'Papercut',11,1,184),(101,'One Step Closer',11,2,156),(102,'With You',11,3,203),(103,'Points of Authority',11,4,200),(104,'Crawling',11,5,209),(105,'Runaway',11,6,184),(106,'By Myself',11,7,190),(107,'In the End',11,8,216),(108,'A Place for My Head',11,9,185),(109,'Forgotten',11,10,194),(110,'Cure for the Itch',11,11,157),(111,'Pushing Me Away',11,12,192),(112,'My December',11,13,261),(113,'High Voltage',11,14,225),(114,'Foreword',12,1,13),(115,'Don\'t Stay',12,2,188),(116,'Somewhere I Belong',12,3,214),(117,'Lying From You',12,4,175),(118,'Hit the Floor',12,5,164),(119,'Easier to Run',12,6,204),(120,'Faint',12,7,162),(121,'Figure.09',12,8,198),(122,'Breaking the Habit',12,9,196),(123,'From the Inside',12,10,176),(124,'Nobody\'s Listening',12,11,179),(125,'Session',12,12,145),(126,'Numb',12,13,188),(127,'Wake',13,1,101),(128,'Given Up',13,2,189),(129,'Leave Out All the Rest',13,3,209),(130,'Bleed It Out',13,4,164),(131,'Shadow of the Day',13,5,290),(132,'What I\'ve Done',13,6,205),(133,'Hands Held High',13,7,233),(134,'No More Sorrow',13,8,222),(135,'Valentine\'s Day',13,9,197),(136,'In Between',13,10,197),(137,'In Pieces',13,11,218),(138,'The Little Things Give You Away',13,12,384),(139,'No Roads Left',13,213,229),(140,'Across the Line',13,214,190),(141,'Given Up  (Third Encore Session)',13,15,189),(142,'What I\'ve Done  (Distorted Remix)',13,216,228),(143,'The Requiem',14,1,121),(144,'The Radiance',14,2,58),(145,'Burning in the Skies',14,3,253),(146,'Empty Spaces',14,4,18),(147,'When They Come for Me',14,5,293),(148,'Robot Boy',14,6,269),(149,'Jornada del Muerto',14,7,95),(150,'Waiting for the End',14,8,232),(151,'Blackout',14,9,279),(152,'Wretches and Kings',14,10,251),(153,'Wisdom, Justice, and Love',14,11,99),(154,'Iridescent',14,12,297),(155,'Fallout',14,13,83),(156,'The Catalyst',14,14,340),(157,'The Messenger',14,15,182),(158,'Lost in the Echo',15,1,205),(159,'In My Remains',15,2,201),(160,'Burn It Down',15,3,230),(161,'Lies Greed Misery',15,4,146),(162,'I\'ll Be Gone',15,5,211),(163,'Castle of Glass',15,6,205),(164,'Victimized',15,7,106),(165,'Roads Untraveled',15,8,230),(166,'Skin to Bone',15,9,168),(167,'Until It Breaks',15,10,223),(168,'Tinfoil',15,11,72),(169,'Powerless',15,12,224),(170,'Keys to the Kingdom',16,1,219),(171,'All for Nothing',16,2,214),(172,'Guilty All the Same',16,3,355),(173,'The Summoning',16,4,60),(174,'War',16,5,131),(175,'Wastelands',16,6,196),(176,'Until It\'s Gone',16,7,233),(177,'Rebellion',16,8,224),(178,'Mark the Graves',16,9,305),(179,'Drawbar',16,10,167),(180,'Final Masquerade',16,11,218),(181,'A Line in the Sand',16,12,395),(182,'Nobody Can Save Me',17,1,226),(183,'Good Goodbye',17,2,211),(184,'Talking to Myself',17,3,231),(185,'Battle Symphony',17,4,216),(186,'Invisible',17,5,214),(187,'Heavy',17,6,170),(188,'Sorry for Now',17,7,204),(189,'Halfway Right',17,8,217),(190,'One More Light',17,9,255),(191,'Sharp Edges',17,10,178),(192,'From Zero (Intro)',18,1,22),(193,'The Emptiness Machine',18,2,190),(194,'Cut the Bridge',18,3,229),(195,'Heavy Is the Crown',18,4,167),(196,'Over Each Other',18,5,170),(197,'Casualty',18,6,141),(198,'Overflow',18,7,211),(199,'Two Faced',18,8,184),(200,'Stained',18,9,185),(201,'IGYEIH',18,10,209),(202,'Good Things Go',18,11,210),(203,'Dominate',19,1,195),(204,'Apologies',19,2,187),(205,'Mayday',19,3,203),(206,'Kill Me Fast',19,4,197),(207,'In Waves',19,5,205),(208,'Alienation',19,6,176),(209,'Never Ordinary',19,7,228),(210,'Deathwish',19,8,193),(211,'Don\'t Wanna Go Home Tonight',19,9,211),(212,'In Cold Blood',19,10,194),(213,'The Power',19,11,217),(214,'Another Relapse',19,12,300),(215,'So Called Life',20,1,207),(216,'I Am the Weapon',20,2,176),(217,'Neurotic',20,3,197),(218,'Lifetime',20,4,176),(219,'A Scar Is Born',20,5,213),(220,'Souvenirs',20,6,190),(221,'No Tomorrow',20,7,173),(222,'Redemption',20,8,191),(223,'Champion',20,9,182),(224,'Chain of Abuse',20,10,186),(225,'Someone to Talk To',20,11,174),(226,'Explosions',20,12,207),(227,'Human Race',21,1,249),(228,'Painkiller',21,2,179),(229,'Fallen Angel',21,3,186),(230,'Landmine',21,4,206),(231,'Tell Me Why',21,5,211),(232,'I Am Machine',21,6,200),(233,'So What',21,7,178),(234,'Car Crash',21,8,171),(235,'Nothing\'s Fair in Love and War',21,9,225),(236,'One Too Many',21,10,161),(237,'The End Is Not the Answer',21,11,173),(238,'The Real You',21,12,236),(239,'Bitter Taste',22,1,241),(240,'Break',22,2,193),(241,'World So Cold',22,3,243),(242,'Lost in You',22,4,233),(243,'The Good Life',22,5,173),(244,'No More',22,6,225),(245,'Last to Know',22,7,207),(246,'Someone Who Cares',22,8,292),(247,'Bully',22,9,219),(248,'Without You',22,10,214),(249,'Goin\' Down',22,11,186),(250,'Life Starts Now',22,12,188),(251,'It\'s All Over',23,1,249),(252,'Pain',23,2,203),(253,'Animal I Have Become',23,3,231),(254,'Never Too Late',23,4,209),(255,'On My Own',23,5,186),(256,'Riot',23,6,208),(257,'Get Out Alive',23,7,262),(258,'Let It Die',23,8,189),(259,'Over and Over',23,9,192),(260,'Time of Dying',23,10,186),(261,'Gone Forever',23,11,221),(262,'One‐X',23,12,286),(263,'Right Left Wrong',24,1,237),(264,'The Mountain',24,2,198),(265,'I Am an Outsider',24,3,162),(266,'Infra‐Red',24,4,231),(267,'Nothing to Lose but You',24,5,172),(268,'Me Against You',24,6,209),(269,'Love Me or Leave Me',24,7,184),(270,'Strange Days',24,8,191),(271,'Villain I\'m Not',24,9,176),(272,'Chasing the First Time',24,10,176),(273,'The New Real',24,11,181),(274,'The Abyss',24,12,250),(275,'Burn',25,1,267),(276,'Just Like You',25,2,187),(277,'I Hate Everything About You',25,3,231),(278,'Home',25,4,261),(279,'Scared',25,5,193),(280,'Let You Down',25,6,225),(281,'Now or Never',25,7,181),(282,'Born Like This',25,8,212),(283,'Drown',25,9,208),(284,'Wake Up',25,10,204),(285,'Take Me Under',25,11,259),(286,'Overrated',25,12,211),(287,'I Hate Everything About You (live acoustic)',25,13,240),(288,'Are You Ready',25,14,166),(289,'Drown (live acoustic)',25,15,245),(290,'Sign of the Times',26,1,191),(291,'Chalk Outline',26,2,182),(292,'The High Road',26,3,194),(293,'Operate',26,4,203),(294,'Anonymous',26,5,194),(295,'Misery Loves My Company',26,6,162),(296,'Give in to Me',26,7,199),(297,'Happiness',26,8,174),(298,'Give Me a Reason',26,9,243),(299,'Time That Remains',26,10,192),(300,'Expectations',26,11,163),(301,'Broken Glass',26,12,201),(302,'Unbreakable Heart',26,13,206),(303,'A BRIEF HISTORY OF THE FUTURE',27,1,98),(304,'MANIFEST',27,2,267),(305,'ECHO',27,3,217),(306,'WHERE THE SKIES END',27,4,394),(307,'PERFECT MACHINE',27,5,324),(308,'TELEKINETIC',27,6,313),(309,'STRATOSPHERE',27,7,257),(310,'FAULTLINE',27,8,216),(311,'SOLSTICE',27,9,341),(312,'TRIALS',27,10,259),(313,'WAKING UP',27,11,229),(314,'OTHER WORLDS THAN THESE',27,12,258),(315,'DIVING BELL',27,13,338),(316,'praesens',28,1,121),(317,'DEGENERATE',28,2,217),(318,'SILOS',28,3,261),(319,'rise of messenger',28,4,134),(320,'DARK THINGS',28,5,281),(321,'SHATTERED DREAMS',28,6,250),(322,'temple of milton',28,7,128),(323,'BRAVE NEW WORLD',28,8,264),(324,'DYSTOPIA',28,9,277),(325,'HEAD OVER HEELS',28,10,298),(326,'SWAY',28,11,258),(327,'the antihero\'s journey',28,12,104),(328,'TOKSIK',28,13,231),(329,'at his altar',28,14,101),(330,'AD ASTRA',28,15,276),(331,'requiem of the order',28,16,236),(332,'First Light',29,1,84),(333,'Down With the Fallen',29,2,258),(334,'Halo',29,3,226),(335,'Carnivore',29,4,263),(336,'Telescope',29,5,331),(337,'It Has Begun',29,6,317),(338,'My Demons',29,7,288),(339,'Antigravity',29,8,369),(340,'Dark on Me',29,9,338),(341,'Let It Die',29,10,272),(342,'The Future Is Now',29,11,286),(343,'Point of No Return',29,12,220),(344,'Rise and Fall',29,13,354),(345,'Let It Die (Maniac Agenda remix)',29,14,452),(346,'The Order',30,1,68),(347,'Satellite',30,2,239),(348,'Frequency',30,3,281),(349,'Die for You',30,4,317),(350,'Ricochet',30,5,310),(351,'Starlight',30,6,287),(352,'Into the Unknown',30,7,270),(353,'Gravity of You',30,8,286),(354,'Back to the Earth',30,9,253),(355,'Last to Fall',30,10,303),(356,'Bringing It Down',30,11,348),(357,'Unbecoming',30,12,250),(358,'Monster',30,13,256),(359,'Telepathic',30,14,282),(360,'Everglow',30,15,476),(361,'Odyssey',31,1,37),(362,'Into the Dark',31,2,261),(363,'Forever',31,3,171),(364,'With Your Love',31,4,182),(365,'Feels Like You',31,5,212),(366,'In My Arms',31,6,208),(367,'Don\'t Want Your Love',31,7,192),(368,'Slave to the Rithm',31,8,269),(369,'War',31,9,185),(370,'I\'ll Come Runnin',31,10,222),(371,'Take Me Back',31,11,183),(372,'Love Is a Chemical',31,12,218),(373,'Feel Alive',31,13,168),(374,'Monster',31,14,160),(375,'Refuge',31,15,202),(376,'Not Ordinary',31,16,154),(377,'Paris',31,17,170),(378,'To the Moon',31,18,269),(379,'Ur Alive',31,19,210),(380,'Reverie',32,1,300),(381,'Fortress',32,2,204),(382,'With You',32,3,186),(383,'Sleepwalker',32,4,250),(384,'It\'s All on U',32,5,204),(385,'Spirals',32,6,362),(386,'Without You',32,7,232),(387,'Only One',32,8,252),(388,'I\'ll Be Your Reason',32,9,220),(389,'Afterlife',32,10,364),(390,'Jester',32,11,182),(391,'Bring Forth the Pressure',32,12,165),(392,'Needed You',33,1,306),(393,'Crawl Outta Love',33,2,242),(394,'No Time Like Now',33,3,123),(395,'Free Fall',33,4,206),(396,'Where\'d U Go',33,5,185),(397,'Fractures',33,6,245),(398,'Leaving',33,7,235),(399,'Lost',33,8,200),(400,'Sound of Walking Away',33,9,253),(401,'Taking Me Higher',33,10,165),(402,'Feel Good',33,11,248),(403,'Beautiful Creatures',33,12,241),(404,'Let You Go',33,13,184),(405,'Blame Myself',34,1,231),(406,'Heavenly Side',34,2,244),(407,'Fragments',34,3,210),(408,'Sideways',34,4,252),(409,'First Time',34,5,166),(410,'U & Me',34,6,214),(411,'Nightlight',34,7,222),(412,'Hearts on Fire',34,8,236),(413,'Lay It Down',34,9,265),(414,'Losing Patience',34,10,231),(415,'In My Mind',34,11,300),(416,'Paper Thin',34,12,197),(417,'Crazy Times',34,13,230),(418,'Brave Soul',34,14,277),(419,'I Care (intro)',35,1,33),(420,'Hold On',35,2,235),(421,'Good Things Fall Apart',35,3,217),(422,'That\'s Why',35,4,253),(423,'Blood',35,5,248),(424,'Take You Down',35,6,221),(425,'All Together',35,7,239),(426,'Crashing',35,8,230),(427,'Broken Ones',35,9,198),(428,'Every Piece of Me',35,10,223),(429,'Takeaway',35,11,210),(430,'Sad Songs',35,12,210),(431,'Pray',35,13,296),(432,'In Your Arms',35,14,221),(433,'Gorgeous',35,15,277),(434,'Angel (Lonely prelude)',35,16,41),(435,'Lonely',35,17,271),(436,'Starfall',36,1,256),(437,'All That Really Matters',36,2,244),(438,'Worst Day',36,3,167),(439,'From the Ashes',36,4,254),(440,'Lifeline',36,5,200),(441,'Eyes Wide Shut',36,6,152),(442,'Shivering',36,7,301),(443,'You Were Right',36,8,235),(444,'Insanity',36,9,183),(445,'Drwn',36,10,220),(446,'Other Side',36,11,212),(447,'I Want U 2 (Stay)',36,12,210),(448,'With All My Heart',36,13,178),(449,'Back To You',36,14,187),(450,'Nothing Ever After',36,15,236),(451,'Luv Me a Little',36,16,225),(452,'Superliminal',37,1,375),(453,'Channel 42',37,2,289),(454,'The Veldt (8 minute edit)',37,3,506),(455,'Fn Pig',37,4,523),(456,'Professional Griefers (vocal mix)',37,5,245),(457,'Maths',37,6,398),(458,'There might be coffee',37,7,421),(459,'Take care of the proper paperwork',37,8,412),(460,'Closer',37,9,419),(461,'October',37,10,431),(462,'Sleepless',37,11,247),(463,'Failbait',37,12,289),(464,'Telemiscommunications',37,13,241),(465,'FML',38,1,404),(466,'Moar Ghosts \'n\' Stuff',38,2,277),(467,'Ghosts \'n\' Stuff',38,3,180),(468,'Hi Friend!',38,4,315),(469,'Bot',38,5,339),(470,'Word Problems',38,6,437),(471,'Soma',38,7,383),(472,'Lack of a Better Name',38,8,388),(473,'The 16th Hour',38,9,600),(474,'Strobe',38,10,635),(475,'Alive',39,1,309),(476,'Sacrifice',39,2,280),(477,'Escape',39,3,240),(478,'Bright Lights',39,4,203),(479,'pwdr Blu',39,5,216),(480,'When I Talk',39,6,208),(481,'Eat Sleep',39,7,271),(482,'Take Me High',39,8,255),(483,'Avalanche',39,9,261),(484,'Unobsidian',39,10,372),(485,'Sometimes Things Get, Whatever',40,1,434),(486,'Complications',40,2,329),(487,'Slip',40,3,406),(488,'Some Kind of Blue',40,4,390),(489,'Brazil (2nd edit)',40,5,323),(490,'Alone With You',40,6,450),(491,'I Remember',40,7,548),(492,'Faxing Berlin (piano acoustic version)',40,8,105),(493,'Faxing Berlin',40,9,150),(494,'Not Exactly',40,10,480),(495,'Arguru',40,11,330),(496,'So There I Was',40,12,406),(497,'When the Summer Dies',41,1,330),(498,'Avaritia',42,1,403),(499,'Coelacanth I',42,2,166),(500,'Ice Age (deadmau5 remix)',42,3,412),(501,'My Pet Coelacanth',42,4,495),(502,'Infra Turbo Pigcart Racer',42,5,576),(503,'Terrors in My Head',42,6,518),(504,'Creep',42,7,338),(505,'Somewhere Up Here',42,8,310),(506,'Phantoms Can\'t Hang',42,9,556),(507,'Gula',42,10,416),(508,'Acedia',42,201,386),(509,'Invidia',42,202,197),(510,'Errors in My Bread',42,203,318),(511,'Survivalism (deadmau5 remix)',42,204,218),(512,'Silent Picture',42,205,218),(513,'Rlyehs Lament',42,206,289),(514,'Superbia',42,207,134),(515,'Mercedes',42,208,578),(516,'Bleed',42,209,241),(517,'Ira',42,210,158),(518,'Monday',42,211,226),(519,'A Moment to Myself',42,212,208),(520,'Pets',42,213,451),(521,'Coelacanth II',42,214,156),(522,'Seeya',42,215,400),(523,'Don’t Eat the Yellow Snow',43,1,125),(524,'Nanook Rubs It',43,2,277),(525,'St. Alfonzo’s Pancake Breakfast',43,3,110),(526,'Father O\'Blivion',43,4,138),(527,'Cosmik Debris',43,5,257),(528,'Excentrifugal Forz',43,6,93),(529,'Apostrophe’',43,7,350),(530,'Uncle Remus',43,8,170),(531,'Stink‐Foot',43,9,401),(532,'The Central Scrutinizer',44,1,208),(533,'Joe\'s Garage',44,2,370),(534,'Catholic Girls',44,3,260),(535,'Crew Slut',44,4,398),(536,'On the Bus',44,6,272),(537,'Why Does It Hurt When I Pee?',44,7,143),(538,'Lucille Has Messed My Mind Up',44,8,343),(539,'Scrutinizer Postlude',44,9,95),(540,'Fembot in a Wet T‐Shirt',44,5,285),(541,'A Token of My Extreme',44,10,330),(542,'Stick It Out',44,11,274),(543,'Sy Borg',44,12,536),(544,'Dong Work for Yuda',44,201,304),(545,'Keep It Greasey',44,202,502),(546,'Outside Now',44,203,350),(547,'He Used to Cut the Grass',44,204,515),(548,'Packard Goose',44,205,691),(549,'Watermelon in Easter Hay',44,206,545),(550,'A Little Green Rosetta',44,207,495),(551,'Peaches en Regalia',45,1,219),(552,'Willie the Pimp',45,2,563),(553,'Son of Mr. Green Genes',45,3,537),(554,'Little Umbrellas',45,4,189),(555,'The Gumbo Variations',45,5,774),(556,'It Must Be a Camel',45,6,317),(557,'I Have Been in You',46,1,214),(558,'Flakes',46,2,400),(559,'Broken Hearts Are for Assholes',46,3,222),(560,'I’m So Cute',46,4,268),(561,'Jones Crusher',46,5,170),(562,'Whatever Happened to All the Fun in the World',46,6,33),(563,'Rat Tomango',46,7,315),(564,'Wait a Minute',46,8,33),(565,'Bobby Brown Goes Down',46,9,169),(566,'Rubber Shirt',46,10,165),(567,'The Sheik Yerbouti Tango',46,11,236),(568,'Baby Snakes',46,12,110),(569,'Tryin’ to Grow a Chin',46,13,212),(570,'City of Tiny Lites',46,14,330),(571,'Dancin’ Fool',46,15,223),(572,'Jewish Princess',46,16,198),(573,'Wild Love',46,17,249),(574,'Yo\' Mama',46,18,761),(575,'Intolerance',47,1,293),(576,'Prison Sex',47,2,296),(577,'Sober',47,3,307),(578,'Bottom',47,4,434),(579,'Crawl Away',47,5,330),(580,'Swamp Song',47,6,332),(581,'Undertow',47,7,322),(582,'4°',47,8,363),(583,'Flood',47,9,466),(584,'Disgustipated',47,10,948),(585,'Stinkfist',48,1,311),(586,'Eulogy',48,2,508),(587,'H.',48,3,367),(588,'Useful Idiot',48,4,39),(589,'Forty Six & 2',48,5,365),(590,'Message to Harry Manback',48,6,113),(591,'Hooker With a Penis',48,7,274),(592,'Intermission',48,8,56),(593,'jimmy',48,9,324),(594,'Die Eier von Satan',48,10,137),(595,'Pushit',48,11,596),(596,'Cesaro Summability',48,12,86),(597,'Ænema',48,13,399),(598,'(‐) Ions',48,14,240),(599,'Third Eye',48,15,829),(600,'The Grudge',49,1,516),(601,'Eon Blue Apocalypse',49,2,65),(602,'The Patient',49,3,434),(603,'Mantra',49,4,73),(604,'Schism',49,5,408),(605,'Parabol',49,6,184),(606,'Parabola',49,7,364),(607,'Ticks & Leeches',49,8,490),(608,'Lateralus',49,9,564),(609,'Disposition',49,10,286),(610,'Reflection',49,11,668),(611,'Triad',49,12,527),(612,'Faaip de Oiad',49,13,159),(613,'Vicarious',50,1,427),(614,'Jambi',50,2,449),(615,'Wings for Marie, Pt 1',50,3,371),(616,'10,000 Days (Wings, Pt 2)',50,4,674),(617,'The Pot',50,5,382),(618,'Lipan Conjuring',50,6,71),(619,'Lost Keys (Blame Hofmann)',50,7,226),(620,'Rosetta Stoned',50,8,671),(621,'Intension',50,9,441),(622,'Right in Two',50,10,536),(623,'Viginti Tres',50,11,303),(624,'Destroid 1 Raise Your Fist',51,1,283),(625,'Destroid 2 Wasteland',51,2,278),(626,'Destroid 3 Crusaders',51,3,329),(627,'Destroid 4 Flip the Switch',51,4,199),(628,'Destroid 5 Activation',51,5,209),(629,'Destroid 6 Put It Down',51,6,207),(630,'Destroid 7 Bounce',51,7,261),(631,'Destroid 8 Annihilate',51,8,310),(632,'Destroid 9 Blast Off',51,9,270),(633,'Destroid 10 Funk Hole',51,10,279),(634,'Exterminate',52,1,214),(635,'1 on 1',52,2,199),(636,'Wake Up',52,3,339),(637,'Tonight',52,4,271),(638,'Gold (Stupid Love)',52,5,296),(639,'Fall',52,6,237),(640,'Home',52,7,237),(641,'Where Are You',52,8,185),(642,'Power',52,9,242),(643,'Vault',52,10,298),(644,'Die for You',52,11,239),(645,'Hoods Up',52,12,240),(646,'Fight Through the Pain',52,13,252),(647,'Rumble',52,14,283),(648,'Name Drop',53,1,229),(649,'Reasons',53,2,240),(650,'Titans',53,3,210),(651,'Don\'t Look Down (Hold On)',53,4,245),(652,'Zombie',54,1,285),(653,'Decimate',55,1,222),(654,'Hypnosis',55,2,220),(655,'Our Fire',55,3,260),(656,'Osiris',55,4,246),(657,'The Last Elder',55,5,203),(658,'Cough Drop',55,6,191),(659,'End of the World',55,7,222),(660,'Back to Life',55,8,200),(661,'Demisaur',55,9,213),(662,'Clockwork',55,10,188),(663,'Encounter',55,11,205),(664,'Salvation',55,12,250),(665,'Run This',55,13,230),(666,'Plague Doctor',55,14,193),(667,'Temporary Blue',55,15,203),(668,'Reborn',55,16,185),(669,'Crusher',55,17,153),(670,'Disappear',56,1,245),(671,'Flowers in December',56,2,298),(672,'Rhymes of an Hour',56,3,253),(673,'Cry, Cry',56,4,238),(674,'Take Everything',56,5,294),(675,'Still Cold',56,6,288),(676,'All Your Sisters',56,7,317),(677,'I\'ve Been Let Down',56,8,198),(678,'Roseblood',56,9,291),(679,'Happy',56,10,239),(680,'Umbilical',56,11,299),(681,'Look on Down From the Bridge',56,12,287),(682,'In the Kingdom',57,1,315),(683,'California',57,2,323),(684,'I\'ve Gotta Stop',57,3,245),(685,'Does Someone Have Your Baby Now?',57,4,249),(686,'Common Burn',57,5,310),(687,'Seasons of Your Day',57,6,221),(688,'Lay Myself Down',57,7,272),(689,'Sparrow',57,8,245),(690,'Spoon',57,9,370),(691,'Flying Low',57,10,456),(692,'Halah',58,1,196),(693,'Blue Flower',58,2,215),(694,'Ride It On',58,3,181),(695,'She Hangs Brightly',58,4,384),(696,'I\'m Sailin\'',58,5,193),(697,'Give You My Lovin\'',58,6,230),(698,'Be My Angel',58,7,197),(699,'Taste of Blood',58,8,337),(700,'Ghost Highway',58,9,208),(701,'Free',58,10,191),(702,'Before I Sleep',58,11,130),(703,'Fade Into You',59,1,296),(704,'Bells Ring',59,2,272),(705,'Mary of Silence',59,3,362),(706,'Five String Serenade',59,4,264),(707,'Blue Light',59,5,311),(708,'She’s My Baby',59,6,265),(709,'Unreflected',59,7,222),(710,'Wasted',59,8,332),(711,'Into Dust',59,9,337),(712,'So Tonight That I Might See',59,10,439),(713,'Immigrant Song',60,1,146),(714,'Friends',60,2,234),(715,'Celebration Day',60,3,210),(716,'Since I\'ve Been Loving You',60,4,443),(717,'Out on the Tiles',60,5,247),(718,'Gallows Pole',60,6,296),(719,'Tangerine',60,7,190),(720,'That\'s the Way',60,8,337),(721,'Bron‐Yr‐Aur Stomp',60,9,256),(722,'Hats Off to (Roy) Harper',60,10,223),(723,'Black Dog',61,1,298),(724,'Rock and Roll',61,2,220),(725,'The Battle of Evermore',61,3,352),(726,'Stairway to Heaven',61,4,483),(727,'Misty Mountain Hop',61,5,281),(728,'Four Sticks',61,6,284),(729,'Going to California',61,7,212),(730,'When the Levee Breaks',61,8,430),(731,'Custard Pie',62,1,254),(732,'The Rover',62,2,337),(733,'In My Time of Dying',62,3,666),(734,'Houses of the Holy',62,4,242),(735,'Trampled Under Foot',62,5,335),(736,'Kashmir',62,6,508),(737,'In the Light',62,201,527),(738,'Bron-Yr-Aur',62,202,127),(739,'Down by the Seaside',62,203,316),(740,'Ten Years Gone',62,204,391),(741,'Night Flight',62,205,217),(742,'The Wanton Song',62,206,250),(743,'Boogie With Stu',62,207,233),(744,'Black Country Woman',62,208,273),(745,'Sick Again',62,209,283),(746,'Achilles Last Stand',63,1,626),(747,'For Your Life',63,2,384),(748,'Royal Orleans',63,3,179),(749,'Nobody\'s Fault but Mine',63,4,377),(750,'Candy Store Rock',63,5,252),(751,'Hots on for Nowhere',63,6,284),(752,'Tea for One',63,7,567),(753,'Dark',64,1,130),(754,'Failure',64,2,215),(755,'Angels Fall',64,3,229),(756,'Breaking the Silence',64,4,182),(757,'Hollow',64,5,231),(758,'Close to Heaven',64,6,249),(759,'Bury Me Alive',64,7,245),(760,'Never Again',64,8,224),(761,'The Great Divide',64,9,253),(762,'Ashes of Eden',64,10,294),(763,'Defeated',64,11,205),(764,'Dawn',64,12,112),(765,'Fade Away',65,1,196),(766,'I Will Not Bow',65,2,217),(767,'Crawl',65,3,239),(768,'Give Me a Sign',65,4,258),(769,'Hopeless',65,5,200),(770,'What Lies Beneath',65,6,215),(771,'Anthem of the Angels',65,7,243),(772,'Lights Out',65,8,214),(773,'Dear Agony',65,9,258),(774,'Into the Nothing',65,10,224),(775,'Without You',65,11,258),(776,'Without You (acoustic)',65,12,223),(777,'Give Me a Sign (acoustic)',65,13,256),(778,'Intro',66,1,74),(779,'The Diary of Jane',66,2,201),(780,'Breath',66,3,218),(781,'You',66,4,202),(782,'Evil Angel',66,5,220),(783,'Until the End',66,6,253),(784,'Dance With the Devil',66,7,227),(785,'Topless',66,8,181),(786,'Here We Are',66,9,259),(787,'Unknown Soldier',66,10,226),(788,'Had Enough',66,11,228),(789,'You Fight Me',66,12,191),(790,'Outro',66,13,130),(791,'One More Time',67,1,321),(792,'Aerodynamic',67,2,208),(793,'Digital Love',67,3,298),(794,'Harder, Better, Faster, Stronger',67,4,224),(795,'Crescendolls',67,5,212),(796,'Nightvision',67,6,104),(797,'Superheroes',67,7,238),(798,'High Life',67,8,202),(799,'Something About Us',67,9,231),(800,'Voyager',67,10,228),(801,'Veridis Quo',67,11,345),(802,'Short Circuit',67,12,207),(803,'Face to Face',67,13,240),(804,'Too Long',67,14,600),(805,'Human After All',68,1,319),(806,'The Prime Time of Your Life',68,2,263),(807,'Robot Rock',68,3,288),(808,'Steam Machine',68,4,321),(809,'Make Love',68,5,290),(810,'The Brainwasher',68,6,248),(811,'On/Off',68,7,19),(812,'Television Rules the Nation',68,8,288),(813,'Technologic',68,9,284),(814,'Emotion',68,10,416),(815,'Give Life Back to Music',69,1,275),(816,'The Game of Love',69,2,322),(817,'Giorgio by Moroder',69,3,545),(818,'Within',69,4,229),(819,'Instant Crush',69,5,338),(820,'Lose Yourself to Dance',69,6,354),(821,'Touch',69,7,499),(822,'Get Lucky',69,8,370),(823,'Beyond',69,9,290),(824,'Motherboard',69,10,342),(825,'Fragments of Time',69,11,280),(826,'Doin\' It Right',69,12,251),(827,'Contact',69,13,384),(828,'Taxman',70,1,159),(829,'Eleanor Rigby',70,2,127),(830,'I\'m Only Sleeping',70,3,180),(831,'Love You To',70,4,180),(832,'Here, There and Everywhere',70,5,145),(833,'Yellow Submarine',70,6,159),(834,'She Said She Said',70,7,156),(835,'Good Day Sunshine',70,8,129),(836,'And Your Bird Can Sing',70,9,120),(837,'For No One',70,10,120),(838,'Doctor Robert',70,11,134),(839,'I Want to Tell You',70,12,148),(840,'Got to Get You Into My Life',70,13,149),(841,'Tomorrow Never Knows',70,14,179),(842,'Magical Mystery Tour',71,1,172),(843,'The Fool on the Hill',71,2,180),(844,'Flying',71,3,137),(845,'Blue Jay Way',71,4,237),(846,'Your Mother Should Know',71,5,150),(847,'I Am the Walrus',71,6,277),(848,'Hello Goodbye',71,7,211),(849,'Strawberry Fields Forever',71,8,251),(850,'Penny Lane',71,9,183),(851,'Baby You’re a Rich Man',71,10,184),(852,'All You Need Is Love',71,11,228),(853,'Sgt. Pepper\'s Lonely Hearts Club Band',72,1,123),(854,'With a Little Help From My Friends',72,2,164),(855,'Lucy in the Sky With Diamonds',72,3,208),(856,'Getting Better',72,4,168),(857,'Fixing a Hole',72,5,157),(858,'She\'s Leaving Home',72,6,215),(859,'Being for the Benefit of Mr. Kite!',72,7,158),(860,'Within You Without You',72,8,305),(861,'When I’m Sixty‐Four',72,9,158),(862,'Lovely Rita',72,10,162),(863,'Good Morning Good Morning',72,11,161),(864,'Sgt. Pepper\'s Lonely Hearts Club Band (reprise)',72,12,79),(865,'A Day in the Life',72,13,337),(866,'The Illest Villains',73,1,115),(867,'Accordion',73,2,119),(868,'Meat Grinder',73,3,132),(869,'Bistro',73,4,68),(870,'Raid',73,5,151),(871,'America\'s Most Blunted',73,6,234),(872,'Sickfit (instrumental)',73,7,82),(873,'Rainbows',73,8,172),(874,'Curls',73,9,96),(875,'Do Not Fire! (instrumental)',73,10,53),(876,'Money Folder',73,11,183),(877,'Shadows of Tomorrow',73,12,156),(878,'Operation Lifesaver aka Mint Test',73,13,90),(879,'Figaro',73,14,146),(880,'Hardcore Hustle',73,15,82),(881,'Strange Ways',73,16,112),(882,'Fancy Clown',73,17,116),(883,'Eye',73,18,118),(884,'Supervillain Theme (instrumental)',73,19,53),(885,'All Caps',73,20,130),(886,'Great Day',73,21,137),(887,'Rhinestone Cowboy',73,22,240),(888,'Beef Rapp',74,1,280),(889,'Hoe Cakes',74,2,234),(890,'Potholderz',74,3,201),(891,'One Beer',74,4,259),(892,'Deep Fried Frenz',74,5,300),(893,'Poo-Putt Platter',74,6,74),(894,'Fillet-O-Rapper',74,7,64),(895,'Gumbo',74,8,49),(896,'Fig Leaf Bi-Carbonate',74,201,199),(897,'Kon Karne',74,202,172),(898,'Guinesses',74,203,282),(899,'Kon Queso',74,204,240),(900,'Rapp Snitch Knishes',74,205,173),(901,'Vomitspit',74,206,168),(902,'Kookies',74,207,243),(903,'The Time We Faced Doom (skit)',75,1,125),(904,'Doomsday',75,2,298),(905,'Rhymes Like Dimes',75,3,259),(906,'The Finest',75,4,241),(907,'Back in the Days (skit)',75,5,45),(908,'Go With the Flow',75,6,217),(909,'Tick, Tick…',75,7,245),(910,'Red and Gold',75,8,283),(911,'The Hands of Doom (skit)',75,9,110),(912,'Who You Think I Am?',75,10,204),(913,'Doom, Are You Awake? (skit)',75,11,73),(914,'Hey!',75,12,227),(915,'Operation: Greenbacks',75,13,226),(916,'The Mic',75,14,182),(917,'The Mystery of Doom (skit)',75,15,22),(918,'Dead Bent',75,16,142),(919,'Gas Drawls',75,17,223),(920,'?',75,18,189),(921,'Hero vs. Villain (epilogue)',75,19,179),(922,'Intro',76,1,19),(923,'We Don’t Care',76,2,240),(924,'Graduation Day',76,3,82),(925,'All Falls Down',76,4,224),(926,'I’ll Fly Away',76,5,70),(927,'Spaceship',76,6,324),(928,'Jesus Walks',76,7,194),(929,'Never Let Me Down',76,8,324),(930,'Get ’Em High',76,9,289),(931,'Workout Plan',76,10,46),(932,'The New Workout Plan',76,11,323),(933,'Slow Jamz',76,12,316),(934,'Breathe In, Breathe Out',76,13,247),(935,'School Spirit (skit 1)',76,14,79),(936,'School Spirit',76,15,182),(937,'School Spirit (skit 2)',76,16,44),(938,'Lil Jimmy (skit)',76,17,53),(939,'Two Words',76,18,266),(940,'Through the Wire',76,19,221),(941,'Family Business',76,20,279),(942,'Last Call',76,21,761),(943,'Good Morning',77,1,195),(944,'Champion',77,2,168),(945,'Stronger',77,3,312),(946,'I Wonder',77,4,243),(947,'Good Life',77,5,207),(948,'Can\'t Tell Me Nothing',77,6,272),(949,'Barry Bonds',77,7,204),(950,'Drunk and Hot Girls',77,8,313),(951,'Flashing Lights',77,9,238),(952,'Everything I Am',77,10,228),(953,'The Glory',77,11,213),(954,'Homecoming',77,12,203),(955,'Big Brother',77,13,588),(956,'Good Night',77,14,186),(957,'Dark Fantasy',78,1,281),(958,'Gorgeous',78,2,358),(959,'Power',78,3,292),(960,'All of the Lights (interlude)',78,4,62),(961,'All of the Lights',78,5,300),(962,'Monster',78,6,379),(963,'So Appalled',78,7,398),(964,'Devil in a New Dress',78,8,352),(965,'Runaway',78,9,548),(966,'Hell of a Life',78,10,328),(967,'Blame Game',78,11,470),(968,'Lost in the World',78,12,257),(969,'Who Will Survive in America',78,13,98),(970,'Rewrite',79,1,286),(971,'Sunday',79,2,258),(972,'Breathe Me',79,3,275),(973,'The Bully',79,4,231),(974,'Sweet Potato',79,5,241),(975,'Don’t Bring Me Down',79,6,265),(976,'Natale’s Song',79,7,153),(977,'Butterflies',79,8,206),(978,'Moon',79,9,302),(979,'The Church of What’s Happening Now',79,10,267),(980,'Numb',79,11,280),(981,'Where I Belong',79,12,283),(982,'Isometric (Intro)',80,1,81),(983,'You\'re On',80,2,193),(984,'OK',80,3,182),(985,'La Lune',80,4,220),(986,'Pay No Mind',80,5,249),(987,'Beings',80,6,215),(988,'Imperium',80,7,199),(989,'Zephyr',80,8,220),(990,'Nonsense',80,9,226),(991,'Innocence',80,10,224),(992,'Pixel Empire',80,11,245),(993,'Home',80,12,225),(994,'Icarus',80,13,215),(995,'Finale',80,14,205),(996,'The City',80,15,234),(997,'Cut the Kid',80,16,198),(998,'Technicolor',80,17,385),(999,'Only Way Out',80,18,227),(1000,'Dream Dream Dream',81,1,235),(1001,'All My Friends',81,2,205),(1002,'Be Fine',81,3,208),(1003,'Nirvana',81,4,152),(1004,'Mania',81,5,153),(1005,'Miracle',81,6,250),(1006,'No Fear No More',81,7,195),(1007,'Hold Me Just Because',81,8,186),(1008,'Heavy With Hoping',81,9,241),(1009,'Borealis',81,10,286),(1010,'Bad',82,1,247),(1011,'The Way You Make Me Feel',82,2,298),(1012,'Speed Demon',82,3,242),(1013,'Liberian Girl',82,4,233),(1014,'Just Good Friends',82,5,247),(1015,'Another Part of Me',82,6,235),(1016,'Man in the Mirror',82,7,319),(1017,'I Just Can\'t Stop Loving You',82,8,254),(1018,'Dirty Diana',82,9,281),(1019,'Smooth Criminal',82,10,258),(1020,'Leave Me Alone',82,11,280),(1021,'Wanna Be Startin\' Somethin\'',83,1,362),(1022,'Baby Be Mine',83,2,261),(1023,'The Girl Is Mine',83,3,222),(1024,'Thriller',83,4,358),(1025,'Beat It',83,5,258),(1026,'Billie Jean',83,6,294),(1027,'Human Nature',83,7,246),(1028,'P.Y.T. (Pretty Young Thing)',83,8,239),(1029,'The Lady in My Life',83,9,300),(1030,'Son et lumière',84,1,95),(1031,'Inertiatic ESP',84,2,264),(1032,'Roulette Dares (The Haunt Of)',84,3,451),(1033,'Tira me a las arañas',84,4,89),(1034,'Drunkship of Lanterns',84,5,426),(1035,'Eriatarka',84,6,380),(1036,'Cicatriz ESP',84,7,749),(1037,'This Apparatus Must Be Unearthed',84,8,298),(1038,'Televators',84,9,379),(1039,'Take the Veil Cerpin Taxt',84,10,522),(1040,'Frances the Mute',85,1,874),(1041,'Cygnus... Vismund Cygnus',85,2,782),(1042,'The Widow',85,3,392),(1043,'L\'Via L\'Viaquez',85,4,681),(1044,'Miranda That Ghost Just Isn\'t Holy Anymore',85,201,790),(1045,'Cassandra Gemini',85,202,1952);
/*!40000 ALTER TABLE `tracks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'music_catalog'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_album_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_album_by_id`(IN p_album_id BIGINT UNSIGNED)
BEGIN
    SELECT
        al.album_id, al.name AS album_name, al.release_year, al.rating,
        al.cover_url, a.artist_id, a.artistic_name AS artist_name,
        COUNT(DISTINCT t.track_id) AS track_count,
        GROUP_CONCAT(DISTINCT g.name ORDER BY g.name SEPARATOR ', ') AS genres
    FROM albums al
    JOIN artists a ON a.artist_id = al.primary_artist_id
    LEFT JOIN tracks t ON t.album_id = al.album_id
    LEFT JOIN album_genres ag ON ag.album_id = al.album_id
    LEFT JOIN genres g ON g.genre_id = ag.genre_id
    WHERE al.album_id = p_album_id
    GROUP BY al.album_id, al.name, al.release_year, al.rating, al.cover_url,
             a.artist_id, a.artistic_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_artist_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_artist_by_id`(IN p_artist_id BIGINT UNSIGNED)
BEGIN
    SELECT
        a.artist_id, a.artistic_name, a.artist_type, a.description,
        a.active_from_year, a.active_to_year, a.is_active, a.photo_url,
        GROUP_CONCAT(DISTINCT g.name ORDER BY g.name SEPARATOR ', ') AS genres,
        COUNT(DISTINCT al.album_id) AS album_count
    FROM artists a
    LEFT JOIN artist_genres ag ON ag.artist_id = a.artist_id
    LEFT JOIN genres g ON g.genre_id = ag.genre_id
    LEFT JOIN albums al ON al.primary_artist_id = a.artist_id
    WHERE a.artist_id = p_artist_id
    GROUP BY a.artist_id, a.artistic_name, a.artist_type, a.description,
             a.active_from_year, a.active_to_year, a.is_active, a.photo_url;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_band_members` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_band_members`(IN p_band_artist_id BIGINT UNSIGNED)
BEGIN
    SELECT
        a.artist_id AS band_artist_id, a.artistic_name AS band_name,
        p.person_id, p.full_name, p.stage_name, p.photo_url,
        bm.member_role, bm.joined_year, bm.left_year
    FROM artists a
    JOIN band_members bm ON bm.band_artist_id = a.artist_id
    JOIN people p ON p.person_id = bm.person_id
    WHERE a.artist_id = p_band_artist_id
    ORDER BY p.full_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_person_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_person_by_id`(IN p_person_id BIGINT UNSIGNED)
BEGIN
    SELECT
        p.person_id, p.full_name, p.stage_name, p.biography, p.photo_url,
        a.artist_id AS band_artist_id, a.artistic_name AS band_name,
        bm.member_role, bm.joined_year, bm.left_year
    FROM people p
    LEFT JOIN band_members bm ON bm.person_id = p.person_id
    LEFT JOIN artists a ON a.artist_id = bm.band_artist_id
    WHERE p.person_id = p_person_id
    ORDER BY a.artistic_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_tracks_by_album` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_tracks_by_album`(IN p_album_id BIGINT UNSIGNED)
BEGIN
    SELECT
        t.track_id, t.name AS track_name, t.track_number, t.duration_seconds,
        al.album_id, al.name AS album_name, al.release_year, al.cover_url,
        a.artist_id, a.artistic_name AS artist_name
    FROM tracks t
    JOIN albums al ON al.album_id = t.album_id
    JOIN artists a ON a.artist_id = al.primary_artist_id
    WHERE al.album_id = p_album_id
    ORDER BY t.track_number, t.name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_search_albums` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_albums`(
    IN p_name VARCHAR(250),
    IN p_year SMALLINT UNSIGNED,
    IN p_genre VARCHAR(100),
    IN p_artist_name VARCHAR(200),
    IN p_min_rating DECIMAL(3,2),
    IN p_max_rating DECIMAL(3,2)
)
BEGIN
    SELECT
        al.album_id, al.name AS album_name, al.release_year, al.rating,
        al.cover_url, a.artist_id, a.artistic_name AS artist_name,
        COUNT(DISTINCT t.track_id) AS track_count,
        GROUP_CONCAT(DISTINCT g.name ORDER BY g.name SEPARATOR ', ') AS genres
    FROM albums al
    JOIN artists a ON a.artist_id = al.primary_artist_id
    LEFT JOIN tracks t ON t.album_id = al.album_id
    LEFT JOIN album_genres ag ON ag.album_id = al.album_id
    LEFT JOIN genres g ON g.genre_id = ag.genre_id
    WHERE
        (p_name IS NULL OR p_name = '' OR al.name LIKE CONCAT('%', p_name, '%'))
        AND (p_year IS NULL OR al.release_year = p_year)
        AND (p_genre IS NULL OR p_genre = '' OR g.name = p_genre)
        AND (p_artist_name IS NULL OR p_artist_name = ''
             OR a.artistic_name LIKE CONCAT('%', p_artist_name, '%'))
        AND (p_min_rating IS NULL OR al.rating >= p_min_rating)
        AND (p_max_rating IS NULL OR al.rating <= p_max_rating)
    GROUP BY al.album_id, al.name, al.release_year, al.rating, al.cover_url,
             a.artist_id, a.artistic_name
    ORDER BY al.release_year DESC, al.name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_search_artists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_artists`(
    IN p_query VARCHAR(200),
    IN p_genre VARCHAR(100),
    IN p_artist_type VARCHAR(20),
    IN p_is_active BOOLEAN
)
BEGIN
    SELECT
        a.artist_id,
        a.artistic_name,
        a.artist_type,
        a.description,
        a.active_from_year,
        a.active_to_year,
        a.is_active,
        a.photo_url,
        GROUP_CONCAT(DISTINCT g.name ORDER BY g.name SEPARATOR ', ') AS genres,
        COUNT(DISTINCT al.album_id) AS album_count
    FROM artists a
    LEFT JOIN artist_genres ag ON ag.artist_id = a.artist_id
    LEFT JOIN genres g ON g.genre_id = ag.genre_id
    LEFT JOIN albums al ON al.primary_artist_id = a.artist_id
    WHERE
        (p_query IS NULL OR p_query = ''
            OR a.artistic_name LIKE CONCAT('%', p_query, '%'))
        AND (p_genre IS NULL OR p_genre = '' OR g.name = p_genre)
        AND (p_artist_type IS NULL OR p_artist_type = ''
            OR a.artist_type = p_artist_type)
        AND (p_is_active IS NULL OR a.is_active = p_is_active)
    GROUP BY a.artist_id, a.artistic_name, a.artist_type, a.description,
             a.active_from_year, a.active_to_year, a.is_active, a.photo_url
    ORDER BY a.artistic_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_search_people` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_people`(IN p_query VARCHAR(200))
BEGIN
    SELECT
        p.person_id, p.full_name, p.stage_name, p.biography, p.photo_url,
        GROUP_CONCAT(
            DISTINCT CONCAT(a.artistic_name,
                CASE WHEN bm.member_role IS NOT NULL
                     THEN CONCAT(' (', bm.member_role, ')') ELSE '' END)
            ORDER BY a.artistic_name SEPARATOR ', '
        ) AS bands
    FROM people p
    LEFT JOIN band_members bm ON bm.person_id = p.person_id
    LEFT JOIN artists a ON a.artist_id = bm.band_artist_id
        AND a.artist_type = 'band'
    WHERE p_query IS NULL OR p_query = ''
       OR p.full_name LIKE CONCAT('%', p_query, '%')
       OR p.stage_name LIKE CONCAT('%', p_query, '%')
    GROUP BY p.person_id, p.full_name, p.stage_name, p.biography, p.photo_url
    ORDER BY p.full_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_search_tracks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_tracks`(
    IN p_track_name VARCHAR(250),
    IN p_album_name VARCHAR(250),
    IN p_artist_name VARCHAR(200),
    IN p_year SMALLINT UNSIGNED,
    IN p_genre VARCHAR(100)
)
BEGIN
    SELECT
        t.track_id, t.name AS track_name, t.track_number, t.duration_seconds,
        al.album_id, al.name AS album_name, al.release_year, al.cover_url,
        al.rating AS album_rating,
        a.artist_id, a.artistic_name AS artist_name,
        GROUP_CONCAT(DISTINCT g.name ORDER BY g.name SEPARATOR ', ') AS album_genres
    FROM tracks t
    JOIN albums al ON al.album_id = t.album_id
    JOIN artists a ON a.artist_id = al.primary_artist_id
    LEFT JOIN album_genres ag ON ag.album_id = al.album_id
    LEFT JOIN genres g ON g.genre_id = ag.genre_id
    WHERE
        (p_track_name IS NULL OR p_track_name = ''
            OR t.name LIKE CONCAT('%', p_track_name, '%'))
        AND (p_album_name IS NULL OR p_album_name = ''
            OR al.name LIKE CONCAT('%', p_album_name, '%'))
        AND (p_artist_name IS NULL OR p_artist_name = ''
            OR a.artistic_name LIKE CONCAT('%', p_artist_name, '%'))
        AND (p_year IS NULL OR al.release_year = p_year)
        AND (p_genre IS NULL OR p_genre = '' OR g.name = p_genre)
    GROUP BY t.track_id, t.name, t.track_number, t.duration_seconds,
             al.album_id, al.name, al.release_year, al.cover_url, al.rating,
             a.artist_id, a.artistic_name
    ORDER BY al.release_year DESC, al.name, t.track_number, t.name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-18 11:07:53
