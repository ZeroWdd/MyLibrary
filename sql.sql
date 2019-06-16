/*
SQLyog Ultimate v8.32 
MySQL - 5.5.40 : Database - mylibrary
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`mylibrary` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `mylibrary`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(12) DEFAULT NULL,
  `password` int(12) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8;

/*Table structure for table `book_info` */

DROP TABLE IF EXISTS `book_info`;

CREATE TABLE `book_info` (
  `book_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `author` varchar(20) DEFAULT NULL,
  `publish` varchar(20) DEFAULT NULL,
  `ISBN` varchar(30) DEFAULT NULL,
  `introduction` varchar(255) DEFAULT NULL,
  `language` varchar(5) DEFAULT NULL,
  `price` double(10,2) DEFAULT NULL,
  `pubdate` varchar(20) DEFAULT NULL,
  `cid` int(10) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1007 DEFAULT CHARSET=utf8;

/*Table structure for table `class_info` */

DROP TABLE IF EXISTS `class_info`;

CREATE TABLE `class_info` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Table structure for table `lend_list` */

DROP TABLE IF EXISTS `lend_list`;

CREATE TABLE `lend_list` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `reader_id` int(12) DEFAULT NULL,
  `book_id` int(12) DEFAULT NULL,
  `lend_date` varchar(20) DEFAULT NULL,
  `back_date` varchar(20) DEFAULT NULL,
  `fine` double(10,2) DEFAULT NULL,
  `state` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Table structure for table `reader_info` */

DROP TABLE IF EXISTS `reader_info`;

CREATE TABLE `reader_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reader_id` int(11) NOT NULL,
  `name` varchar(12) DEFAULT NULL,
  `password` int(12) NOT NULL,
  `sex` varchar(5) DEFAULT NULL,
  `birthday` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `telephone` varchar(11) DEFAULT NULL,
  `card_state` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
