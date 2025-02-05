-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pronote1
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `absences`
--

DROP TABLE IF EXISTS `absences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `absences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `eleve_id` int NOT NULL,
  `date` date NOT NULL,
  `creneau` varchar(20) NOT NULL,
  `justifie` tinyint(1) DEFAULT '0',
  `justification` text,
  `justification_status` enum('en_attente','acceptee','refusee') DEFAULT NULL,
  `statut_autorisation` enum('autorisee','non_autorisee') DEFAULT 'non_autorisee',
  PRIMARY KEY (`id`),
  KEY `eleve_id` (`eleve_id`),
  CONSTRAINT `absences_ibfk_1` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `absences`
--

/*!40000 ALTER TABLE `absences` DISABLE KEYS */;
/*!40000 ALTER TABLE `absences` ENABLE KEYS */;

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `classe` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classes`
--

/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
INSERT INTO `classes` VALUES (1,'6ème'),(2,'5ème'),(3,'4ème'),(4,'3ème'),(5,'2nde');
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;

--
-- Table structure for table `devoirs`
--

DROP TABLE IF EXISTS `devoirs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devoirs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(200) NOT NULL,
  `description` text,
  `date` date NOT NULL,
  `matiere_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `matiere_id` (`matiere_id`),
  CONSTRAINT `devoirs_ibfk_1` FOREIGN KEY (`matiere_id`) REFERENCES `matieres` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devoirs`
--

/*!40000 ALTER TABLE `devoirs` DISABLE KEYS */;
/*!40000 ALTER TABLE `devoirs` ENABLE KEYS */;

--
-- Table structure for table `eleves`
--

DROP TABLE IF EXISTS `eleves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eleves` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `classe_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `classe_id` (`classe_id`),
  CONSTRAINT `eleves_ibfk_1` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eleves`
--

/*!40000 ALTER TABLE `eleves` DISABLE KEYS */;
INSERT INTO `eleves` VALUES (21,'jean','jean',1),(22,'naej','naej',2);
/*!40000 ALTER TABLE `eleves` ENABLE KEYS */;

--
-- Table structure for table `matieres`
--

DROP TABLE IF EXISTS `matieres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matieres` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_matiere` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matieres`
--

/*!40000 ALTER TABLE `matieres` DISABLE KEYS */;
INSERT INTO `matieres` VALUES (1,'Mathématiques'),(4,'Physique '),(5,'Histoire-Géo'),(6,'Anglais '),(7,'Français ');
/*!40000 ALTER TABLE `matieres` ENABLE KEYS */;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `eleve_id` int DEFAULT NULL,
  `matiere_id` int DEFAULT NULL,
  `note` decimal(4,2) DEFAULT NULL,
  `coef` int DEFAULT '1',
  `commentaire` text,
  `devoir_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `eleve_id` (`eleve_id`),
  KEY `matiere_id` (`matiere_id`),
  KEY `devoir_id` (`devoir_id`),
  CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notes_ibfk_2` FOREIGN KEY (`matiere_id`) REFERENCES `matieres` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notes_ibfk_3` FOREIGN KEY (`devoir_id`) REFERENCES `devoirs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;

--
-- Table structure for table `parent_eleve`
--

DROP TABLE IF EXISTS `parent_eleve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parent_eleve` (
  `parent_id` int NOT NULL,
  `eleve_id` int NOT NULL,
  `relation` varchar(50) NOT NULL,
  PRIMARY KEY (`parent_id`,`eleve_id`),
  KEY `eleve_id` (`eleve_id`),
  CONSTRAINT `parent_eleve_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `parents` (`parent_id`),
  CONSTRAINT `parent_eleve_ibfk_2` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parent_eleve`
--

/*!40000 ALTER TABLE `parent_eleve` DISABLE KEYS */;
INSERT INTO `parent_eleve` VALUES (11,21,'tuteur'),(11,22,'tuteur');
/*!40000 ALTER TABLE `parent_eleve` ENABLE KEYS */;

--
-- Table structure for table `parents`
--

DROP TABLE IF EXISTS `parents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parents` (
  `parent_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`parent_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `parents_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parents`
--

/*!40000 ALTER TABLE `parents` DISABLE KEYS */;
INSERT INTO `parents` VALUES (11,90,'Dupont','Xavier','0707070707');
/*!40000 ALTER TABLE `parents` ENABLE KEYS */;

--
-- Table structure for table `prof`
--

DROP TABLE IF EXISTS `prof`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prof` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `matiere1` varchar(100) DEFAULT NULL,
  `matiere2` varchar(100) DEFAULT NULL,
  `matiere3` varchar(100) DEFAULT NULL,
  `classe1` int DEFAULT NULL,
  `classe2` int DEFAULT NULL,
  `classe3` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `classe1` (`classe1`),
  KEY `classe2` (`classe2`),
  KEY `classe3` (`classe3`),
  CONSTRAINT `prof_ibfk_1` FOREIGN KEY (`classe1`) REFERENCES `classes` (`id`) ON DELETE SET NULL,
  CONSTRAINT `prof_ibfk_2` FOREIGN KEY (`classe2`) REFERENCES `classes` (`id`) ON DELETE SET NULL,
  CONSTRAINT `prof_ibfk_3` FOREIGN KEY (`classe3`) REFERENCES `classes` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prof`
--

/*!40000 ALTER TABLE `prof` DISABLE KEYS */;
INSERT INTO `prof` VALUES (15,87,'prof','prof','1','4','',1,2,3);
/*!40000 ALTER TABLE `prof` ENABLE KEYS */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password` varchar(200) NOT NULL,
  `role` enum('admin','prof','eleve','parent') NOT NULL,
  `eleve_id` int DEFAULT NULL,
  `salt` blob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (86,'admin','admin@admin.admin','100000$zPZBz6N7DOj3EeP3n8lcKQ==$b2Rg1oVZVPHnJyarFqo17TqJTn8XwWUa+oNpJMHCbdI=','admin',NULL,0x7A505A427A364E37444F6A33456550336E386C634B513D3D),(87,'prof','prof@prof.prof','100000$CNUEqslXUH65qj2TYgRl3Q==$rKwVxWz6UNhkuvT1MWydrw6JeLoJSyfSwJ0nJAAknOk=','prof',NULL,0x434E554571736C5855483635716A32545967526C33513D3D),(88,'jean','jean@jean.jean','100000$zTb8B4qy6pgt+Z3e6waz9A==$GjoYI9e2wLrkSb/CKWxkbsKFiaxsM9lGG83Ygnc7qSE=','eleve',21,0x7A54623842347179367067742B5A33653677617A39413D3D),(89,'naej','naej@naej.naej','100000$yZnkfuyxup5yfxT84EayBw==$2UqygA4R7z3PLimm0Ivp8MAHcAOyHaVblTvyKx2y3+c=','eleve',22,0x795A6E6B6675797875703579667854383445617942773D3D),(90,'xavier','dupont@dupont.dupond','100000$YgZBqXJki3dm84JYrg+Ggw==$UrSB2J3PUd+m7kQk4OacSGctGVinT0Kn+vH4uV084jk=','parent',NULL,0x59675A4271584A6B6933646D38344A5972672B4767773D3D);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

--
-- Dumping routines for database 'pronote1'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-05 17:41:09
