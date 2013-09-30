-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               5.0.51b-community-nt-log - MySQL Community Edition (GPL)
-- Server OS:                    Win32
-- HeidiSQL Version:             8.0.0.4396
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for redsun
DROP DATABASE IF EXISTS `redsun`;
CREATE DATABASE IF NOT EXISTS `redsun` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `redsun`;


-- Dumping structure for procedure redsun.AddCustomer
DROP PROCEDURE IF EXISTS `AddCustomer`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddCustomer`(IN `grade` varchar(15), IN `idNo` varchar(12), IN `lastName` varchar(10), IN `middleName` varchar(10), IN `firstName` varchar(10), IN `bday_Day` tinyint, IN `bday_Month` tinyint, IN `bday_Year` mediumint, IN `joinDate` datetime, IN `address` varchar(30), IN `district` varchar(20), IN `city` varchar(20), IN `phone` varchar(33), IN `email` varchar(30))
BEGIN
DECLARE newID int(10) UNSIGNED;

start TRANSACTION;
insert into customer set
Grade = grade;

set newID = LAST_INSERT_ID();

insert into customer_detail set
CustomerID = newID,
IDNo = idNo,
LastName = lastName,
MiddleName = middleName,
FirstName = firstName,
Birthday_Day = bday_Day,
Birthday_Month = bday_Month,
Birthday_Year = bday_Year,
JoinDate = joinDate,
Address = address,
District = district,
City = city,
Phone = phone,
Email = email;

COMMIT;
END//
DELIMITER ;


-- Dumping structure for procedure redsun.AddDepartment
DROP PROCEDURE IF EXISTS `AddDepartment`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddDepartment`(IN `name` varchar(30), IN `isChildOf` mediumint, IN `address` varchar(30), IN `district` varchar(20), IN `city` varchar(20), IN `phone` varchar(11), IN `founded` timestamp)
BEGIN
insert into department values (null,name,isChildOf,address,district,city,phone,founded);
END//
DELIMITER ;


-- Dumping structure for procedure redsun.AddDish
DROP PROCEDURE IF EXISTS `AddDish`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddDish`(IN `dishName` varchar(30), In `avatar` varchar(150) , IN `price` mediumint(8), IN `time` tinyint(3), IN `serving` tinyint(3))
BEGIN

START TRANSACTION;
insert into dish set
Name = dishName,
Price = price,
Time = time,
Serving = serving;

COMMIT;

END//
DELIMITER ;


-- Dumping structure for procedure redsun.AddEmployee
DROP PROCEDURE IF EXISTS `AddEmployee`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddEmployee`(IN `username` varchar(20), IN `lastName` varchar(10), IN `middleName` varchar(10), IN `firstName` varchar(10), IN `workAt` MEDIUMINT, IN `position` varchar(20), IN `status` varchar(20), IN `bDay` TINYINT, IN `bMonth` tinyint, IN `bYear` smaLLINT, IN `hireDate` daTE, IN `address` varchar(30), IN `district` varchar(20), IN `city` varchar(20), IN `phone` varchar(33), IN `avatar` varchar(150))
BEGIN
DECLARE newID mediumint UNSIGNED;

START TRANSACTION;
insert into employee set
Username = username,
LastName = lastName,
MiddleName = middleName,
FirstName = firstName,
WorkAt = workAt,
Position = position,
Status = status;

set newID = LAST_INSERT_ID();

insert into employee_detail set
EmployeeID = newID,
Birthday_Day = bDay,
Birthday_Month = bMonth,
Birthday_Year = bYear,
HireDate = hireDate,
Address = address,
District = district,
City = city,
Phone = phone,
Avatar = avatar;
COMMIT;

END//
DELIMITER ;


-- Dumping structure for procedure redsun.AddSu
DROP PROCEDURE IF EXISTS `AddSu`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddSu`(IN `Type` varchar(50),IN `Name` varchar(20),IN `Address` varchar(30),IN `District` varchar(20),IN `City` varchar(20),In `PhoneNumber` varchar(33),IN `Contact` varchar(20))
BEGIN
START TRANSACTION;
	INSERT INTO supplier SET
		Type 				= type,
		Name 				= name,
		Address 		= address,
		District 		= district,
		City 				= city,
		PhoneNumber = phonenumber,
		Contact 		= contact;
COMMIT;
END//
DELIMITER ;


-- Dumping structure for procedure redsun.AddTask
DROP PROCEDURE IF EXISTS `AddTask`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddTask`(IN `name` varchar(30), IN `upperTask` int, IN `accessLevel` tinyint, IN `assignBy` mediumint, IN `startDate` date, IN `duration` tinyint)
Begin
START TRANSACTION;
insert into task set
Name = name,
UpperTask = upperTask,
AccessLevel = accessLevel,
AssignBy = assignBy,
StartDate = startDate,
Duration = duration;

update task t set
t.HasChild = 1
where t.TaskID = upperTask;
COMMIT;
end//
DELIMITER ;


