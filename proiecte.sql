CREATE DATABASE  IF NOT EXISTS `proiecte` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `proiecte`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: proiecte
-- ------------------------------------------------------
-- Server version	9.4.0

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
-- Table structure for table `autori`
--

DROP TABLE IF EXISTS `autori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autori` (
  `idautor` int NOT NULL AUTO_INCREMENT,
  `nume` varchar(100) NOT NULL,
  `prenume` varchar(100) NOT NULL,
  `datan` date NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idautor`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autori`
--

LOCK TABLES `autori` WRITE;
/*!40000 ALTER TABLE `autori` DISABLE KEYS */;
INSERT INTO `autori` VALUES (20,'brebenel','leonard','2004-12-22','leo.brebenel@gmail.com'),(23,'popescu','gicuta','2000-01-02','gic@google.com'),(38,'angelescu','ion','1990-07-01','ion.angelescu@yahoo.com'),(39,'test','test','2010-10-11','null');
/*!40000 ALTER TABLE `autori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creatie`
--

DROP TABLE IF EXISTS `creatie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `creatie` (
  `idcreatie` int NOT NULL AUTO_INCREMENT,
  `idautor` int NOT NULL,
  `idproiect` int NOT NULL,
  `rol_autor` varchar(45) DEFAULT NULL,
  `remuneratie` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`idcreatie`),
  KEY `fk_autori_creatie` (`idautor`),
  KEY `fk_creatie_proiecte` (`idproiect`),
  CONSTRAINT `fk_autori_creatie` FOREIGN KEY (`idautor`) REFERENCES `autori` (`idautor`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_creatie_proiecte` FOREIGN KEY (`idproiect`) REFERENCES `proiecte` (`idproiect`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creatie`
--

LOCK TABLES `creatie` WRITE;
/*!40000 ALTER TABLE `creatie` DISABLE KEYS */;
INSERT INTO `creatie` VALUES (14,20,1,'coordonator',NULL);
/*!40000 ALTER TABLE `creatie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proiecte`
--

DROP TABLE IF EXISTS `proiecte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proiecte` (
  `idproiect` int NOT NULL AUTO_INCREMENT,
  `nume` varchar(100) NOT NULL,
  `descriere` varchar(250) DEFAULT NULL,
  `tip_proiect` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT 'Nou',
  `data_inceput` date NOT NULL,
  `deadline` date DEFAULT NULL,
  PRIMARY KEY (`idproiect`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proiecte`
--

LOCK TABLES `proiecte` WRITE;
/*!40000 ALTER TABLE `proiecte` DISABLE KEYS */;
INSERT INTO `proiecte` VALUES (1,'dezvoltare','descriere ampla','agricol','nou','2022-06-20','2025-09-09'),(4,'test','test test test test test test test test test test test test test test test','','','2022-06-21',NULL),(5,'mona lisaaaa','tablou artistic','arta','terminat','2024-08-09',NULL),(8,'test','test','test','','2000-01-01',NULL),(9,'autostrada','dezvoltare rutiera','','inceput','2022-04-03',NULL);
/*!40000 ALTER TABLE `proiecte` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-12 15:32:08
