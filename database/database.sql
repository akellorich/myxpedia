/*
SQLyog Enterprise v13.1.1 (64 bit)
MySQL - 10.4.32-MariaDB : Database - expediaflightbooking
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`expediaflightbooking` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `expediaflightbooking`;

/*Table structure for table `airlines` */

DROP TABLE IF EXISTS `airlines`;

CREATE TABLE `airlines` (
  `airlineid` int(11) NOT NULL AUTO_INCREMENT,
  `airlinename` varchar(100) DEFAULT NULL,
  `homecountryid` int(11) DEFAULT NULL,
  `logo` varchar(1000) DEFAULT NULL COMMENT 'Path to the file for the logo',
  PRIMARY KEY (`airlineid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `airlines` */

insert  into `airlines`(`airlineid`,`airlinename`,`homecountryid`,`logo`) values 
(1,'Kenya Airways',1,'kq.jpg'),
(3,'Jambo Jet',1,'jambojet.jpg'),
(4,'Fly 540',1,'fly540.jpg');

/*Table structure for table `airports` */

DROP TABLE IF EXISTS `airports`;

CREATE TABLE `airports` (
  `airportid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(3) DEFAULT NULL,
  `airportname` varchar(100) DEFAULT NULL,
  `cityid` int(11) DEFAULT NULL,
  PRIMARY KEY (`airportid`),
  KEY `cityid` (`cityid`),
  CONSTRAINT `airports_ibfk_1` FOREIGN KEY (`cityid`) REFERENCES `cities` (`cityid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `airports` */

insert  into `airports`(`airportid`,`code`,`airportname`,`cityid`) values 
(1,'NBO','Jomo Kenyatta International Airport',1),
(3,'MBA','Moi International Airport',1),
(4,'WIL','Wilson Airport',1);

/*Table structure for table `cities` */

DROP TABLE IF EXISTS `cities`;

CREATE TABLE `cities` (
  `cityid` int(11) NOT NULL AUTO_INCREMENT,
  `cityname` varchar(100) DEFAULT NULL,
  `countryid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cityid`),
  KEY `countryid` (`countryid`),
  CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`countryid`) REFERENCES `countries` (`countryid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `cities` */

insert  into `cities`(`cityid`,`cityname`,`countryid`) values 
(1,'Nairobi',1),
(3,'Mombasa',1),
(4,'Kisumu',1),
(5,'Eldoret',1),
(8,'Entebee',2);

/*Table structure for table `countries` */

DROP TABLE IF EXISTS `countries`;

CREATE TABLE `countries` (
  `countryid` int(11) NOT NULL AUTO_INCREMENT,
  `countryname` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`countryid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `countries` */

insert  into `countries`(`countryid`,`countryname`) values 
(1,'Kenya'),
(2,'Uganda'),
(3,'Tanzania'),
(4,'Ethiopia'),
(5,'Sudan'),
(8,'Eritrea'),
(9,'Burundi');

/*Table structure for table `objects` */

DROP TABLE IF EXISTS `objects`;

CREATE TABLE `objects` (
  `objectid` int(11) NOT NULL AUTO_INCREMENT,
  `objectname` varchar(100) DEFAULT NULL,
  `objectcode` varchar(19) DEFAULT NULL,
  PRIMARY KEY (`objectid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `objects` */

insert  into `objects`(`objectid`,`objectname`,`objectcode`) values 
(1,'Manage airports','1x001'),
(2,'Manage airline','1x002'),
(3,'Manage cities','1x003'),
(4,'Manage countries','1x004'),
(5,'Manage users','2x001');

/*Table structure for table `userprivileges` */

DROP TABLE IF EXISTS `userprivileges`;

CREATE TABLE `userprivileges` (
  `userprivilegeid` int(11) NOT NULL AUTO_INCREMENT,
  `objectid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  `dateadded` datetime DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  PRIMARY KEY (`userprivilegeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `userprivileges` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `salt` varchar(50) DEFAULT NULL,
  `systemadmin` int(11) DEFAULT 0,
  `status` varchar(50) DEFAULT 'active',
  `dateadded` datetime DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  `mobile` varchar(100) DEFAULT NULL,
  `emailaddress` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `users` */

insert  into `users`(`userid`,`username`,`firstname`,`lastname`,`password`,`salt`,`systemadmin`,`status`,`dateadded`,`addedby`,`mobile`,`emailaddress`) values 
(1,'testuser','Richard','','157b9787badb02582d2b78e4d5b1824e1df7fbe77ed69140f400900914fcffe6','qRywszsvMGvDlK9f}2?X',0,'active','2025-11-18 12:57:51',1,'',''),
(2,'Admin','System','Admin','f67df10568f952f8776f01b061f321faad0fc4b1368eb46311650a9159ae52e3','K3]zR}G($h}b8)}G#5*e',0,'active','2025-11-18 13:50:55',1,'0727709772','akellorich@gmail.com');

/* Procedure structure for procedure `sp_checkcity` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_checkcity` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkcity`($cityid int,$cityname varchar(100))
BEGIN
		select * from `cities`
		where `cityid`!=$cityid and `cityname`=$cityname;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_checkcountry` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_checkcountry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkcountry`($countryid int,$countryname varchar(100))
BEGIN
		select * from `countries`
		where `countryid`!=$countryid and `countryname`=$countryname;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_checkusername` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_checkusername` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkusername`($userid int,$username varchar(50))
BEGIN
		select * from `users`
		where userid!=$userid and username=$username;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deleteairline` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deleteairline` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteairline`($airlineid int)
BEGIN
		delete from `airlines`
		where `airlineid`=$airlineid;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deleteairport` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deleteairport` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteairport`($airportid int)
BEGIN
		delete from `airports`
		where `airportid`=$airportid;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deletecity` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deletecity` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deletecity`($cityid int)
BEGIN
		delete from `cities` 
		where `cityid`=$cityid;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deletecountry` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deletecountry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deletecountry`($countryid int)
begin
		delete from `countries`
		where `countryid`=$countryid;
	end */$$
DELIMITER ;

/* Procedure structure for procedure `sp_filterairlines` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_filterairlines` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_filterairlines`($airlinename varchar(100),$countryname varchar(100))
BEGIN	
		if $airlinename='' then
			set $airlinename='@@@';
		end if;
		
		IF $countryname='' THEN
			SET $countryname='@@@';
		END IF;
		
			
		select a.*, countryname
		from `airlines` a
		join `countries` c on c.countryid=a.homecountryid
		where `airlinename` like concat('%',$airlinename,'%')
		or countryname LIKE CONCAT('%',$countryname,'%') 
		order by airlinename;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_filterairports` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_filterairports` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_filterairports`($cityname varchar(100),$airportname varchar(100))
BEGIN
		IF $cityname='' THEN 
			SET $cityname='@@@@';
		END IF;
		
		IF $airportname='' THEN 
			SET $airportname='@@@@';
		END IF;
		
		select a.*, cityname
		from `airports` a 
		join `cities` c on c.cityid=a.cityid
		where c.cityname like concat('%',$cityname,'%')
		or a.airportname like concat('%',$airportname,'%')
		order by cityname,airportname;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_filtercities` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_filtercities` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_filtercities`($countryid int)
BEGIN
		SELECT c.*, countryname 
		FROM `cities` c 
		JOIN `countries` o ON o.countryid=c.countryid
		where ($countryid=0 or c.countryid=$countryid)
		ORDER BY countryname, cityname;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getairlinedetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getairlinedetails` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getairlinedetails`($airlineid int)
BEGIN
		select a.*, countryname
		from `airlines` a
		join `countries` c on c.countryid=a.homecountryid
		where a.airlineid=$airlineid;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getairportdetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getairportdetails` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getairportdetails`($airportid int)
BEGIN
		select a.*, c.cityname, n.countryname
		from `airports` a
		join `cities` c on c.cityid=a.cityid
		join `countries` n on n.countryid=c.countryid
		where a.airportid=$airportid;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getallusers` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getallusers` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getallusers`()
BEGIN
		select u.*, concat(a.firstname,' ',a.lastname) addedbyname
		from `users` u
		join `users` a on a.userid=u.addedby
		order by u.firstname,u.lastname;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getcitydetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getcitydetails` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getcitydetails`($cityid int)
BEGIN
		select * from `cities`
		where `cityid`=$cityid;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getcountries` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getcountries` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getcountries`()
begin
		select * from `countries`
		order by `countryname`;
	end */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getcountrydetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getcountrydetails` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getcountrydetails`($countryid int)
BEGIN
		select * from `countries`
		where `countryid`=$countryid;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getobjects` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getobjects` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getobjects`()
BEGIN
		select * from `objects`
		order by `objectname`;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getuserdetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getuserdetails` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getuserdetails`($userid int)
BEGIN
		select * from `users`
		where `userid`=$userid;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_saveairline` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_saveairline` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_saveairline`($airlineid int,$airlinename varchar(100),$homecountryid int,$logo varchar(1000))
BEGIN
		-- Check if adding a new airline
		if $airlineid=0 then
			-- Check if airline name exists
			if not exists(select * from `airlines` where `airlinename`=$airlinename) then 
				insert into `airlines`(`airlinename`,`homecountryid`,`logo`)
				values($airlinename,$homecountryid,$logo);
			end if;
		else
			-- Check if airline name exists different from our airlineid 
			if not exists(select * from `airlines` where `airlineid`!=$airlineid and `airlinename`=$airlinename) then
				update `airlines`
				set `airlinename`=$airlinename, `homecountryid`=$homecountryid,`logo`=$logo
				where `airlineid`=$airlineid;
			end if;
		end if;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_saveairport` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_saveairport` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_saveairport`($airportid int,$airportname varchar(100),$airportcode varchar(3),$cityid int)
BEGIN
		-- Check if we are adding new
		if $airportid=0 then
			-- Check airport code or name
			if not exists(select * from `airports` where `code`=$airportcode or `airportname`=$airportname) then
				insert into `airports`(`code`,`airportname`,`cityid`)
				values($airportcode,$airportname,$cityid);
			end if;
		else
			-- Check if code and or name exists
			IF NOT EXISTS(SELECT * FROM `airports` 
			WHERE `airportid`!=$airportid and (`code`=$airportcode OR `airportname`=$airportname)) THEN
				
				update `airports`
				set `code`=$airportcode,`airportname`=$airportname,`cityid`=$cityid
				where `airportid`=$airportid;
				
			end if;
		end if;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_savecity` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_savecity` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecity`($cityid int,$cityname varchar(100),$countryid int)
BEGIN
		-- Check if we are adding a new city i.e. Cityid=0
		if $cityid=0 then
			-- Check if city exists
			if not exists(select * from `cities` where `cityname`=$cityname) then
				-- Create a new city
				insert into `cities`(`cityname`,`countryid`)
				values($cityname,$countryid);
			end if;	
		else
			-- Check if city name exists and id is different from current id 
			if not exists(select * from `cities` where `cityname`=$cityname and `cityid`!=$cityid) then
				-- Update existing city details
				update `cities`
				set `cityname`=$cityname, `countryid`=$countryid
				where `cityid`=$cityid;
			end if;
		end if;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_savecountry` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_savecountry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecountry`($countryid int,$countryname varchar(50))
BEGIN
		if $countryid=0 then 
			if not exists(select * from `countries` where `countryname`=$countryname) then
				insert into `countries`(`countryname`)
				values($countryname);
			end if;
		else
			update `countries`
			set `countryname`=$countryname
			where `countryid`=$countryid;
		end if;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_saveuser` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_saveuser` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_saveuser`($userid int,$username varchar(100),$firstname varchar(100),$lastname varchar(100),$userpassword varchar(100),
	$salt varchar(50),$mobile varchar(50),$emailaddress varchar(100),$systemadmin bool,$addedby int)
BEGIN
		if $userid=0 then 
			insert into `users`(`username`,`firstname`,`lastname`,`password`,`salt`,`systemadmin`,
			`mobile`,`emailaddress`,`dateadded`,`addedby`)
			values($username,$firstname,$lastname,$userpassword,$salt,$systemadmin,
			$mobile,$emailaddress,now(),$addedby);
			select last_insert_id() into $userid;
		else
			update `users`
			set $username=$username,firstname=$firstname,lastname=$lasyname,systemadmin=$systemadmin,
			mobile=$mobile,emailaddress=$emailaddress
			where `userid`=$userid;
		end if;
		
		select $userid as userid;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_saveuserprivilege` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_saveuserprivilege` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_saveuserprivilege`($userid int,$objectid int, $valid int,$addedby int)
BEGIN
		if exists(select * from `userprivileges` where `objectid`=$objectid and `userid`=$userid and `active`=1) then
			if $valid=0 then 
				update `userprivileges` set `active`=0
				where `objectid`=$objectid AND `userid`=$userid;
			end if;
		else
			if $valid=1 then 
				insert `userprivileges`(`objectid`,`userid`,`active`,`dateadded`,`addedby`)
				values($objectid,$userid,1,now(),$addedby);
			end if;
		end if;
	END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
