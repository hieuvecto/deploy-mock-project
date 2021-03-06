-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;
USE mockProject;

DROP TABLE `Booking`;


DROP TABLE `SubPitch`;


DROP TABLE `CampaignSubPitch`;


DROP TABLE `Campaign`;


DROP TABLE `Pitch`;


DROP TABLE `User`;


DROP TABLE `Owner`;


DROP TABLE `Admin`;


DROP TABLE `AuthUser`;


DROP TABLE `AuthOwner`;

-- ************************************** `User`

CREATE TABLE `User`
(
 `user_id`     INT NOT NULL AUTO_INCREMENT,
 `email`       VARCHAR(40) NOT NULL ,
 `password`    VARCHAR(255) NOT NULL ,
 `phone`       VARCHAR(13) NOT NULL ,
 `avatar_url`  TEXT ,
 `user_status` INT NOT NULL DEFAULT '0',
 `created_at`  INT(11) NOT NULL ,
 `updated_at`  INT(11) NOT NULL ,
 `auth_key`	   VARCHAR(255),

PRIMARY KEY (`user_id`),
UNIQUE KEY (`email`),
UNIQUE KEY (`phone`)
) AUTO_INCREMENT=1;





-- ************************************** `Owner`

CREATE TABLE `Owner`
(
 `owner_id`   INT NOT NULL AUTO_INCREMENT ,
 `email`      VARCHAR(40) NOT NULL ,
 `password`   VARCHAR(255) NOT NULL ,
 `phone`      VARCHAR(13) NOT NULL ,
 `avatar_url` TEXT ,
 `created_at` INT(11) NOT NULL ,
 `updated_at` INT(11) NOT NULL ,
 `auth_key`	  VARCHAR(255),

PRIMARY KEY (`owner_id`),
UNIQUE KEY (`email`),
UNIQUE KEY (`phone`)
) AUTO_INCREMENT=1;





-- ************************************** `Admin`

CREATE TABLE `Admin`
(
 `admin_id` INT NOT NULL AUTO_INCREMENT ,
 `username` VARCHAR(40) NOT NULL ,
 `password` VARCHAR(255) NOT NULL ,
 `auth_key`	   VARCHAR(255),

PRIMARY KEY (`admin_id`),
UNIQUE KEY (`username`)
) AUTO_INCREMENT=1;



-- ************************************** `AuthUser`

CREATE TABLE `AuthUser`
(
 `auth_id`          INT NOT NULL AUTO_INCREMENT,
 `user_id`          INT NOT NULL ,
 `source`      		VARCHAR(255) NOT NULL ,
 `source_id`      	VARCHAR(255) NOT NULL ,
 `created_at`       INT(11) NOT NULL ,
 `updated_at`       INT(11) NOT NULL ,

PRIMARY KEY (`auth_id`),
KEY `fkIdx_135` (`user_id`),
CONSTRAINT `FK_AuthUser_User` FOREIGN KEY `fkIdx_135` (`user_id`) REFERENCES `User` (`user_id`)
) AUTO_INCREMENT=1;





-- ************************************** `AuthOwner`

CREATE TABLE `AuthOwner`
(
 `auth_id`          INT NOT NULL AUTO_INCREMENT,
 `owner_id`         INT NOT NULL ,
 `source`      		VARCHAR(255) NOT NULL ,
 `source_id`      	VARCHAR(255) NOT NULL ,
 `created_at`       INT(11) NOT NULL ,
 `updated_at`       INT(11) NOT NULL ,

PRIMARY KEY (`auth_id`),
KEY `fkIdx_140` (`owner_id`),
CONSTRAINT `FK_AuthOwner_Owner` FOREIGN KEY `fkIdx_140` (`owner_id`) REFERENCES `Owner` (`owner_id`)
) AUTO_INCREMENT=1;



-- ************************************** `Pitch`

CREATE TABLE `Pitch`
(
 `pitch_id`         INT NOT NULL AUTO_INCREMENT,
 `name`             NVARCHAR(45) NOT NULL ,
 `description`      TEXT ,
 `owner_id`         INT NOT NULL ,
 `city`             NVARCHAR(20) NOT NULL ,
 `district`         NVARCHAR(20) NOT NULL ,
 `address`           NVARCHAR(40) NOT NULL ,
 `phone_number`     VARCHAR(13) NOT NULL ,
 `avatar_url` 		TEXT ,
 `created_at`       INT(11) NOT NULL ,
 `updated_at`       INT(11) NOT NULL ,

PRIMARY KEY (`pitch_id`),
UNIQUE KEY (`name`),
KEY `fkIdx_129` (`owner_id`),
CONSTRAINT `FK_Pitch_Owner` FOREIGN KEY `fkIdx_129` (`owner_id`) REFERENCES `Owner` (`owner_id`)
) AUTO_INCREMENT=1;





