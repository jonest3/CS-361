-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: mysql.eecs.oregonstate.edu    Database: cs340_jonest3
-- ------------------------------------------------------
-- Server version	5.5.37-MariaDB-wsrep

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointments` (
  `appointment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `slot` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  PRIMARY KEY (`appointment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=353 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (264,'2017-03-17',17,1),(265,'2017-03-17',18,1),(266,'2017-03-17',19,1),(267,'2017-03-17',20,1),(268,'2017-03-17',24,1),(269,'2017-03-17',28,1),(270,'2017-03-17',32,1),(271,'2017-03-17',36,1),(272,'2017-03-21',4,1),(273,'2017-03-21',3,1),(274,'2017-03-21',8,1),(275,'2017-03-21',12,1),(276,'2017-03-21',16,1),(277,'2017-03-21',20,1),(278,'2017-03-21',17,1),(279,'2017-03-21',18,1),(280,'2017-03-21',19,1),(281,'2017-03-21',24,1),(282,'2017-03-21',28,1),(283,'2017-03-21',32,1),(284,'2017-03-21',36,1),(285,'2017-03-21',35,1),(286,'2017-03-22',17,1),(287,'2017-03-22',18,1),(288,'2017-03-22',18,1),(289,'2017-03-22',19,1),(290,'2017-03-22',20,1),(291,'2017-03-22',24,1),(292,'2017-03-22',28,1),(293,'2017-03-22',32,1),(294,'2017-03-22',36,1),(295,'2017-03-22',36,1),(297,'2017-03-23',4,1),(298,'2017-03-23',36,1),(299,'2017-03-23',17,1),(300,'2017-03-23',18,1),(301,'2017-03-23',19,1),(302,'2017-03-23',20,1),(303,'2017-03-20',17,1),(304,'2017-03-20',18,1),(305,'2017-03-20',19,1),(306,'2017-03-20',20,1),(307,'2017-03-24',17,1),(308,'2017-03-24',18,1),(309,'2017-03-24',19,1),(310,'2017-03-24',20,1),(311,'2017-03-24',24,1),(312,'2017-03-24',28,1),(313,'2017-03-24',32,1),(314,'2017-03-24',36,1),(337,'2017-03-21',6,37),(338,'2017-03-22',5,37),(339,'2017-03-23',5,37),(340,'2017-03-24',5,37),(342,'2017-11-23',5,35),(344,'2017-03-20',6,39),(347,'2017-03-20',17,1),(348,'2017-03-20',18,1),(349,'2017-03-20',19,1),(350,'2017-03-20',20,1),(352,'2017-03-20',17,1);
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contains`
--

DROP TABLE IF EXISTS `contains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contains` (
  `ingredient_id` int(10) unsigned NOT NULL,
  `meal_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ingredient_id`,`meal_id`),
  KEY `fk_meal` (`meal_id`),
  CONSTRAINT `contains_ibfk_1` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`ingredient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contains_ibfk_2` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`meal_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contains`
--

LOCK TABLES `contains` WRITE;
/*!40000 ALTER TABLE `contains` DISABLE KEYS */;
INSERT INTO `contains` VALUES (1,1),(1,35),(1,39),(1,64),(1,65),(1,66),(2,1),(2,65),(2,66),(2,67),(3,2),(3,64),(3,65),(3,66),(3,67),(4,2),(4,64),(5,2),(6,2),(7,3),(8,2),(8,40),(12,34),(12,35),(12,36),(12,38),(12,42),(20,34),(20,35),(20,42),(20,43),(22,34),(23,34),(24,34),(24,43),(25,35),(27,42),(34,41),(35,41),(36,42),(37,43),(38,43),(39,43);
/*!40000 ALTER TABLE `contains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diagnostic`
--

DROP TABLE IF EXISTS `diagnostic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diagnostic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diagnostic`
--

LOCK TABLES `diagnostic` WRITE;
/*!40000 ALTER TABLE `diagnostic` DISABLE KEYS */;
INSERT INTO `diagnostic` VALUES (1,'MySQL is Working!');
/*!40000 ALTER TABLE `diagnostic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dietary_attributes`
--

DROP TABLE IF EXISTS `dietary_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dietary_attributes` (
  `da_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`da_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dietary_attributes`
--

LOCK TABLES `dietary_attributes` WRITE;
/*!40000 ALTER TABLE `dietary_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `dietary_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `has`
--

DROP TABLE IF EXISTS `has`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `has` (
  `user_id` int(10) unsigned NOT NULL,
  `da_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`da_id`),
  KEY `fk_da` (`da_id`),
  CONSTRAINT `has_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `has_ibfk_2` FOREIGN KEY (`da_id`) REFERENCES `dietary_attributes` (`da_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `has`
--

LOCK TABLES `has` WRITE;
/*!40000 ALTER TABLE `has` DISABLE KEYS */;
/*!40000 ALTER TABLE `has` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `haves`
--

DROP TABLE IF EXISTS `haves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `haves` (
  `da_id` int(10) unsigned NOT NULL,
  `meal_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`da_id`,`meal_id`),
  KEY `fk_meal` (`meal_id`),
  CONSTRAINT `haves_ibfk_1` FOREIGN KEY (`da_id`) REFERENCES `dietary_attributes` (`da_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `haves_ibfk_2` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`meal_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `haves`
--

LOCK TABLES `haves` WRITE;
/*!40000 ALTER TABLE `haves` DISABLE KEYS */;
/*!40000 ALTER TABLE `haves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingredients` (
  `ingredient_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`ingredient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
/*!40000 ALTER TABLE `ingredients` DISABLE KEYS */;
INSERT INTO `ingredients` VALUES (1,'American Cheese','Dairy'),(2,'Bread','Carbohydrate'),(3,'Spinach','Vegetable'),(4,'Balsamic Vinaigrette ','Dressing'),(5,'Dried Cranberries','Fruit'),(6,'Pecans','Nuts'),(7,'Raspberry','Fruit'),(8,'Chicken','Protein'),(9,'Rice','Carbohydrate'),(10,'Curry','Spice'),(11,'Steak','Protein'),(12,'Salt','Spice'),(20,'Pepper','Spice'),(21,'Beans','Legume'),(22,'Pasta','Carbohydrate'),(23,'Tomato','Fruit'),(24,'Parmesan Cheese','Dairy'),(25,'Eggs','Dairy'),(26,'Chocolate Chips','Sweets'),(27,'Butter','Dairy'),(28,'Sugar','Sweets'),(29,'Flour','Carbohydrate'),(30,'Bacon','Protein'),(31,'Sour Cream','Dairy'),(32,'Chives','Herbs'),(33,'Potato','Starch'),(34,'Pudding Mix','Dessert'),(35,'Milk','Dairy'),(36,'Green Beans','Vegetables'),(37,'Croutons','Carbohydrates'),(38,'Caesar Dressing','Dressing'),(39,'Iceberg Lettuce','Vegetables'),(40,'Peanut Butter','Nuts'),(41,'Jelly','Fruit'),(42,'Watermelon','Fruit'),(43,'Fish','Protein'),(44,'Pickles','Vegetable');
/*!40000 ALTER TABLE `ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insurances`
--

DROP TABLE IF EXISTS `insurances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insurances` (
  `insurance_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `companyName` varchar(255) NOT NULL,
  `visitLimit` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`insurance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insurances`
--

LOCK TABLES `insurances` WRITE;
/*!40000 ALTER TABLE `insurances` DISABLE KEYS */;
INSERT INTO `insurances` VALUES (50,'UHC',20),(51,'Cigna',5),(52,'Ambetter',35),(67,'Sendero',15),(68,'Humana',15),(70,'Algin',24),(84,'Travelers',36),(85,'Superior',12),(95,'BlueCross BlueShield',35),(100,'Testing',15),(113,'Testing',12),(114,'TIn',4);
/*!40000 ALTER TABLE `insurances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meals`
--

DROP TABLE IF EXISTS `meals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meals` (
  `meal_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `genre` varchar(255) DEFAULT NULL,
  `prep_time` int(10) unsigned NOT NULL,
  `image` varchar(300) DEFAULT NULL,
  `username_id` int(10) unsigned NOT NULL,
  `restaurant_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`meal_id`),
  KEY `fk_username` (`username_id`),
  KEY `fk_restaurant` (`restaurant_id`),
  CONSTRAINT `meals_ibfk_1` FOREIGN KEY (`username_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `meals_ibfk_2` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`restaurant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meals`
--

LOCK TABLES `meals` WRITE;
/*!40000 ALTER TABLE `meals` DISABLE KEYS */;
INSERT INTO `meals` VALUES (1,'Grilled Cheese Sandwich','Delicious cheese melted between 2 slices of bread.','American',10,'https://i.ytimg.com/vi/xHuaYMXGTnc/hqdefault.jpg',1,2),(2,'Spinach Salad','A bed of fresh spinach mixed with dried cranberries, pecans, and feta cheese topped with a balsamic vinaigrette. ','American',15,'http://www.bakingdom.com/wp-content/uploads/2011/04/Cranberry-Spinach-Side-Salad.jpg',2,1),(3,'Raspberry Smoothie','Fresh pineapple juice, banana, raspberry',NULL,0,'https://recipesworthrepeating.com/wp-content/uploads/2016/04/smoothie_raspberry_banana.jpg',2,2),(34,'Spaghetti & Meatballs','Spaghetti pasta topped with authentic meatballs and Parmesan cheese.','Italian',30,'http://img.taste.com.au/Gns6Qmtr/w720-h480-cfill-q80/taste/2016/11/cheesy-meatballs-with-spaghetti-23057-1.jpeg',1,1),(35,'Omelette','Creamy cheese folded into a delicious eggs.','',10,'https://www.eggrecipes.co.uk/sites/default/files/classic-omelette.jpg',1,1),(36,'Chocolate Chip Cookies','Delicious gooey cookies.','Dessert',45,'https://www.browneyedbaker.com/wp-content/uploads/2008/06/thick-chewy-chocolate-chip-cookies-19-600.jpg',1,1),(38,'Tomato Soup','Creamy tomato soup. Yum.','',25,'https://www.wholesomeyum.com/wp-content/uploads/2016/10/wholesomeyum_5-ingredient-roasted-tomato-soup-low-carb-gluten-free.jpg',1,1),(39,'Baked Potato','Baked potato covered in butter, sour cream, cheese, chives, and bacon bits.','American',10,'http://www.seriouseats.com/images/2016/10/video-12.jpg',1,1),(40,'Fried Chicken','Crispy, golden chicken','American',90,'http://divascancook.com/wp-content/uploads/2015/01/IMG_0213.jpg',1,1),(41,'Pudding','Open pudding mix.\nAdd milk to mixture.\nStir.\nRefrigerate.','Dessert',10,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnLLHFgDV-yNagSLYYf0W32PyXIOylmbv-q5OsPQiK53ZKRo0H',1,1),(42,'Green Beans','Crisp and crunch.','',10,'http://food.fnr.sndimg.com/content/dam/images/food/fullset/2013/1/9/0/YW0203H_fresh-green-beans-aka-tom-cruise-green-beans-recipe_s4x3.jpg.rend.hgtvcom.616.462.suffix/1371614039965.jpeg',1,1),(43,'Caesar Salad','1. Chop lettuce\n2. Toss in dressing\n3. Sprinkle with cheese\n4. Add croutons','Italian',20,'https://static01.nyt.com/images/2016/03/21/multimedia/recipe-lab-kale-caesar/recipe-lab-kale-caesar-superJumbo.jpg',1,1),(48,'Peanut Butter & Jelly Sandwich','1. Put peanut butter on one slice of bread\n2. Put jelly on the other slice of bread\n3. Put slices of bread together','',5,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdp-3DJMmjVOylC5pDEklU8YxVbtJaa7h7Rm1HbmVxU-1fTEDGsQ',1,1),(64,'TESkLTJSKL','ldksfslkjf','ldkfjsklf',101,'fdsfl',1,1),(65,'AAA','dsksksk','AAA',1,'kslsk',1,1),(66,'AAAnother test','dsksksk','AAAANother',1,'kslsk',1,1),(67,'run one','dklfjsklfj','oeni',10,'dlkfsjklfj',1,1);
/*!40000 ALTER TABLE `meals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `needs`
--

DROP TABLE IF EXISTS `needs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `needs` (
  `need_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  PRIMARY KEY (`need_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `needs`
--

LOCK TABLES `needs` WRITE;
/*!40000 ALTER TABLE `needs` DISABLE KEYS */;
INSERT INTO `needs` VALUES (1,'Latex Allergy'),(4,'Medicare Patient'),(5,'Fall Risk'),(6,'Ultra Sound'),(7,'Infant'),(8,'Needs Massage'),(9,'Allergic to Biofreeze'),(10,'Has Protocol'),(11,'Needs 1-on-1'),(14,'Allergic to Kryptonite');
/*!40000 ALTER TABLE `needs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patients` (
  `patient_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dob` date NOT NULL,
  `fName` varchar(255) NOT NULL,
  `lName` varchar(255) NOT NULL,
  `visitCount` int(10) unsigned DEFAULT NULL,
  `injury` varchar(255) NOT NULL,
  `insurance_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`patient_id`),
  KEY `fk_insurance` (`insurance_id`),
  CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`insurance_id`) REFERENCES `insurances` (`insurance_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,'1991-01-09','Therapist','Out',5,'Needs a Break',85),(35,'1939-05-27','Bruce','Wayne',1,'All-Over Body Contusion',85),(37,'1960-06-18','Clark','Kent',4,'Torn Rotator Cuff',51),(38,'2010-09-16','John','Smith',0,'Sprained L Ankle',85),(39,'1935-01-08','Elvis','Presley',1,'Total Hip Replacement',68),(40,'1981-09-26','Serena','Williams',0,'Tennis Elbow',70),(41,'1980-06-17','Venus','Williams',0,'Tennis Elbow',85),(42,'1961-06-09','Michael J.','Fox',0,'Parkinsons',67),(44,'1911-11-11','John','Smith',0,'Balance Training',52),(47,'1956-09-13','Geri','Jewell',0,'Cerebral Palsy',70),(53,'2013-01-01','TF','TL',0,'Headache',68),(54,'2013-12-31','TName','TLN',0,'Back',95);
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `precautions`
--

DROP TABLE IF EXISTS `precautions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precautions` (
  `patient_id` int(10) unsigned NOT NULL,
  `need_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`patient_id`,`need_id`),
  KEY `fk_need` (`need_id`),
  CONSTRAINT `precautions_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `precautions_ibfk_2` FOREIGN KEY (`need_id`) REFERENCES `needs` (`need_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `precautions`
--

LOCK TABLES `precautions` WRITE;
/*!40000 ALTER TABLE `precautions` DISABLE KEYS */;
INSERT INTO `precautions` VALUES (37,14),(38,1),(38,6),(38,10),(39,4),(39,5),(39,10),(39,11),(40,5),(40,11),(41,8),(42,11),(53,7),(53,9),(54,5),(54,9),(54,14);
/*!40000 ALTER TABLE `precautions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registers`
--

DROP TABLE IF EXISTS `registers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registers` (
  `user_id` int(10) unsigned NOT NULL,
  `restaurant_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`restaurant_id`),
  KEY `fk_restaurant` (`restaurant_id`),
  CONSTRAINT `registers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `registers_ibfk_2` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`restaurant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registers`
--

LOCK TABLES `registers` WRITE;
/*!40000 ALTER TABLE `registers` DISABLE KEYS */;
/*!40000 ALTER TABLE `registers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurants`
--

DROP TABLE IF EXISTS `restaurants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurants` (
  `restaurant_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `street_name` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zipcode` int(5) NOT NULL,
  `genre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurants`
--

LOCK TABLES `restaurants` WRITE;
/*!40000 ALTER TABLE `restaurants` DISABLE KEYS */;
INSERT INTO `restaurants` VALUES (1,'Salad Place','100 Congress Street','Boston','MA',86521,'American'),(2,'JuiceLand','120 E. 4th St.','Austin','Texas',78701,'Juice Service');
/*!40000 ALTER TABLE `restaurants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saves`
--

DROP TABLE IF EXISTS `saves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saves` (
  `user_id` int(10) unsigned NOT NULL,
  `meal_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`meal_id`),
  KEY `fk_meal` (`meal_id`),
  CONSTRAINT `saves_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `saves_ibfk_2` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`meal_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saves`
--

LOCK TABLES `saves` WRITE;
/*!40000 ALTER TABLE `saves` DISABLE KEYS */;
/*!40000 ALTER TABLE `saves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'tayrrible_username','password123'),(2,'jonest3','software_engineering_rules');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-07 19:45:22