-- Dumping structure for table redsun.city
DROP TABLE IF EXISTS `city`;
CREATE TABLE IF NOT EXISTS `city` (
  `CityID` tinyint(3) unsigned NOT NULL auto_increment,
  `Name` varchar(20) collate utf8_unicode_ci NOT NULL,
  `LastUpdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`CityID`,`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table redsun.city: ~2 rows (approximately)
DELETE FROM `city`;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` (`CityID`, `Name`, `LastUpdate`) VALUES
	(1, 'Hồ Chí Minh', '2013-07-10 16:35:47'),
	(2, 'Hà Nội', '2013-07-10 16:36:01');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;


-- Dumping structure for table redsun.customer
DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `CustomerID` int(10) unsigned NOT NULL auto_increment,
  `UID` char(10) collate utf8_unicode_ci default NULL,
  `Grade` varchar(15) collate utf8_unicode_ci NOT NULL default 'vãng lai' COMMENT 'vãng lai/thường xuyên/thân thiết/VIP',
  `Username` varchar(20) collate utf8_unicode_ci default NULL COMMENT 'là tên đầy đủ không dấu rút gọn viết liền',
  `Password` varchar(20) collate utf8_unicode_ci default NULL,
  `TaxCode` varchar(13) collate utf8_unicode_ci default NULL COMMENT 'dành cho khách muốn lấy hóa đơn đỏ',
  `LoginCount` tinyint(3) unsigned default NULL COMMENT 'đếm số lần đăng nhập failed',
  `LastTry` timestamp NULL default NULL COMMENT 'lần cuối đăng nhập thất bại',
  `LastLogin` timestamp NULL default NULL COMMENT 'lần cuối đăng nhập thành công',
  PRIMARY KEY  (`CustomerID`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table redsun.customer: ~22 rows (approximately)
DELETE FROM `customer`;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` (`CustomerID`, `UID`, `Grade`, `Username`, `Password`, `TaxCode`, `LoginCount`, `LastTry`, `LastLogin`) VALUES
	(1, NULL, 'vãng lai', 'cus1', '123456', '123456789', NULL, NULL, NULL),
	(2, NULL, 'vãng lai', 'ac', 'acs', NULL, NULL, NULL, NULL),
	(3, NULL, 'vãng lai', 'cus2', '123456', NULL, NULL, NULL, NULL),
	(5, NULL, 'vãng lai', 'dsv', 'ascac', NULL, NULL, NULL, NULL),
	(6, NULL, 'vãng lai', 'dsv', 'ascac', NULL, NULL, NULL, NULL),
	(7, NULL, 'vãng lai', 'dsv', 'ascac', NULL, NULL, NULL, NULL),
	(8, NULL, 'vãng lai', 'cus3', '123', NULL, NULL, NULL, NULL),
	(9, NULL, 'vãng lai', 'svsdv', 'sdvs', NULL, NULL, NULL, NULL),
	(10, NULL, 'thân thiết', 'abc123', '123', NULL, NULL, NULL, NULL),
	(11, NULL, 'vãng lai', 'sdv', '123', NULL, NULL, NULL, NULL),
	(12, NULL, 'vãng lai', 'aaaaa', '123', NULL, NULL, NULL, NULL),
	(13, NULL, 'vãng lai', 'bbb', '123', NULL, NULL, NULL, NULL),
	(14, NULL, 'vãng lai', 'abc', '123', NULL, NULL, NULL, NULL),
	(15, NULL, 'vãng lai', 'bbbba', '123', NULL, NULL, NULL, NULL),
	(16, NULL, 'vãng lai', 'th', '123', NULL, NULL, NULL, NULL),
	(17, NULL, 'vãng lai', 'g', '1', NULL, NULL, NULL, NULL),
	(18, NULL, 'vãng lai', 'user7', '123456', NULL, NULL, NULL, NULL),
	(19, NULL, 'vãng lai', 'qqq', '123', NULL, NULL, NULL, NULL),
	(20, NULL, 'thường xuyên', 'sdvsdv', '123', NULL, NULL, NULL, NULL),
	(21, NULL, 'VIP', 'cus5', '123', NULL, NULL, NULL, NULL),
	(22, NULL, 'vãng lai', 'anhhung', '123', NULL, NULL, NULL, NULL),
	(23, NULL, 'vãng lai', 'cus100', '123456aPtQ4V5Gy', NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;


-- Dumping structure for table redsun.customer_changelog
DROP TABLE IF EXISTS `customer_changelog`;
CREATE TABLE IF NOT EXISTS `customer_changelog` (
  `CustomerID` int(10) unsigned NOT NULL,
  `Field` varchar(15) collate utf8_unicode_ci NOT NULL,
  `OldValue` varchar(30) collate utf8_unicode_ci NOT NULL,
  `NewValue` varchar(30) collate utf8_unicode_ci NOT NULL,
  `Date` datetime NOT NULL,
  `LastUpdate` datetime NOT NULL,
  KEY `FK_customer_changelog_customer` (`CustomerID`),
  CONSTRAINT `FK_customer_changelog_customer` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='lưu lại lịch sử các lần thay đổi thông tin thuộc khách hàng';

-- Dumping data for table redsun.customer_changelog: ~0 rows (approximately)
DELETE FROM `customer_changelog`;
/*!40000 ALTER TABLE `customer_changelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_changelog` ENABLE KEYS */;


-- Dumping structure for table redsun.customer_detail
DROP TABLE IF EXISTS `customer_detail`;
CREATE TABLE IF NOT EXISTS `customer_detail` (
  `CustomerID` int(10) unsigned NOT NULL,
  `IDNo` varchar(12) collate utf8_unicode_ci default NULL,
  `LastName` varchar(10) collate utf8_unicode_ci NOT NULL,
  `MiddleName` varchar(10) collate utf8_unicode_ci default NULL,
  `FirstName` varchar(10) collate utf8_unicode_ci NOT NULL,
  `Birthday_Day` tinyint(2) default NULL,
  `Birthday_Month` tinyint(2) default NULL,
  `Birthday_Year` mediumint(4) default NULL,
  `JoinDate` date NOT NULL,
  `Address` varchar(30) collate utf8_unicode_ci default NULL,
  `District` varchar(20) collate utf8_unicode_ci default NULL,
  `City` varchar(20) collate utf8_unicode_ci default NULL,
  `Phone` varchar(33) collate utf8_unicode_ci default NULL,
  `Email` varchar(30) collate utf8_unicode_ci default NULL,
  KEY `FK_customer_detail_customer` (`CustomerID`),
  CONSTRAINT `FK_customer_detail_customer` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table redsun.customer_detail: ~18 rows (approximately)
DELETE FROM `customer_detail`;
/*!40000 ALTER TABLE `customer_detail` DISABLE KEYS */;
INSERT INTO `customer_detail` (`CustomerID`, `IDNo`, `LastName`, `MiddleName`, `FirstName`, `Birthday_Day`, `Birthday_Month`, `Birthday_Year`, `JoinDate`, `Address`, `District`, `City`, `Phone`, `Email`) VALUES
	(1, NULL, 'sv', 'sv', 'sv', 13, 9, 1990, '2013-09-14', NULL, NULL, NULL, NULL, NULL),
	(3, NULL, 'sc', NULL, 'sc', NULL, NULL, NULL, '0000-00-00', NULL, NULL, NULL, NULL, NULL),
	(3, NULL, 'acs', 'ac', 'ac', NULL, NULL, NULL, '0000-00-00', NULL, NULL, NULL, NULL, NULL),
	(7, NULL, 'acs', 'ac', 'ac', NULL, NULL, NULL, '0000-00-00', NULL, NULL, NULL, NULL, NULL),
	(8, NULL, 'Lưu', 'Trần Trọng', 'Tín', NULL, NULL, NULL, '0000-00-00', NULL, NULL, NULL, NULL, NULL),
	(9, NULL, 'sv', 'svd', 'sv', 1, 1, 127, '0000-00-00', 'sdsv', 'sdvs', 'sdvsv', '232', 'sdvsv'),
	(10, NULL, 'Lê', 'Lê', 'La', 10, 10, 1990, '2013-09-16', 'sdv', 'vsv', 'Hồ Chí Minh', '12678', 'sdcsdc'),
	(13, NULL, 'a', 'aa', 'aaa', NULL, NULL, NULL, '0000-00-00', NULL, NULL, NULL, NULL, NULL),
	(14, NULL, 'a', 'b', 'c', 2, 2, 1990, '0000-00-00', NULL, NULL, NULL, NULL, NULL),
	(15, NULL, 'v', 'c', 'z', 13, 12, 1990, '0000-00-00', 'sdcsc', 'dvdsv', 'HCM', '', 'efdf'),
	(16, NULL, 'sdgsg', 'sg', 'sg', 1, 2, 1990, '0000-00-00', 'sddg', 'dvdsv', 'HCM', '', 'luutrantrongtin'),
	(17, NULL, 'dfb', 'db', 'dfb', 13, 2, 1990, '0000-00-00', 'sdf', 'dvdsv', 'Hồ Chí Minh', '', 'luutrantrongtin'),
	(18, NULL, 'luu', 'tran trong', 'tin', 6, 8, 1990, '0000-00-00', 'abc', 'abc', 'Hồ Chí Minh', '', 'aasasasa'),
	(19, NULL, 'Bùi', '', 'Kiệm', 1, 1, 1990, '2013-09-16', 'ascc', 'ac', 'Hồ Chí Minh', '2', 'da'),
	(20, NULL, 'r', 't', 'g', 13, 2, 1990, '2013-09-16', 'sdf', 'dvdsv', 'Hà Nội', '', 'luutrantrongtin'),
	(21, NULL, 'Lê', 'văn', 'Lợi', 12, 12, 1990, '2013-09-16', 'vô gia cư', 'hên xui', 'Hồ Chí Minh', '0987654321', 'kvdbvmbdbv'),
	(22, NULL, '1', '2', '3', 1, 1, 1990, '2013-09-16', 'sv', 'sdv', 'Hồ Chí Minh', '21', 'fs'),
	(23, NULL, 'anh', 'hung', 'rom', 9, 9, 1990, '2013-09-23', 'abc', 'xyz', 'Hồ Chí Minh', '0123456789', 'abc@gmail.com');
/*!40000 ALTER TABLE `customer_detail` ENABLE KEYS */;


-- Dumping structure for procedure redsun.DeleteSupplier
DROP PROCEDURE IF EXISTS `DeleteSupplier`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteSupplier`(IN `id` MEDIUMINT(8))
BEGIN
DELETE FROM supplier WHERE supplier.SupplierID=id;
END//
DELIMITER ;


-- Dumping structure for table redsun.department
DROP TABLE IF EXISTS `department`;
CREATE TABLE IF NOT EXISTS `department` (
  `DepartmentID` mediumint(8) unsigned NOT NULL auto_increment,
  `Name` varchar(30) collate utf8_unicode_ci NOT NULL,
  `IsChildOf` mediumint(8) unsigned default NULL,
  `Address` varchar(30) collate utf8_unicode_ci NOT NULL,
  `District` varchar(20) collate utf8_unicode_ci NOT NULL,
  `City` varchar(20) collate utf8_unicode_ci NOT NULL,
  `Phone` varchar(11) collate utf8_unicode_ci default NULL,
  `Founded` timestamp NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`DepartmentID`),
  KEY `FK_department_department` (`IsChildOf`),
  CONSTRAINT `FK_department_department` FOREIGN KEY (`IsChildOf`) REFERENCES `department` (`DepartmentID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table redsun.department: ~1 rows (approximately)
DELETE FROM `department`;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` (`DepartmentID`, `Name`, `IsChildOf`, `Address`, `District`, `City`, `Phone`, `Founded`) VALUES
	(1, 'Phong 1', NULL, 'khong co', 'quan 1', 'HCM', NULL, '2013-07-05 16:45:06');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;


-- Dumping structure for table redsun.department_changelog
DROP TABLE IF EXISTS `department_changelog`;
CREATE TABLE IF NOT EXISTS `department_changelog` (
  `DepartmentID` mediumint(8) unsigned NOT NULL,
  `Field` varchar(15) collate utf8_unicode_ci NOT NULL,
  `OldValue` varchar(30) collate utf8_unicode_ci NOT NULL,
  `NewValue` varchar(30) collate utf8_unicode_ci NOT NULL,
  `Date` datetime NOT NULL,
  `LastUpdate` datetime NOT NULL,
  KEY `FK_department_changelog_department` (`DepartmentID`),
  CONSTRAINT `FK_department_changelog_department` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`DepartmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT COMMENT='lưu lại lịch sử các lần thay đổi thông tin phòng ban';

-- Dumping data for table redsun.department_changelog: ~0 rows (approximately)
DELETE FROM `department_changelog`;
/*!40000 ALTER TABLE `department_changelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `department_changelog` ENABLE KEYS */;


-- Dumping structure for table redsun.dish
DROP TABLE IF EXISTS `dish`;
CREATE TABLE IF NOT EXISTS `dish` (
  `DishID` mediumint(8) unsigned NOT NULL auto_increment,
  `UID` varchar(10) collate utf8_unicode_ci default NULL,
  `Name` varchar(30) collate utf8_unicode_ci NOT NULL,
  `AvatarURL` varchar(150) collate utf8_unicode_ci NOT NULL COMMENT 'link hình ảnh',
  `Price` mediumint(8) unsigned NOT NULL,
  `Time` tinyint(3) unsigned default NULL COMMENT 'thời gian nấu',
  `Serving` tinyint(3) unsigned NOT NULL default '1' COMMENT 'khẩu phần ăn',
  PRIMARY KEY  (`DishID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Danh sách món';

-- Dumping data for table redsun.dish: ~0 rows (approximately)
DELETE FROM `dish`;
/*!40000 ALTER TABLE `dish` DISABLE KEYS */;
/*!40000 ALTER TABLE `dish` ENABLE KEYS */;


-- Dumping structure for table redsun.dish_changelog
DROP TABLE IF EXISTS `dish_changelog`;
CREATE TABLE IF NOT EXISTS `dish_changelog` (
  `DishID` mediumint(8) unsigned NOT NULL,
  `Field` varchar(15) collate utf8_unicode_ci NOT NULL,
  `OldValue` varchar(150) collate utf8_unicode_ci NOT NULL,
  `NewValue` varchar(150) collate utf8_unicode_ci NOT NULL,
  `Date` datetime NOT NULL,
  `LastUpdate` datetime NOT NULL,
  KEY `FK_dish_changelog_dish` (`DishID`),
  CONSTRAINT `FK_dish_changelog_dish` FOREIGN KEY (`DishID`) REFERENCES `dish` (`DishID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT COMMENT='lưu lại lịch sử các lần thay đổi thông tin thuộc khách hàng';

-- Dumping data for table redsun.dish_changelog: ~0 rows (approximately)
DELETE FROM `dish_changelog`;
/*!40000 ALTER TABLE `dish_changelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `dish_changelog` ENABLE KEYS */;


-- Dumping structure for table redsun.dish_community
DROP TABLE IF EXISTS `dish_community`;
CREATE TABLE IF NOT EXISTS `dish_community` (
  `DishID` mediumint(8) unsigned NOT NULL,
  `CustomerID` int(10) unsigned NOT NULL,
  `Ratings` tinyint(1) unsigned default NULL COMMENT 'điểm',
  `Like` mediumint(8) unsigned default NULL COMMENT 'số lượng like',
  `Comment` mediumint(8) unsigned default NULL COMMENT 'số lượng comment',
  KEY `FK_dish_community_dish` (`DishID`),
  KEY `FK_dish_community_customer` (`CustomerID`),
  CONSTRAINT `FK_dish_community_customer` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),
  CONSTRAINT `FK_dish_community_dish` FOREIGN KEY (`DishID`) REFERENCES `dish` (`DishID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table redsun.dish_community: ~0 rows (approximately)
DELETE FROM `dish_community`;
/*!40000 ALTER TABLE `dish_community` DISABLE KEYS */;
/*!40000 ALTER TABLE `dish_community` ENABLE KEYS */;


-- Dumping structure for table redsun.dish_direction
DROP TABLE IF EXISTS `dish_direction`;
CREATE TABLE IF NOT EXISTS `dish_direction` (
  `DishID` mediumint(8) unsigned NOT NULL,
  `Step` tinyint(1) unsigned NOT NULL,
  `Direction` varchar(100) collate utf8_unicode_ci default NULL,
  `Image` varchar(150) collate utf8_unicode_ci default NULL,
  KEY `FK_dish_direction_dish` (`DishID`),
  CONSTRAINT `FK_dish_direction_dish` FOREIGN KEY (`DishID`) REFERENCES `dish` (`DishID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='hướng dẫn nấu ăn';

-- Dumping data for table redsun.dish_direction: ~0 rows (approximately)
DELETE FROM `dish_direction`;
/*!40000 ALTER TABLE `dish_direction` DISABLE KEYS */;
/*!40000 ALTER TABLE `dish_direction` ENABLE KEYS */;


-- Dumping structure for table redsun.dish_equipment_detail
DROP TABLE IF EXISTS `dish_equipment_detail`;
CREATE TABLE IF NOT EXISTS `dish_equipment_detail` (
  `DishID` mediumint(8) unsigned NOT NULL,
  `EquipmentID` mediumint(8) unsigned NOT NULL,
  `Quantity` tinyint(3) unsigned NOT NULL default '1',
  KEY `FK_dish_equipment_detail_dish` (`DishID`),
  KEY `FK_dish_equipment_detail_equipment` (`EquipmentID`),
  CONSTRAINT `FK_dish_equipment_detail_dish` FOREIGN KEY (`DishID`) REFERENCES `dish` (`DishID`),
  CONSTRAINT `FK_dish_equipment_detail_equipment` FOREIGN KEY (`EquipmentID`) REFERENCES `equipment` (`EquipmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='trang bị cần để phục vụ món';

-- Dumping data for table redsun.dish_equipment_detail: ~0 rows (approximately)
DELETE FROM `dish_equipment_detail`;
/*!40000 ALTER TABLE `dish_equipment_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `dish_equipment_detail` ENABLE KEYS */;


-- Dumping structure for table redsun.dish_ingredent_detail
DROP TABLE IF EXISTS `dish_ingredent_detail`;
CREATE TABLE IF NOT EXISTS `dish_ingredent_detail` (
  `DishID` mediumint(8) unsigned NOT NULL,
  `IngredentID` mediumint(8) unsigned NOT NULL,
  `Amount` varchar(15) collate utf8_unicode_ci NOT NULL,
  `Optional` tinyint(1) unsigned default NULL COMMENT 'nguyên liệu có cho phép tùy biến hay không',
  KEY `FK_dish_ingredent_detail_dish` (`DishID`),
  KEY `FK_dish_ingredent_detail_ingredent` (`IngredentID`),
  CONSTRAINT `FK_dish_ingredent_detail_dish` FOREIGN KEY (`DishID`) REFERENCES `dish` (`DishID`),
  CONSTRAINT `FK_dish_ingredent_detail_ingredent` FOREIGN KEY (`IngredentID`) REFERENCES `ingredent` (`IngredentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='danh sách nguyên liệu';

-- Dumping data for table redsun.dish_ingredent_detail: ~0 rows (approximately)
DELETE FROM `dish_ingredent_detail`;
/*!40000 ALTER TABLE `dish_ingredent_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `dish_ingredent_detail` ENABLE KEYS */;


-- Dumping structure for table redsun.dish_option
DROP TABLE IF EXISTS `dish_option`;
CREATE TABLE IF NOT EXISTS `dish_option` (
  `DishID` mediumint(8) unsigned NOT NULL,
  `Option` varchar(10) collate utf8_unicode_ci NOT NULL,
  `IngredentID` mediumint(8) unsigned NOT NULL,
  KEY `FK_dish_option_dish` (`DishID`),
  KEY `FK_dish_option_ingredent` (`IngredentID`),
  CONSTRAINT `FK_dish_option_dish` FOREIGN KEY (`DishID`) REFERENCES `dish` (`DishID`),
  CONSTRAINT `FK_dish_option_ingredent` FOREIGN KEY (`IngredentID`) REFERENCES `ingredent` (`IngredentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='tùy chọn món ăn';

-- Dumping data for table redsun.dish_option: ~0 rows (approximately)
DELETE FROM `dish_option`;
/*!40000 ALTER TABLE `dish_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `dish_option` ENABLE KEYS */;


-- Dumping structure for table redsun.dish_tag
DROP TABLE IF EXISTS `dish_tag`;
CREATE TABLE IF NOT EXISTS `dish_tag` (
  `DishID` mediumint(8) unsigned NOT NULL,
  `Tag` varchar(15) collate utf8_unicode_ci NOT NULL,
  KEY `FK_dish_tag_dish` (`DishID`),
  CONSTRAINT `FK_dish_tag_dish` FOREIGN KEY (`DishID`) REFERENCES `dish` (`DishID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='gắn tag, category cho món ăn';

-- Dumping data for table redsun.dish_tag: ~0 rows (approximately)
DELETE FROM `dish_tag`;
/*!40000 ALTER TABLE `dish_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `dish_tag` ENABLE KEYS */;


-- Dumping structure for table redsun.dish_user_comment
DROP TABLE IF EXISTS `dish_user_comment`;
CREATE TABLE IF NOT EXISTS `dish_user_comment` (
  `DishID` mediumint(8) unsigned NOT NULL,
  `CustomerID` int(10) unsigned NOT NULL,
  `ReplyTo` int(10) unsigned default NULL,
  `Comment` varchar(300) collate utf8_unicode_ci NOT NULL,
  `PostTime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `IsDeleted` tinyint(1) unsigned default NULL COMMENT 'null: tin dc phép đăng',
  KEY `FK_user_comment_dish` (`DishID`),
  KEY `FK_user_comment_customer` (`CustomerID`),
  CONSTRAINT `FK_user_comment_customer` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),
  CONSTRAINT `FK_user_comment_dish` FOREIGN KEY (`DishID`) REFERENCES `dish` (`DishID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table redsun.dish_user_comment: ~0 rows (approximately)
DELETE FROM `dish_user_comment`;
/*!40000 ALTER TABLE `dish_user_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `dish_user_comment` ENABLE KEYS */;


-- Dumping structure for table redsun.dish_user_photo
DROP TABLE IF EXISTS `dish_user_photo`;
CREATE TABLE IF NOT EXISTS `dish_user_photo` (
  `DishID` mediumint(8) unsigned NOT NULL,
  `CustomerID` int(10) unsigned NOT NULL,
  `ImageURL` varchar(150) collate utf8_unicode_ci NOT NULL,
  `PostTime` timestamp NULL default CURRENT_TIMESTAMP,
  KEY `FK_user_photo_dish` (`DishID`),
  KEY `FK_user_photo_customer` (`CustomerID`),
  CONSTRAINT `FK_user_photo_customer` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),
  CONSTRAINT `FK_user_photo_dish` FOREIGN KEY (`DishID`) REFERENCES `dish` (`DishID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='hình ảnh do user tự up lên';

-- Dumping data for table redsun.dish_user_photo: ~0 rows (approximately)
DELETE FROM `dish_user_photo`;
/*!40000 ALTER TABLE `dish_user_photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `dish_user_photo` ENABLE KEYS */;


-- Dumping structure for table redsun.district
DROP TABLE IF EXISTS `district`;
CREATE TABLE IF NOT EXISTS `district` (
  `CityID` tinyint(3) unsigned NOT NULL,
  `Name` varchar(20) collate utf8_unicode_ci NOT NULL,
  `LastUpdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`Name`),
  KEY `FK_district_city` (`CityID`),
  CONSTRAINT `FK_district_city` FOREIGN KEY (`CityID`) REFERENCES `city` (`CityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table redsun.district: ~0 rows (approximately)
DELETE FROM `district`;
/*!40000 ALTER TABLE `district` DISABLE KEYS */;
/*!40000 ALTER TABLE `district` ENABLE KEYS */;


-- Dumping structure for table redsun.employee
DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `EmployeeID` mediumint(8) unsigned NOT NULL auto_increment,
  `UID` char(10) collate utf8_unicode_ci default NULL,
  `Username` varchar(20) collate utf8_unicode_ci default NULL,
  `Password` varchar(20) collate utf8_unicode_ci default NULL,
  `LastName` varchar(10) collate utf8_unicode_ci NOT NULL,
  `MiddleName` varchar(10) collate utf8_unicode_ci default NULL,
  `FirstName` varchar(10) collate utf8_unicode_ci NOT NULL,
  `WorkAt` mediumint(8) unsigned NOT NULL,
  `Position` varchar(20) collate utf8_unicode_ci NOT NULL COMMENT 'chức vụ:Nhân viên/Trưởng nhóm/trưởng phòng/thư kí/giám đốc...',
  `Status` varchar(20) collate utf8_unicode_ci NOT NULL default 'Thử việc' COMMENT 'nhânviên:kì cựu/chính thức/thời vụ/thử việc/thực tập/nghỉ việc',
  `TaxCode` varchar(13) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`EmployeeID`),
  KEY `FK_employee_department` (`WorkAt`),
  CONSTRAINT `FK_employee_department` FOREIGN KEY (`WorkAt`) REFERENCES `department` (`DepartmentID`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table redsun.employee: ~14 rows (approximately)
DELETE FROM `employee`;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` (`EmployeeID`, `UID`, `Username`, `Password`, `LastName`, `MiddleName`, `FirstName`, `WorkAt`, `Position`, `Status`, `TaxCode`) VALUES
	(37, NULL, 'user1', '123456abcdfe123', 'Sử', 'Cao Minh', 'Luân', 1, 'nhân viên', 'bị đuổi', NULL),
	(38, NULL, 'user2', '123456', 'Sử', 'Cao Minh', 'Luân', 1, 'nhân viên', 'bị đuổi', NULL),
	(39, NULL, 'user3', '123456', 'Sử', 'Cao Minh', ':Luân', 1, 'trưởng phòng', 'chính thức', NULL),
	(40, NULL, 'dragonlittle', NULL, 'Sử', 'Cao Minh', ':Luân', 1, 'trưởng phòng', 'chính thức', NULL),
	(41, NULL, 'tdt', NULL, 'Trương', 'Đại', 'Thành', 1, 'giám đốc', 'chính thức', NULL),
	(42, NULL, 'wba', NULL, 'Wanbi', '', 'Tuấn Anh', 1, 'phó phòng', 'chính thức', NULL),
	(43, NULL, 'tt', NULL, '', '', 'Trấn Thành', 1, 'system admin', 'chính thức', NULL),
	(44, NULL, 'abc', NULL, 'a', 'b', 'c', 1, 'nhân viên', 'bị đuổi', NULL),
	(45, NULL, 'luutrantrongtin', '123456abccbadef', 'Lê', 'Thành', 'Danh', 1, 'nhân viên', 'chính thức', NULL),
	(46, NULL, 'luutin', NULL, 'Lưu', 'Trần Trọng', 'Tín', 1, 'system admin', 'thực tập', NULL),
	(47, NULL, 'luutin123', NULL, 'Lưu', 'Trần Trọng', 'Tín', 1, 'system admin', 'nghỉ hưu', NULL),
	(48, NULL, 'skyboy', '123', 'Lưu', 'Trần Trọng', 'Tín', 1, 'trưởng nhóm', 'nghỉ phép', NULL),
	(49, NULL, 'thientai', 'JMs3cJI7l', 'thien', 'van tai', 'hai', 1, 'nhân viên', 'chính thức', NULL),
	(50, NULL, 'vodung', '123456gLGM5YcAq', 'thien', 'van tai', 'hai', 1, 'nhân viên', 'chính thức', NULL);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;


-- Dumping structure for table redsun.employee_changelog
DROP TABLE IF EXISTS `employee_changelog`;
CREATE TABLE IF NOT EXISTS `employee_changelog` (
  `EmployeeID` mediumint(8) unsigned NOT NULL,
  `Field` varchar(15) collate utf8_unicode_ci NOT NULL,
  `OldValue` varchar(33) collate utf8_unicode_ci NOT NULL,
  `NewValue` varchar(33) collate utf8_unicode_ci NOT NULL,
  `Date` datetime NOT NULL,
  `LastUpdate` datetime NOT NULL,
  KEY `FK_employee_changelog_employee` (`EmployeeID`),
  CONSTRAINT `FK_employee_changelog_employee` FOREIGN KEY (`EmployeeID`) REFERENCES `employee` (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT COMMENT='lưu lại lịch sử các lần thay đổi thông tin nhân viên';

-- Dumping data for table redsun.employee_changelog: ~0 rows (approximately)
DELETE FROM `employee_changelog`;
/*!40000 ALTER TABLE `employee_changelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee_changelog` ENABLE KEYS */;


-- Dumping structure for table redsun.employee_detail
DROP TABLE IF EXISTS `employee_detail`;
CREATE TABLE IF NOT EXISTS `employee_detail` (
  `EmployeeID` mediumint(8) unsigned NOT NULL,
  `Birthday_Day` tinyint(2) unsigned default NULL,
  `Birthday_Month` tinyint(2) unsigned default NULL,
  `Birthday_Year` smallint(4) unsigned default NULL,
  `HireDate` date NOT NULL,
  `Address` varchar(30) collate utf8_unicode_ci default NULL,
  `District` varchar(20) collate utf8_unicode_ci default NULL,
  `City` varchar(20) collate utf8_unicode_ci default NULL,
  `Phone` varchar(33) collate utf8_unicode_ci default NULL,
  `Avatar` varchar(150) collate utf8_unicode_ci default NULL,
  KEY `FK_employee_detail_employee` (`EmployeeID`),
  CONSTRAINT `FK_employee_detail_employee` FOREIGN KEY (`EmployeeID`) REFERENCES `employee` (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table redsun.employee_detail: ~14 rows (approximately)
DELETE FROM `employee_detail`;
/*!40000 ALTER TABLE `employee_detail` DISABLE KEYS */;
INSERT INTO `employee_detail` (`EmployeeID`, `Birthday_Day`, `Birthday_Month`, `Birthday_Year`, `HireDate`, `Address`, `District`, `City`, `Phone`, `Avatar`) VALUES
	(37, 4, 6, 1989, '0000-00-00', '138 Lê Thiệt', 'Tân Phú', 'Hồ Chí Minh', '121', 'fafaf'),
	(38, 4, 6, 1989, '2013-07-31', '138 Lê Thiệt', 'Tân Phú', 'Hồ Chí Minh', '121', 'fafaf'),
	(39, 4, 6, 1989, '2013-07-19', '138 Lê Thiệt', 'Tân Phú', 'Hồ Chí Minh', '09336', 'oasdasd'),
	(40, 4, 6, 1989, '0000-00-00', '138 Lê Thiệt', 'Tân Phú', 'Hồ Chí Minh', '09336', 'oasdasd'),
	(41, 1, 2, 1456, '2013-08-27', '138 Lê Thiệt', '11', 'Hồ Chí Minh', '3123123', 'werhgsa'),
	(42, 1, 2, 1456, '2013-08-07', '123fsgdh', '1', 'Hồ Chí Minh', '3123123', 'werhgsa'),
	(43, 1, 2, 1456, '2013-08-15', '123fsgdh', '1', 'Hồ Chí Minh', '3123123', 'werhgsa'),
	(44, 13, 9, 1990, '2013-09-17', 'wf', 'wf', 'TP Hồ chí Minh', '243', 'fs'),
	(45, 1, 1, 1990, '2013-09-17', 'asc', 'sac', 'Hồ Chí Minh', '24546', 'sds'),
	(46, 13, 9, 1990, '0000-00-00', 'wf', 'wf', 'Hà Nội', '243', 'fs'),
	(47, 13, 9, 1990, '2013-09-18', 'wf igg iggk', 'wf', 'Hà Nội', '243', 'fs'),
	(48, 13, 9, 1990, '2013-09-17', 'wf', 'wf', 'Hồ Chí Minh', '243', 'fs'),
	(49, 13, 1, 1989, '0000-00-00', 'asc', 'sac', 'Hồ Chí Minh', '243', 'fssfsf'),
	(50, 13, 1, 1989, '2013-09-23', 'asc', 'sac', 'Hồ Chí Minh', '243', 'fssfsf');
/*!40000 ALTER TABLE `employee_detail` ENABLE KEYS */;


-- Dumping structure for table redsun.employee_position
DROP TABLE IF EXISTS `employee_position`;
CREATE TABLE IF NOT EXISTS `employee_position` (
  `ID` tinyint(3) unsigned NOT NULL auto_increment,
  `Name` varchar(20) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`ID`,`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT COMMENT='tình trạng nhân viên';

-- Dumping data for table redsun.employee_position: ~7 rows (approximately)
DELETE FROM `employee_position`;
/*!40000 ALTER TABLE `employee_position` DISABLE KEYS */;
INSERT INTO `employee_position` (`ID`, `Name`) VALUES
	(1, 'nhân viên'),
	(2, 'trưởng nhóm'),
	(3, 'phó phòng'),
	(4, 'trưởng phòng'),
	(5, 'phó giám  đốc'),
	(6, 'giám đốc'),
	(7, 'system admin');
/*!40000 ALTER TABLE `employee_position` ENABLE KEYS */;


-- Dumping structure for table redsun.employee_status
DROP TABLE IF EXISTS `employee_status`;
CREATE TABLE IF NOT EXISTS `employee_status` (
  `Name` varchar(20) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='tình trạng nhân viên';

-- Dumping data for table redsun.employee_status: ~8 rows (approximately)
DELETE FROM `employee_status`;
/*!40000 ALTER TABLE `employee_status` DISABLE KEYS */;
INSERT INTO `employee_status` (`Name`) VALUES
	('chính thức'),
	('đuổi việc'),
	('nghỉ hưu'),
	('nghỉ phép'),
	('sinh con'),
	('thôi việc'),
	('thử việc'),
	('thực tập');
/*!40000 ALTER TABLE `employee_status` ENABLE KEYS */;


-- Dumping structure for table redsun.equipment
DROP TABLE IF EXISTS `equipment`;
CREATE TABLE IF NOT EXISTS `equipment` (
  `EquipmentID` mediumint(8) unsigned NOT NULL auto_increment,
  `Name` varchar(20) collate utf8_unicode_ci NOT NULL,
  `SupplierID` mediumint(8) unsigned NOT NULL,
  `Price` mediumint(8) unsigned default NULL,
  `Unit` varchar(10) collate utf8_unicode_ci default NULL,
  `AvatarURL` varchar(150) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`EquipmentID`),
  KEY `FK_equipment_supplier` (`SupplierID`),
  CONSTRAINT `FK_equipment_supplier` FOREIGN KEY (`SupplierID`) REFERENCES `supplier` (`SupplierID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='trang thiết bị';

-- Dumping data for table redsun.equipment: ~0 rows (approximately)
DELETE FROM `equipment`;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;


-- Dumping structure for procedure redsun.GetCustByID
DROP PROCEDURE IF EXISTS `GetCustByID`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustByID`(IN `id` int(10))
BEGIN
SELECT *
FROM customer_detail, customer
WHERE customer.CustomerID=id and customer.CustomerID=customer_detail.CustomerID;
END//
DELIMITER ;


-- Dumping structure for procedure redsun.GetEmpByID
DROP PROCEDURE IF EXISTS `GetEmpByID`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEmpByID`(IN `id` mediumint(8))
BEGIN
	SELECT *
FROM employee,employee_detail
WHERE employee.EmployeeID=employee_detail.EmployeeID and employee.EmployeeID=id;

END//
DELIMITER ;


-- Dumping structure for procedure redsun.GetEmpByName
DROP PROCEDURE IF EXISTS `GetEmpByName`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEmpByName`(IN `ho` varchar(20),IN `lot` varchar(20),IN `ten` varchar(20))
BEGIN


SELECT *
FROM employee,employee_detail
WHERE employee.EmployeeID=employee_detail.EmployeeID and
(employee.LastName LIKE CONCAT("%",ho,"%") AND employee.MiddleName LIKE CONCAT("%",lot,"%")) AND employee.FirstName LIKE CONCAT("%",ten,"%");

END//
DELIMITER ;


-- Dumping structure for procedure redsun.GetEmpByWorkAt
DROP PROCEDURE IF EXISTS `GetEmpByWorkAt`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEmpByWorkAt`(IN `id` mediumint(8))
BEGIN
	
SELECT *
FROM employee,employee_detail
WHERE employee.EmployeeID=employee_detail.EmployeeID and employee.WorkAt=id;

END//
DELIMITER ;


-- Dumping structure for procedure redsun.GetSuppByID
DROP PROCEDURE IF EXISTS `GetSuppByID`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSuppByID`(IN `id` mediumint(8))
BEGIN
	SELECT * FROM supplier WHERE SupplierID=id;

END//
DELIMITER ;


-- Dumping structure for table redsun.ingredent
DROP TABLE IF EXISTS `ingredent`;
CREATE TABLE IF NOT EXISTS `ingredent` (
  `IngredentID` mediumint(8) unsigned NOT NULL auto_increment,
  `Name` varchar(20) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`IngredentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='nguyên liệu chế biến';

-- Dumping data for table redsun.ingredent: ~0 rows (approximately)
DELETE FROM `ingredent`;
/*!40000 ALTER TABLE `ingredent` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingredent` ENABLE KEYS */;


-- Dumping structure for table redsun.ingredent_changelog
DROP TABLE IF EXISTS `ingredent_changelog`;
CREATE TABLE IF NOT EXISTS `ingredent_changelog` (
  `IngredentID` mediumint(8) unsigned NOT NULL,
  `Field` varchar(15) collate utf8_unicode_ci NOT NULL,
  `OldValue` varchar(30) collate utf8_unicode_ci NOT NULL,
  `NewValue` varchar(30) collate utf8_unicode_ci NOT NULL,
  `Date` datetime NOT NULL,
  `LastUpdate` datetime NOT NULL,
  KEY `FK_ingredent_changelog_ingredent` (`IngredentID`),
  CONSTRAINT `FK_ingredent_changelog_ingredent` FOREIGN KEY (`IngredentID`) REFERENCES `ingredent` (`IngredentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT COMMENT='lưu lại lịch sử các lần thay đổi thông tin nguyên liệu chế b';

-- Dumping data for table redsun.ingredent_changelog: ~0 rows (approximately)
DELETE FROM `ingredent_changelog`;
/*!40000 ALTER TABLE `ingredent_changelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingredent_changelog` ENABLE KEYS */;


-- Dumping structure for table redsun.ingredent_detail
DROP TABLE IF EXISTS `ingredent_detail`;
CREATE TABLE IF NOT EXISTS `ingredent_detail` (
  `IngredentID` mediumint(8) unsigned NOT NULL,
  `SupplierID` mediumint(8) unsigned NOT NULL,
  `Price` mediumint(8) unsigned default NULL,
  `AvatarURL` varchar(150) collate utf8_unicode_ci default NULL,
  `MeasurementUnit` varchar(10) collate utf8_unicode_ci default NULL,
  `Color` varchar(10) collate utf8_unicode_ci default NULL,
  `InStock` mediumint(8) unsigned NOT NULL,
  KEY `FK_ingredent_detail_ingredent` (`IngredentID`),
  KEY `FK_ingredent_detail_supplier` (`SupplierID`),
  CONSTRAINT `FK_ingredent_detail_ingredent` FOREIGN KEY (`IngredentID`) REFERENCES `ingredent` (`IngredentID`),
  CONSTRAINT `FK_ingredent_detail_supplier` FOREIGN KEY (`SupplierID`) REFERENCES `supplier` (`SupplierID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='thông tin chi tiết về nguyên liệu';

-- Dumping data for table redsun.ingredent_detail: ~0 rows (approximately)
DELETE FROM `ingredent_detail`;
/*!40000 ALTER TABLE `ingredent_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingredent_detail` ENABLE KEYS */;


-- Dumping structure for table redsun.invoice
DROP TABLE IF EXISTS `invoice`;
CREATE TABLE IF NOT EXISTS `invoice` (
  `invoiceID` int(10) unsigned NOT NULL auto_increment,
  `CustomerID` int(10) unsigned NOT NULL,
  `EmployeeID` mediumint(8) unsigned NOT NULL COMMENT 'nhân viên tính tiền',
  `Total` int(10) unsigned NOT NULL,
  `Time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Location` varchar(30) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`invoiceID`),
  KEY `FK__customer` (`CustomerID`),
  KEY `FK__employee` (`EmployeeID`),
  CONSTRAINT `FK__customer` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),
  CONSTRAINT `FK__employee` FOREIGN KEY (`EmployeeID`) REFERENCES `employee` (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table redsun.invoice: ~0 rows (approximately)
DELETE FROM `invoice`;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;


-- Dumping structure for table redsun.invoice_detail
DROP TABLE IF EXISTS `invoice_detail`;
CREATE TABLE IF NOT EXISTS `invoice_detail` (
  `InvoiceID` int(10) unsigned NOT NULL,
  `DishID` mediumint(8) unsigned NOT NULL,
  `Quantity` smallint(5) unsigned NOT NULL,
  `Price` mediumint(8) unsigned NOT NULL,
  KEY `FK__invoice` (`InvoiceID`),
  KEY `FK__dish` (`DishID`),
  CONSTRAINT `FK__dish` FOREIGN KEY (`DishID`) REFERENCES `dish` (`DishID`),
  CONSTRAINT `FK__invoice` FOREIGN KEY (`InvoiceID`) REFERENCES `invoice` (`invoiceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='chi tiết hóa đơn';

-- Dumping data for table redsun.invoice_detail: ~0 rows (approximately)
DELETE FROM `invoice_detail`;
/*!40000 ALTER TABLE `invoice_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_detail` ENABLE KEYS */;


-- Dumping structure for procedure redsun.LoginCustomer
DROP PROCEDURE IF EXISTS `LoginCustomer`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `LoginCustomer`(IN `u` varchar(20),IN `p` varchar(20))
BEGIN
	SELECT CustomerID, UID, Grade, TaxCode
FROM customer
WHERE Username=u and SUBSTRING(`Password`, 1, CHAR_LENGTH(`Password`)-9)=p;

END//
DELIMITER ;


-- Dumping structure for procedure redsun.LoginEmployee
DROP PROCEDURE IF EXISTS `LoginEmployee`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `LoginEmployee`(IN `u` varchar(20),IN `p` varchar(20))
BEGIN
	SELECT EmployeeID, UID, CONCAT_WS(" ",LastName,MiddleName,FirstName)as FullName, WorkAt, Position, `Status`
FROM employee
WHERE Username=u and SUBSTRING(`Password`, 1, CHAR_LENGTH(`Password`)-9)=p;

END//
DELIMITER ;


-- Dumping structure for table redsun.message
DROP TABLE IF EXISTS `message`;
CREATE TABLE IF NOT EXISTS `message` (
  `MessageID` int(10) unsigned NOT NULL auto_increment,
  `ReplyTo` int(10) unsigned default NULL,
  `Subject` varchar(30) collate utf8_unicode_ci NOT NULL COMMENT 'tiêu đề',
  `Content` text collate utf8_unicode_ci COMMENT 'nội dung tin nhắn',
  `Status` tinyint(1) unsigned default NULL COMMENT 'tin có được đọc chưa',
  `Attachment` tinyint(1) unsigned default NULL COMMENT 'link đính kèm',
  PRIMARY KEY  (`MessageID`),
  KEY `FK_message_message` (`ReplyTo`),
  CONSTRAINT `FK_message_message` FOREIGN KEY (`ReplyTo`) REFERENCES `message` (`MessageID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='hệ thống tin nhắn';

-- Dumping data for table redsun.message: ~11 rows (approximately)
DELETE FROM `message`;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` (`MessageID`, `ReplyTo`, `Subject`, `Content`, `Status`, `Attachment`) VALUES
	(1, NULL, 'abc', 'ab hvk kjsdv bdvm kbvk kdv', NULL, NULL),
	(2, NULL, 'abc', 'ab hvk kjsdv bdvm kbvk kdv', NULL, NULL),
	(5, NULL, 'abc', 'rg dg ge geg g', 1, NULL),
	(6, NULL, 'alo alo', '', 1, NULL),
	(7, NULL, 'muốn gì?', 'mày là thằng nào?', NULL, NULL),
	(8, 1, 'ABC', 'DV', NULL, NULL),
	(9, 6, 'alo alo', '', 1, NULL),
	(10, 6, 'alo alo', 'reply', 1, NULL),
	(11, 10, 'alo alo', 'mày là thằng nào?', 1, NULL),
	(12, NULL, 'thử cái coi', 'Grand Palace gửi tặng đến khách hàng gói dịch vụ tổ chức tiệc cưới trọn gói cao cấp với mức giá ưu đãi tốt nhất, 3,450,000 chỉ áp dụng duy nhất cho 3 tháng cuối năm 2013. Lễ cưới hoàn hảo của bạn sẽ được diễn ra trong một không gian sang trọng, lối trang trí ấn tượng , ẩm thực đa dạng và phong cách phục vụ chu đáo, để ngày cưới của bạn không chỉ mang phong cách riêng mà còn để lại ấn tượng đáng nhớ cho khách tham dự .\r\n\r\nDịch vụ kèm theo:\r\n\r\nPhong cách bày trí sảnh tiệc theo phong cách Châu Âu sang trọng\r\nDịch vu tiệc cưới chuyên nghiệp, phục vụ kèm theo bữa ăn nhẹ cho Cô dâu và Chú rể\r\nChương trình cử hành lễ ra mắt quan khách ấn tượng với sự hỗ trợ hoàn hảo của đội ngũ khánh tiết, người dẫn chương trình, và hệ thống âm thanh ánh sáng tạo hiệu ứng trực quan sinh động\r\nẨm thực tiệc cưới đa dạng từ nhiều trường phái ẩm thực kèm theo phục vụ thức uống trọn gói', 1, NULL),
	(13, 12, 'thử cái coi', 'Chắc hẳn bạn đã bỏ túi được khá nhiều mẹo khi sư dụng giày, nhưng có thể bạn chưa biết đến những mẹo hay sau. Chúng tôi xin tiếp tục tổng hợp một số mẹo hay khi bạn muốn bảo quản tốt giày, hy vọng bạn sẽ có những đôi giày bền đẹp nhất\r\n\r\n=> 4 mẹo hay hồi xuân đôi giày của bạn (p1)\r\n\r\n1. Cách giữ sạch dây giày màu trắng\r\n\r\nNếu khi dây giày của bạn là màu trắng, bạn sợ rằng lỗ luồn dây giày sẽ làm bẩn dây, bạn có thể quét lên lỗ luồn dây 1 ít thuốc đánh móng tay là được.\r\n\r\n2. Điều cần lưu ý khi phơi giày vải\r\n\r\nSau khi giặt sạch giày vải, ta nên nhét vào mũi giày những hòn đá cuội đã được rửa sạch, sau khi giày khô, giày sẽ không bị biến dạng, không bị co.', 1, NULL);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;


-- Dumping structure for table redsun.message_receiver
DROP TABLE IF EXISTS `message_receiver`;
CREATE TABLE IF NOT EXISTS `message_receiver` (
  `MessageID` int(10) unsigned NOT NULL,
  `EmployeeID` mediumint(8) unsigned NOT NULL,
  `Time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Starred` tinyint(1) unsigned default NULL,
  `IsTrash` tinyint(1) unsigned default NULL,
  KEY `FK_message_receiver_message` (`MessageID`),
  KEY `FK_message_receiver_employee` (`EmployeeID`),
  CONSTRAINT `FK_message_receiver_employee` FOREIGN KEY (`EmployeeID`) REFERENCES `employee` (`EmployeeID`),
  CONSTRAINT `FK_message_receiver_message` FOREIGN KEY (`MessageID`) REFERENCES `message` (`MessageID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='người nhận tin';

-- Dumping data for table redsun.message_receiver: ~11 rows (approximately)
DELETE FROM `message_receiver`;
/*!40000 ALTER TABLE `message_receiver` DISABLE KEYS */;
INSERT INTO `message_receiver` (`MessageID`, `EmployeeID`, `Time`, `Starred`, `IsTrash`) VALUES
	(1, 45, '2013-09-25 08:25:48', NULL, NULL),
	(2, 45, '2013-09-25 08:26:05', NULL, NULL),
	(5, 50, '2013-09-25 08:48:18', NULL, NULL),
	(6, 50, '2013-09-25 08:50:45', NULL, NULL),
	(7, 46, '2013-09-25 08:53:29', NULL, NULL),
	(8, 45, '2013-09-25 10:24:09', NULL, NULL),
	(9, 37, '2013-09-25 10:53:56', NULL, NULL),
	(10, 37, '2013-09-25 10:58:59', NULL, NULL),
	(11, 50, '2013-09-25 11:03:43', NULL, NULL),
	(12, 37, '2013-09-25 14:38:43', NULL, NULL),
	(13, 50, '2013-09-25 14:43:07', NULL, NULL);
/*!40000 ALTER TABLE `message_receiver` ENABLE KEYS */;


-- Dumping structure for table redsun.message_sender
DROP TABLE IF EXISTS `message_sender`;
CREATE TABLE IF NOT EXISTS `message_sender` (
  `MessageID` int(10) unsigned NOT NULL,
  `EmployeeID` mediumint(8) unsigned NOT NULL,
  `Time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Important` tinyint(1) unsigned default NULL,
  `IsTrash` tinyint(1) unsigned default NULL,
  KEY `FK_message_sender_message` (`MessageID`),
  KEY `FK_message_sender_employee` (`EmployeeID`),
  CONSTRAINT `FK_message_sender_employee` FOREIGN KEY (`EmployeeID`) REFERENCES `employee` (`EmployeeID`),
  CONSTRAINT `FK_message_sender_message` FOREIGN KEY (`MessageID`) REFERENCES `message` (`MessageID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='người gửi tin';

-- Dumping data for table redsun.message_sender: ~11 rows (approximately)
DELETE FROM `message_sender`;
/*!40000 ALTER TABLE `message_sender` DISABLE KEYS */;
INSERT INTO `message_sender` (`MessageID`, `EmployeeID`, `Time`, `Important`, `IsTrash`) VALUES
	(1, 45, '2013-09-25 08:25:48', NULL, NULL),
	(2, 46, '2013-09-25 08:26:05', NULL, NULL),
	(5, 37, '2013-09-25 08:48:18', NULL, NULL),
	(6, 37, '2013-09-25 08:50:45', NULL, NULL),
	(7, 50, '2013-09-25 08:53:29', NULL, NULL),
	(8, 46, '2013-09-25 10:24:09', NULL, NULL),
	(9, 37, '2013-09-25 10:53:56', NULL, NULL),
	(10, 50, '2013-09-25 10:58:59', NULL, NULL),
	(11, 37, '2013-09-25 11:03:43', NULL, NULL),
	(12, 50, '2013-09-25 14:38:43', NULL, NULL),
	(13, 37, '2013-09-25 14:43:07', NULL, NULL);
/*!40000 ALTER TABLE `message_sender` ENABLE KEYS */;


-- Dumping structure for table redsun.order
DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `OrderID` bigint(20) unsigned NOT NULL auto_increment,
  `CustomerID` int(10) unsigned NOT NULL,
  `DishID` mediumint(8) unsigned NOT NULL,
  `Quantity` smallint(5) unsigned NOT NULL default '1',
  `Price` mediumint(8) unsigned NOT NULL,
  `Status` tinyint(1) unsigned NOT NULL default '0' COMMENT '0:đang chờ; 1: đang xử lý; 2: đang giao hàng; 3: đã xong',
  `ReceiveTime` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT 'thời gian nhận đơn hàng',
  `ProcessingTime` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT 'Thời gian bắt đầu xử lý đơn hàng',
  `DeliveryTime` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT 'Thời gian giao hàng',
  `FinishTime` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT 'Thời gian xử lý xong đơn hàng',
  PRIMARY KEY  (`OrderID`),
  KEY `FK_order_customer` (`CustomerID`),
  KEY `FK_order_dish` (`DishID`),
  CONSTRAINT `FK_order_customer` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),
  CONSTRAINT `FK_order_dish` FOREIGN KEY (`DishID`) REFERENCES `dish` (`DishID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='danh sách đặt hàng';

-- Dumping data for table redsun.order: ~0 rows (approximately)
DELETE FROM `order`;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;


-- Dumping structure for procedure redsun.RegisterCustomer
DROP PROCEDURE IF EXISTS `RegisterCustomer`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegisterCustomer`(IN `u` varchar(20),IN `p` varchar(20),IN `ho` varchar(10),IN `lot` varchar(10),IN`ten` varchar(10),ngay mediumint(2), thang mediumint(2), nam mediumint(4),IN `dc` varchar(30),IN `tp` varchar(20),IN `q` varchar(20),IN `dt` varchar(33),IN `email` varchar(30),IN `joindate` date)
BEGIN
	

DECLARE id int(10) UNSIGNED;

START TRANSACTION;
INSERT into customer(customer.Username,customer.`Password`) VALUES(u,p);
set id= LAST_INSERT_ID();
INSERT INTO customer_detail(customer_detail.CustomerID,customer_detail.LastName,customer_detail.MiddleName,customer_detail.FirstName, customer_detail.Birthday_Day, customer_detail.Birthday_Month, customer_detail.Birthday_Year, customer_detail.Address,customer_detail.City, customer_detail.District, customer_detail.Phone, customer_detail.Email, customer_detail.JoinDate)
VALUES (id,ho,lot,ten,ngay,thang,nam,dc,tp,q,dt,email,joindate);
COMMIT;
END//
DELIMITER ;


-- Dumping structure for procedure redsun.RegisterCustomer2
DROP PROCEDURE IF EXISTS `RegisterCustomer2`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegisterCustomer2`(IN `id` int(10),IN `u` varchar(20),IN `p` varchar(20),IN `ho` varchar(10),IN `lot` varchar(10),IN`ten` varchar(10),IN `ngay` mediumint(2),IN `thang` mediumint(2),IN `nam` mediumint(4),IN `dc` varchar(30),IN `tp` varchar(20),IN `q` varchar(20),IN `dt` varchar(33),IN `email` varchar(30),IN `joindate` date)
BEGIN

START TRANSACTION;
UPDATE customer SET Username=u, `Password`=p WHERE CustomerID=id;
UPDATE customer_detail
SET customer_detail.LastName=ho,customer_detail.MiddleName=lot,customer_detail.FirstName=ten, customer_detail.Birthday_Day=ngay, customer_detail.Birthday_Month=thang, customer_detail.Birthday_Year=nam, customer_detail.Address=dc,customer_detail.City=tp, customer_detail.District=q, customer_detail.Phone=dt, customer_detail.Email=email, customer_detail.JoinDate=joindate
WHERE CustomerID=id;

COMMIT;
END//
DELIMITER ;


-- Dumping structure for procedure redsun.RegisterEmployee
DROP PROCEDURE IF EXISTS `RegisterEmployee`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegisterEmployee`(IN `username` varchar(20),IN `pass` varchar(20), IN `lastName` varchar(10), IN `middleName` varchar(10), IN `firstName` varchar(10),IN `workAt` mediumint(8), IN `position` varchar(20), IN `status` varchar(20), IN `bDay` TINYINT, IN `bMonth` tinyint, IN `bYear` smaLLINT, IN `hireDate` daTE, IN `address` varchar(30), IN `district` varchar(20), IN `city` varchar(20), IN `phone` varchar(33), IN `avatar` varchar(150))
BEGIN

DECLARE newID mediumint UNSIGNED;

START TRANSACTION;
insert into employee(employee.Username,employee.`Password`,employee.LastName, employee.MiddleName,employee.FirstName,employee.WorkAt, employee.Position,employee.`Status`)
VALUES (username,pass,lastName,middleName,firstName,workAt,position,status);


set newID = LAST_INSERT_ID();

insert into employee_detail (employee_detail.EmployeeID,employee_detail.Birthday_Day,employee_detail.Birthday_Month,employee_detail.Birthday_Year,employee_detail.HireDate,employee_detail.Address,employee_detail.District,employee_detail.City,employee_detail.Phone,employee_detail.Avatar)
VALUES(newID,bDay,bMonth,bYear,hireDate,address,district,city,phone,avatar);
COMMIT;

END//
DELIMITER ;


-- Dumping structure for procedure redsun.ReplyMessage
DROP PROCEDURE IF EXISTS `ReplyMessage`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `ReplyMessage`(IN `reply` INT(10), IN `sendid` INT(10), IN `receiverid` INT(10), IN `subject` VARCHAR(30), IN `content` TEXT)
BEGIN
DECLARE id int(10) UNSIGNED;

START TRANSACTION;
INSERT into message(message.ReplyTo,message.Subject, message.Content) VALUES(reply,subject,content);
set id= LAST_INSERT_ID();
INSERT INTO message_sender(message_sender.MessageID, message_sender.EmployeeID, message_sender.Time) VALUES (id,sendid,NOW());
INSERT INTO message_receiver(message_receiver.MessageID, message_receiver.EmployeeID, message_receiver.Time) VALUES (id,receiverid,NOW());
COMMIT;
END//
DELIMITER ;


-- Dumping structure for table redsun.resource
DROP TABLE IF EXISTS `resource`;
CREATE TABLE IF NOT EXISTS `resource` (
  `TaskID` int(10) unsigned NOT NULL,
  `EmployeeID` mediumint(8) unsigned NOT NULL,
  `Status` tinyint(1) unsigned default NULL COMMENT 'null:live; others: dead',
  `JoinDate` timestamp NOT NULL default CURRENT_TIMESTAMP,
  KEY `FK_resource_employee` (`EmployeeID`),
  KEY `FK_resource_task` (`TaskID`),
  CONSTRAINT `FK_resource_employee` FOREIGN KEY (`EmployeeID`) REFERENCES `employee` (`EmployeeID`),
  CONSTRAINT `FK_resource_task` FOREIGN KEY (`TaskID`) REFERENCES `task` (`TaskID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='các nguồn lực tham gia vào 1 task';

-- Dumping data for table redsun.resource: ~0 rows (approximately)
DELETE FROM `resource`;
/*!40000 ALTER TABLE `resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `resource` ENABLE KEYS */;


-- Dumping structure for procedure redsun.SendMessage
DROP PROCEDURE IF EXISTS `SendMessage`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SendMessage`(IN `sendid` INT(10), IN `receiverid` INT(10), IN `subject` VARCHAR(30), IN `content` TEXT)
BEGIN

DECLARE id int(10) UNSIGNED;

START TRANSACTION;
INSERT into message(message.Subject, message.Content) VALUES(subject,content);
set id= LAST_INSERT_ID();
INSERT INTO message_sender(message_sender.MessageID, message_sender.EmployeeID, message_sender.Time) VALUES (id,sendid,NOW());
INSERT INTO message_receiver(message_receiver.MessageID, message_receiver.EmployeeID, message_receiver.Time) VALUES (id,receiverid,NOW());
COMMIT;

END//
DELIMITER ;


-- Dumping structure for table redsun.supplier
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE IF NOT EXISTS `supplier` (
  `SupplierID` mediumint(8) unsigned NOT NULL auto_increment,
  `Type` varchar(50) collate utf8_unicode_ci NOT NULL,
  `Name` varchar(20) collate utf8_unicode_ci NOT NULL,
  `Address` varchar(30) collate utf8_unicode_ci default NULL,
  `District` varchar(20) collate utf8_unicode_ci default NULL,
  `City` varchar(20) collate utf8_unicode_ci default NULL,
  `PhoneNumber` varchar(33) collate utf8_unicode_ci default NULL,
  `Contact` varchar(20) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`SupplierID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='các nhà cung cấp';

-- Dumping data for table redsun.supplier: ~3 rows (approximately)
DELETE FROM `supplier`;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` (`SupplierID`, `Type`, `Name`, `Address`, `District`, `City`, `PhoneNumber`, `Contact`) VALUES
	(1, 'svs', 'sv', 'sv', 'sv', 'sv', 'sdv', 'sv'),
	(2, 'werfre', 'wf', 'wf', 'wf', 'wef', 'wf', 'wf'),
	(3, 'SDVDSV', 'D', 'DS', 'd', 'Hà Nội', '12', 'ds');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;


-- Dumping structure for table redsun.task
DROP TABLE IF EXISTS `task`;
CREATE TABLE IF NOT EXISTS `task` (
  `TaskID` int(10) unsigned NOT NULL auto_increment,
  `UID` varchar(15) collate utf8_unicode_ci NOT NULL,
  `Name` varchar(30) collate utf8_unicode_ci NOT NULL,
  `HasChild` tinyint(1) default NULL COMMENT 'null: không có',
  `UpperTask` int(10) unsigned default NULL COMMENT 'TaskID cha',
  `AccessLevel` tinyint(1) unsigned NOT NULL COMMENT 'Quyền được xem',
  `AssignBy` mediumint(8) unsigned NOT NULL COMMENT 'người tạo task',
  `StartDate` date default NULL COMMENT 'ngày bắt đầu dự kiến',
  `Duration` tinyint(3) unsigned default NULL COMMENT 'số ngày dự kiến',
  `ActualStartDate` date default NULL COMMENT 'ngày bắt đầu thực tế',
  `ActualDuration` tinyint(3) unsigned default NULL COMMENT 'số ngày thực tế',
  `Status` tinyint(3) unsigned NOT NULL default '0' COMMENT 'phần trăm hoàn thành',
  PRIMARY KEY  (`TaskID`),
  KEY `FK_task_task` (`UpperTask`),
  KEY `AssignBy` (`AssignBy`),
  CONSTRAINT `FK_task_task` FOREIGN KEY (`UpperTask`) REFERENCES `task` (`TaskID`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table redsun.task: ~27 rows (approximately)
DELETE FROM `task`;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` (`TaskID`, `UID`, `Name`, `HasChild`, `UpperTask`, `AccessLevel`, `AssignBy`, `StartDate`, `Duration`, `ActualStartDate`, `ActualDuration`, `Status`) VALUES
	(8, '', 'Nhiệm vụ A', 1, NULL, 1, 37, '2013-07-01', 1, NULL, NULL, 0),
	(9, '', 'Nhiệm vụ B', 1, NULL, 1, 37, '2013-05-22', 5, NULL, NULL, 0),
	(10, '', 'Nhiệm vụ C', 1, NULL, 3, 37, '2013-05-22', 5, NULL, NULL, 0),
	(11, '', 'Nhiệm vụ E', NULL, NULL, 5, 37, '2013-05-22', 5, NULL, NULL, 0),
	(13, '', 'Nhiệm vụ D', NULL, NULL, 1, 37, '2013-08-14', 2, NULL, NULL, 0),
	(39, '', 'Nhiệm vụ A1', 1, 8, 1, 37, '2013-08-25', 2, NULL, NULL, 0),
	(40, '', 'Nhiệm vụ E', 1, NULL, 1, 37, '2013-08-14', 5, NULL, NULL, 0),
	(42, '', 'Nhiệm vụ B1', 1, 9, 3, 37, '2013-08-06', 2, NULL, NULL, 0),
	(43, '', 'Nhiệm vụ B2', NULL, 9, 1, 37, '2013-08-06', 2, NULL, NULL, 0),
	(44, '', 'Nhiệm vụ B3', NULL, 9, 1, 37, '2013-08-06', 2, NULL, NULL, 0),
	(45, '', 'Nhiệm vụ C1', NULL, 10, 6, 37, '2013-08-06', 5, NULL, NULL, 0),
	(47, '', 'Nhiệm vụ F', 1, NULL, 1, 37, '2013-08-13', 2, NULL, NULL, 0),
	(48, '', 'Nhiệm vụ C2', NULL, 10, 2, 37, '2013-08-05', 5, NULL, NULL, 0),
	(49, '', 'Nhiệm vụ A2', NULL, 8, 1, 37, '2013-08-21', 5, NULL, NULL, 0),
	(50, '', 'Nhiệm vụ A3', NULL, 8, 1, 37, '2013-08-21', 5, NULL, NULL, 0),
	(51, '', 'Nhiệm vụ A4', NULL, 8, 1, 37, '2013-08-21', 5, NULL, NULL, 0),
	(52, '', 'Nhiệm vụ B1', NULL, 9, 1, 37, '2013-08-06', 5, NULL, NULL, 0),
	(53, '', 'Nhiệm vụ B2', NULL, 9, 1, 37, '2013-08-06', 5, NULL, NULL, 0),
	(54, '', 'Nhiệm vụ E1', NULL, 40, 1, 37, '2013-08-26', 2, NULL, NULL, 0),
	(55, '', 'Nhiệm vụ F1', NULL, 47, 1, 37, '2013-08-06', 2, NULL, NULL, 0),
	(56, '', 'Nhiệm vụ F2', NULL, 47, 1, 37, '2013-08-06', 2, NULL, NULL, 0),
	(57, '', 'Nhiệm vụ A1.1', NULL, 39, 3, 37, '2013-08-08', 2, NULL, NULL, 0),
	(58, '', 'Nhiệm vụ A1.2', NULL, 39, 1, 37, '2013-08-08', 2, NULL, NULL, 0),
	(59, '', 'Nhiệm vụ A1.3', NULL, 39, 1, 37, '2013-08-08', 2, NULL, NULL, 0),
	(60, '', 'Nhiệm vụ B1.1', NULL, 42, 1, 37, '2013-07-30', 34, NULL, NULL, 0),
	(61, '', 'Nhiệm vụ B1.2', NULL, 42, 1, 37, '2013-07-30', 27, NULL, NULL, 0),
	(62, '', 'Nhiệm vụ B1.3', NULL, 42, 1, 37, '2013-07-30', 27, NULL, NULL, 0);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;


-- Dumping structure for procedure redsun.updateCustomer
DROP PROCEDURE IF EXISTS `updateCustomer`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCustomer`(IN `gra` varchar(15),IN `id` int(10),IN `ho` varchar(10),IN `lot` varchar(10),IN`ten` varchar(10),IN `ngay` mediumint(2),IN `thang` mediumint(2),IN `nam` mediumint(4),IN `dc` varchar(30),IN `tp` varchar(20),IN `q` varchar(20),IN `dt` varchar(33),IN `email` varchar(30),IN `joindate` date)
BEGIN

START TRANSACTION;
UPDATE customer SET Grade=gra WHERE CustomerID=id;
UPDATE customer_detail
SET customer_detail.LastName=ho,customer_detail.MiddleName=lot,customer_detail.FirstName=ten, customer_detail.Birthday_Day=ngay, customer_detail.Birthday_Month=thang, customer_detail.Birthday_Year=nam, customer_detail.Address=dc,customer_detail.City=tp, customer_detail.District=q, customer_detail.Phone=dt, customer_detail.Email=email, customer_detail.JoinDate=joindate
WHERE CustomerID=id;

COMMIT;
END//
DELIMITER ;


-- Dumping structure for procedure redsun.UpdateEmployee
DROP PROCEDURE IF EXISTS `UpdateEmployee`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateEmployee`(IN `id` mediumint(8),IN `lastName` varchar(10), IN `middleName` varchar(10), IN `firstName` varchar(10),IN `workAt` mediumint(8), IN `position` varchar(20), IN `status` varchar(20), IN `bDay` TINYINT, IN `bMonth` tinyint, IN `bYear` smaLLINT, IN `address` varchar(30), IN `district` varchar(20), IN `city` varchar(20), IN `phone` varchar(33), IN `avatar` varchar(150))
BEGIN

START TRANSACTION;

UPDATE employee
SET LastName=lastName,MiddleName=middleName,FirstName=firstName,WorkAt=workAt,Position=position,`Status`=status
WHERE EmployeeID=id;

UPDATE employee_detail
SET Birthday_Day=bDay,Birthday_Month=bMonth,Birthday_Year=bYear,Address=address,District=district,City=city,Phone=phone,Avatar=avatar
WHERE EmployeeID=id;

COMMIT;

END//
DELIMITER ;


-- Dumping structure for procedure redsun.UpdateMessage
DROP PROCEDURE IF EXISTS `UpdateMessage`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateMessage`(IN `id` INT(10))
BEGIN
UPDATE message SET message.`Status`=1 WHERE message.MessageID=id;
END//
DELIMITER ;


-- Dumping structure for procedure redsun.UpdateSupplier
DROP PROCEDURE IF EXISTS `UpdateSupplier`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateSupplier`(IN `id` MEDIUMINT(8), IN `types` VARCHAR(50), IN `name` VARCHAR(20), IN `addr` VARCHAR(30), IN `dis` VARCHAR(20), IN `city` VARCHAR(20), IN `phone` VARCHAR(33), IN `contact` VARCHAR(20))
BEGIN
START TRANSACTION;

UPDATE supplier
SET supplier.`Type`=types, supplier.Name=name, supplier.Address=addr, supplier.District=dis, supplier.City=city, supplier.PhoneNumber=phone, supplier.Contact=contact
WHERE supplier.SupplierID=id;

COMMIT;
END//
DELIMITER ;


-- Dumping structure for procedure redsun.ViewCity
DROP PROCEDURE IF EXISTS `ViewCity`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewCity`()
BEGIN
	SELECT `Name` FROM city;

END//
DELIMITER ;


-- Dumping structure for procedure redsun.viewDepartment
DROP PROCEDURE IF EXISTS `viewDepartment`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `viewDepartment`()
BEGIN
	SELECT * FROM department;

END//
DELIMITER ;


-- Dumping structure for procedure redsun.ViewDetailMessage
DROP PROCEDURE IF EXISTS `ViewDetailMessage`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewDetailMessage`(IN `id` INT(10))
BEGIN
SELECT *
FROM message, message_sender, message_receiver
WHERE message.MessageID=message_sender.MessageID and message.MessageID=message_receiver.MessageID and message.MessageID=id;
UPDATE message SET message.`Status`=1 WHERE message.MessageID=id;
END//
DELIMITER ;


-- Dumping structure for procedure redsun.viewEmployee
DROP PROCEDURE IF EXISTS `viewEmployee`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `viewEmployee`(IN `id` mediumint(8))
BEGIN
	select * FROM employee,employee_detail WHERE employee.EmployeeID=employee_detail.EmployeeID and employee.EmployeeID=id;

END//
DELIMITER ;


-- Dumping structure for procedure redsun.ViewEmpPosition
DROP PROCEDURE IF EXISTS `ViewEmpPosition`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewEmpPosition`()
BEGIN
	SELECT ID, `Name`
FROM employee_position;

END//
DELIMITER ;


-- Dumping structure for procedure redsun.ViewEmpStatus
DROP PROCEDURE IF EXISTS `ViewEmpStatus`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewEmpStatus`()
BEGIN
	SELECT * FROM employee_status;

END//
DELIMITER ;


-- Dumping structure for procedure redsun.ViewMessage
DROP PROCEDURE IF EXISTS `ViewMessage`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewMessage`(IN `id` INT(10))
BEGIN
SELECT * FROM message,message_receiver WHERE message_receiver.EmployeeID=id and message.MessageID=message_receiver.MessageID;
UPDATE message SET message.`Status`=1 WHERE message.MessageID=id;
END//
DELIMITER ;


-- Dumping structure for procedure redsun.ViewSupplier
DROP PROCEDURE IF EXISTS `ViewSupplier`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewSupplier`()
BEGIN
	SELECT * FROM supplier;

END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
