/*
 Navicat Premium Data Transfer

 Source Server         : centos smartParking
 Source Server Type    : MySQL
 Source Server Version : 50560
 Source Host           : 192.168.1.111:3306
 Source Schema         : smartParking

 Target Server Type    : MySQL
 Target Server Version : 50560
 File Encoding         : 65001

 Date: 09/09/2018 20:16:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activities
-- ----------------------------
DROP TABLE IF EXISTS `activities`;
CREATE TABLE `activities`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parked` tinyint(1) NOT NULL,
  `places_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `time` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `activities_places_id_foreign`(`places_id`) USING BTREE,
  INDEX `activities_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `activities_places_id_foreign` FOREIGN KEY (`places_id`) REFERENCES `places` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `activities_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for bookmarks
-- ----------------------------
DROP TABLE IF EXISTS `bookmarks`;
CREATE TABLE `bookmarks`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `temporary` tinyint(1) NOT NULL,
  `description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `places_id` int(10) UNSIGNED NOT NULL,
  `time` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bookmarks_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `bookmarks_places_id_foreign`(`places_id`) USING BTREE,
  CONSTRAINT `bookmarks_places_id_foreign` FOREIGN KEY (`places_id`) REFERENCES `places` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `bookmarks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for genders
-- ----------------------------
DROP TABLE IF EXISTS `genders`;
CREATE TABLE `genders`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for oauth_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE `oauth_access_tokens`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_access_tokens_user_id_index`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for oauth_auth_codes
-- ----------------------------
DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE `oauth_auth_codes`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for oauth_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE `oauth_clients`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_clients_user_id_index`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for oauth_personal_access_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE `oauth_personal_access_clients`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_personal_access_clients_client_id_index`(`client_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for oauth_refresh_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE `oauth_refresh_tokens`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_refresh_tokens_access_token_id_index`(`access_token_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for parameters
-- ----------------------------
DROP TABLE IF EXISTS `parameters`;
CREATE TABLE `parameters`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for parking_types
-- ----------------------------
DROP TABLE IF EXISTS `parking_types`;
CREATE TABLE `parking_types`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for places
-- ----------------------------
DROP TABLE IF EXISTS `places`;
CREATE TABLE `places`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `loc` point NOT NULL,
  `lat` double NOT NULL,
  `long` double NOT NULL,
  `disabledcount` int(11) NOT NULL,
  `occupied` int(11) NOT NULL DEFAULT 0,
  `emptyspaces` int(11) NOT NULL DEFAULT 0,
  `empty` tinyint(1) NOT NULL,
  `avaliable` tinyint(1) NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `cost` double NOT NULL DEFAULT 0,
  `parkingtype_id` int(10) UNSIGNED NOT NULL,
  `reportedcount` int(11) NOT NULL,
  `validity` int(11) NOT NULL DEFAULT 5,
  `capacity` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `maximumduration` int(11) NOT NULL DEFAULT 0,
  `source_id` int(11) NOT NULL DEFAULT 1,
  `comments` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NO',
  `opendata` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `places_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `places_parkingtype_id_foreign`(`parkingtype_id`) USING BTREE,
  CONSTRAINT `places_parkingtype_id_foreign` FOREIGN KEY (`parkingtype_id`) REFERENCES `parking_types` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `places_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 489 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for places_costs
-- ----------------------------
DROP TABLE IF EXISTS `places_costs`;
CREATE TABLE `places_costs`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cost` double NOT NULL,
  `time` double NOT NULL DEFAULT 0,
  `places_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `places_costs_places_id_foreign`(`places_id`) USING BTREE,
  CONSTRAINT `places_costs_places_id_foreign` FOREIGN KEY (`places_id`) REFERENCES `places` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 153 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for request_parameters
-- ----------------------------
DROP TABLE IF EXISTS `request_parameters`;
CREATE TABLE `request_parameters`  (
  `user_requests_id` int(10) UNSIGNED NOT NULL,
  `parameters_id` int(10) UNSIGNED NOT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_requests_id`, `parameters_id`) USING BTREE,
  INDEX `request_parameters_parameters_id_foreign`(`parameters_id`) USING BTREE,
  CONSTRAINT `request_parameters_parameters_id_foreign` FOREIGN KEY (`parameters_id`) REFERENCES `parameters` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `request_parameters_user_requests_id_foreign` FOREIGN KEY (`user_requests_id`) REFERENCES `user_requests` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for request_results
-- ----------------------------
DROP TABLE IF EXISTS `request_results`;
CREATE TABLE `request_results`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `distanceDest` double NOT NULL,
  `distanceDestNorm` double NOT NULL,
  `distanceUser` double NOT NULL,
  `distanceUserNorm` double NOT NULL,
  `durationDest` double NOT NULL,
  `durationDestNorm` double NOT NULL,
  `durationUser` double NOT NULL,
  `durationUserNorm` double NOT NULL,
  `costNorm` double NOT NULL,
  `score` double NOT NULL,
  `places_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `request_results_places_id_foreign`(`places_id`) USING BTREE,
  INDEX `request_results_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `request_results_places_id_foreign` FOREIGN KEY (`places_id`) REFERENCES `places` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `request_results_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 155 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `isAdminRole` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sources
-- ----------------------------
DROP TABLE IF EXISTS `sources`;
CREATE TABLE `sources`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for targets
-- ----------------------------
DROP TABLE IF EXISTS `targets`;
CREATE TABLE `targets`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `loc` point NOT NULL,
  `lat` double NOT NULL,
  `long` double NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `time` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `targets_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `targets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user_requests
-- ----------------------------
DROP TABLE IF EXISTS `user_requests`;
CREATE TABLE `user_requests`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userloc` point NOT NULL,
  `userlat` double NOT NULL,
  `userlong` double NOT NULL,
  `destloc` point NOT NULL,
  `destlat` double NOT NULL,
  `destlong` double NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `time` datetime NOT NULL,
  `totaltime` double NOT NULL,
  `fuzzytime` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_requests_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `user_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user_results
-- ----------------------------
DROP TABLE IF EXISTS `user_results`;
CREATE TABLE `user_results`  (
  `user_requests_id` int(10) UNSIGNED NOT NULL,
  `request_results_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_requests_id`, `request_results_id`) USING BTREE,
  INDEX `user_results_request_results_id_foreign`(`request_results_id`) USING BTREE,
  CONSTRAINT `user_results_request_results_id_foreign` FOREIGN KEY (`request_results_id`) REFERENCES `request_results` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_results_user_requests_id_foreign` FOREIGN KEY (`user_requests_id`) REFERENCES `user_requests` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(8, 2) NOT NULL DEFAULT 0.00,
  `activated` tinyint(1) NOT NULL DEFAULT 1,
  `roles_id` int(10) UNSIGNED NOT NULL,
  `genders_id` int(10) UNSIGNED NOT NULL,
  `dateofbirth` datetime NOT NULL,
  `apikey` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_username_unique`(`username`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email`) USING BTREE,
  INDEX `users_roles_id_foreign`(`roles_id`) USING BTREE,
  INDEX `users_genders_id_foreign`(`genders_id`) USING BTREE,
  CONSTRAINT `users_genders_id_foreign` FOREIGN KEY (`genders_id`) REFERENCES `genders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `users_roles_id_foreign` FOREIGN KEY (`roles_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1011 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Function structure for checkIfParkingExists
-- ----------------------------
DROP FUNCTION IF EXISTS `checkIfParkingExists`;
delimiter ;;
CREATE DEFINER=`root`@`%` FUNCTION `checkIfParkingExists`(`lat` DOUBLE, `long` DOUBLE) RETURNS int(11)
BEGIN
  DECLARE returnVariable INT ;
  #Routine body goes here...
  declare parking POINT ;
  SET parking = POINT (`lat`, `long`) ;
  SET returnVariable = 0 ;
  SELECT 
    id into returnVariable 
  FROM
    smartParking.places 
  WHERE `earth_circle_distance`(parking, loc) < 0.001 -- I CAN USE IN MYSQL 55 AND ABOVE ST_Distance_Sphere
     #less  than  10 meters
  ORDER BY `earth_circle_distance`(parking, loc) ASC 
  LIMIT 0, 1 ;
  RETURN returnVariable ;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for earth_circle_distance
-- ----------------------------
DROP FUNCTION IF EXISTS `earth_circle_distance`;
delimiter ;;
CREATE DEFINER=`root`@`%` FUNCTION `earth_circle_distance`(point1 point, point2 point) RETURNS double
    DETERMINISTIC
begin
  declare lon1,lon2 double;
  declare lat1,lat2 double;
  declare td double;
  declare d_lat double;
  declare d_lon double;
  declare a,c,R double;

  set lon1 = X(GeomFromText(AsText(point1)));
  set lon2 = X(GeomFromText(AsText(point2)));
  set lat1 = Y(GeomFromText(AsText(point1)));
  set lat2 = Y(GeomFromText(AsText(point2)));

  set d_lat = radians(lat2 - lat1);
  set d_lon = radians(lon2 - lon1);

  set lat1 = radians(lat1);
  set lat2 = radians(lat2);

  set R = 6372.8; -- in kilometers

  set a = sin(d_lat / 2.0) * sin(d_lat / 2.0) + sin(d_lon / 2.0) * sin(d_lon / 2.0) * cos(lat1) * cos(lat2);
  set c = 2 * asin(sqrt(a));

  return R * c;
end
;;
delimiter ;

-- ----------------------------
-- Function structure for getCostforPlace
-- ----------------------------
DROP FUNCTION IF EXISTS `getCostforPlace`;
delimiter ;;
CREATE DEFINER=`root`@`%` FUNCTION `getCostforPlace`( `places_id` BIGINT ) RETURNS double
BEGIN#Routine body goes here...
DECLARE
	cost DOUBLE;
IF
	EXISTS (
	SELECT
		places.cost,
		places_costs.cost,
		places_costs.time 
	FROM
		places
		INNER JOIN places_costs ON places_costs.places_id = places.id  
	WHERE
		places_costs.time = 60 LIMIT 1
	) THEN
SELECT
	 places_costs.cost INTO cost
FROM
	places
	INNER JOIN places_costs ON places_costs.places_id = places.id 
WHERE
	places_costs.time = 60 LIMIT 1;
ELSE SELECT
	places.cost INTO cost
FROM
	places
	INNER JOIN places_costs ON places_costs.places_id = places.id LIMIT  1;
END IF;
RETURN cost;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for getCostforPlaceCalc
-- ----------------------------
DROP FUNCTION IF EXISTS `getCostforPlaceCalc`;
delimiter ;;
CREATE DEFINER=`root`@`%` FUNCTION `getCostforPlaceCalc`( `places_id` BIGINT ) RETURNS double
BEGIN#Routine body goes here...
DECLARE
	cost DOUBLE;
DECLARE
	intermtime DOUBLE;
	DECLARE
	intermcost DOUBLE;
IF
	EXISTS (
SELECT
	places.cost,
	places_costs.cost,
	places_costs.time 
FROM
	places
	INNER JOIN places_costs ON places_costs.places_id = places.id 
WHERE
	places_costs.time = 60 
	LIMIT 1 
	) THEN
SELECT
	places_costs.cost INTO cost 
FROM
	places
	INNER JOIN places_costs ON places_costs.places_id = places.id 
WHERE
	places_costs.time = 60 
	LIMIT 1;
ELSE
IF
	EXISTS (
SELECT
	places.cost 
FROM
	places
	INNER JOIN places_costs ON places_costs.places_id = places.id 
WHERE
	places.cost >= 0 
	LIMIT 1

) THEN
SELECT
		places.cost INTO cost 
	FROM
		places
		INNER JOIN places_costs ON places_costs.places_id = places.id 
	WHERE
		places.cost >= 0 
		LIMIT 1;
else

if exists(SELECT
		places_costs.cost  
	FROM
		places
		INNER JOIN places_costs ON places_costs.places_id = places.id 
	WHERE
		places_costs.cost >= 60 
	ORDER BY
		places_costs.time ASC 
		LIMIT 1)
  then
	SELECT
		places_costs.cost INTO intermcost 
	FROM
		places
		INNER JOIN places_costs ON places_costs.places_id = places.id 
	WHERE
		places_costs.cost >= 60 
	ORDER BY
		places_costs.time ASC 
		LIMIT 1;

	SELECT
		places_costs.time into intermtime
	FROM
		places
		INNER JOIN places_costs ON places_costs.places_id = places.id 
	WHERE
		places_costs.cost >= 60 
	ORDER BY
		places_costs.time ASC 
		LIMIT 1;		
	  
		set cost = (3600 * intermcost)/intermtime;
		
		else
		set cost=-1;
		end if;
		
	END IF;

END IF;
RETURN cost;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getParkingsAroundAPointBaseOnRange
-- ----------------------------
DROP PROCEDURE IF EXISTS `getParkingsAroundAPointBaseOnRange`;
delimiter ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getParkingsAroundAPointBaseOnRange`(IN `lat` double,IN `long` double,IN `rangeINkm` double)
BEGIN
declare parking POINT;
SET parking = POINT ( `lat`, `long` );
SELECT
parking_types.`name`,
places.`name`,
places.loc,
places.lat,
places.`long`,
places.disabledcount,
places.avaliable,
places.empty,
places.user_id,
getCostforPlaceCalc(places.id) as cost,
places.reportedcount,
places.validity,
places.capacity,
places.time,
places.maximumduration,
places.occupied,
places.emptyspaces,
places.comments,
places.`parkingtype_id`,
places.id,
`earth_circle_distance` ( parking, places.loc ) AS Distance #ST_DISTANCE ( parking, places.loc ) AS Distance
FROM
places
INNER JOIN parking_types ON places.parkingtype_id = parking_types.id
WHERE
	`earth_circle_distance`(parking, loc) < `rangeINkm` #less  than  range in  meters
	AND PLACES.avaliable=1
ORDER BY
	`earth_circle_distance`(parking, loc) ASC;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getParkingsAroundAPointBaseOnRangeOLD
-- ----------------------------
DROP PROCEDURE IF EXISTS `getParkingsAroundAPointBaseOnRangeOLD`;
delimiter ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getParkingsAroundAPointBaseOnRangeOLD`(IN `lat` double,IN `long` double,IN `rangeINkm` double)
BEGIN
declare parking POINT;
SET parking = POINT ( `lat`, `long` );
SELECT
parking_types.`name`,
places.`name`,
places.loc,
places.lat,
places.`long`,
places.disabledcount,
places.avaliable,
places.empty,
places.user_id,
places.cost,
places.reportedcount,
places.validity,
places.capacity,
places.time,
places.maximumduration,
places.occupied,
places.emptyspaces,
places.comments,
places.`parkingtype_id`,
places.id,
`earth_circle_distance` ( parking, places.loc ) AS Distance #ST_DISTANCE ( parking, places.loc ) AS Distance
FROM
places
INNER JOIN parking_types ON places.parkingtype_id = parking_types.id
WHERE
	`earth_circle_distance`(parking, loc) < `rangeINkm` #less  than  range in  meters
	AND PLACES.avaliable=1
ORDER BY
	`earth_circle_distance`(parking, loc) ASC;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