-- ************************************** `SubPitch`

CREATE TABLE `SubPitch`
(
 `sub_pitch_id`   INT NOT NULL AUTO_INCREMENT,
 `name`           NVARCHAR(45) NOT NULL ,
 `description`    TEXT ,
 `status`         BINARY NOT NULL DEFAULT 1,
 `pitch_id`       INT NOT NULL ,
 `start_time`     TIME NOT NULL ,
 `end_time`       TIME NOT NULL ,
 `price_per_hour` INT NOT NULL ,
 `currency`       CHAR(3) NOT NULL DEFAULT 'VND',
 `avatar_url`	  TEXT ,
 `size`		  	  TINYINT NOT NULL DEFAULT 5,
 `created_at`     INT(11) NOT NULL ,
 `updated_at`     INT(11) NOT NULL ,

PRIMARY KEY (`sub_pitch_id`),
KEY `fkIdx_146` (`pitch_id`),
CONSTRAINT `FK_SubPitch_Pitch` FOREIGN KEY `fkIdx_146` (`pitch_id`) REFERENCES `Pitch` (`pitch_id`)
) AUTO_INCREMENT=1;


-- ************************************** `Campaign`

CREATE TABLE `Campaign`
(
 `campaign_id`      INT NOT NULL AUTO_INCREMENT,
 `name`             NVARCHAR(45) NOT NULL ,
 `description`      TEXT ,
 `owner_id`         INT NOT NULL ,
 `avatar_url` 		TEXT ,
 `start_time`		DATETIME NOT NULL,
 `end_time`			DATETIME NOT NULL,
 `type`				TINYINT NOT NULL DEFAULT 0,
 `value`			DOUBLE	NOT NULL,
 `created_at`       INT(11) NOT NULL ,
 `updated_at`       INT(11) NOT NULL ,

PRIMARY KEY (`campaign_id`),
KEY `fkIdx_160` (`owner_id`),
CONSTRAINT `FK_Campaign_Owner` FOREIGN KEY `fkIdx_160` (`owner_id`) REFERENCES `Owner` (`owner_id`)
) AUTO_INCREMENT=1;


-- ************************************** `CampaignSubPitch`

CREATE TABLE `CampaignSubPitch`
(
 `campaign_sub_pitch_id`      INT NOT NULL AUTO_INCREMENT,
 `campaign_id`		INT NOT NULL,
 `sub_pitch_id`		INT NOT NULL,
 `created_at`       INT(11) NOT NULL ,
 `updated_at`       INT(11) NOT NULL ,

PRIMARY KEY (`campaign_sub_pitch_id`),
KEY `fkIdx_170` (`campaign_id`),
KEY `fkIdx_171` (`sub_pitch_id`),
CONSTRAINT `FK_CampaignSubPitch_Campaign` FOREIGN KEY `fkIdx_170` (`campaign_id`) REFERENCES `Campaign` (`campaign_id`),
CONSTRAINT `FK_CampaignSubPitch_SubPitch` FOREIGN KEY `fkIdx_171` (`sub_pitch_id`) REFERENCES `SubPitch` (`sub_pitch_id`)
) AUTO_INCREMENT=1;


-- ************************************** `Booking`

CREATE TABLE `Booking`
(
 `booking_id`   INT NOT NULL AUTO_INCREMENT,
 `user_id`      INT NOT NULL ,
 `sub_pitch_id` INT NOT NULL ,
 `book_day`     DATE NOT NULL ,
 `start_time`   TIME NOT NULL ,
 `end_time`     TIME NOT NULL ,
 `message`      TEXT ,
 `is_verified`  BINARY NOT NULL DEFAULT 0,
 `is_paid`		BINARY NOT NULL DEFAULT 0,
 `total_price`	INT NOT NULL,
 `additional_info` TEXT ,
 `created_at`   INT(11) NOT NULL ,
 `updated_at`   INT(11) NOT NULL ,

PRIMARY KEY (`booking_id`),
KEY `fkIdx_154` (`user_id`),
CONSTRAINT `FK_Booking_User` FOREIGN KEY `fkIdx_154` (`user_id`) REFERENCES `User` (`user_id`),
KEY `fkIdx_167` (`sub_pitch_id`),
CONSTRAINT `FK_Booking_SubPitch` FOREIGN KEY `fkIdx_167` (`sub_pitch_id`) REFERENCES `SubPitch` (`sub_pitch_id`)
) AUTO_INCREMENT=1;




