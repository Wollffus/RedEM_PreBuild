/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `redemrp` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `redemrp`;

-- Dumping structure for table redemrp.characters
DROP TABLE IF EXISTS `characters`;
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `characterid` int(11) DEFAULT 0,
  `citizenid` varchar(10) COLLATE utf8mb4_bin NOT NULL,
  `money` int(11) DEFAULT 200,
  `bank` int(11) NOT NULL,
  `job` varchar(50) COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `firstname` varchar(50) COLLATE utf8mb4_bin DEFAULT 'first',
  `lastname` varchar(50) COLLATE utf8mb4_bin DEFAULT 'last',
  `jobgrade` int(11) DEFAULT 0,
  `gang` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'none',
  `ganggrade` int(11) NOT NULL DEFAULT 0,
  `coords` varchar(200) COLLATE utf8mb4_bin DEFAULT '{}',
  `pobox` int(11) NOT NULL,
  `jailed` int(11) NOT NULL DEFAULT 0,
  `metadata` varchar(512) COLLATE utf8mb4_bin NOT NULL DEFAULT '''[]''',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table redemrp.characters: ~1 rows (approximately)
DELETE FROM `characters`;
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
INSERT INTO `characters` (`id`, `identifier`, `characterid`, `citizenid`, `money`, `bank`, `job`, `firstname`, `lastname`, `jobgrade`, `gang`, `ganggrade`, `coords`, `pobox`, `jailed`, `metadata`) VALUES
	(1, 'steam:11000013b7ba013', 1, 'RNH15551', 300, 0, 'unemployed', 'Robert', 'Banks', 0, 'none', 0, '{"y":-357.1529846191406,"x":-1801.0762939453126,"z":163.9723663330078}', 633577, 0, '{"thirst":100,"hunger":100}');
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;

-- Dumping structure for table redemrp.clothes
DROP TABLE IF EXISTS `clothes`;
CREATE TABLE IF NOT EXISTS `clothes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `clothes` varchar(5000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table redemrp.clothes: ~0 rows (approximately)
DELETE FROM `clothes`;
/*!40000 ALTER TABLE `clothes` DISABLE KEYS */;
/*!40000 ALTER TABLE `clothes` ENABLE KEYS */;

-- Dumping structure for table redemrp.horse_components
DROP TABLE IF EXISTS `horse_components`;
CREATE TABLE IF NOT EXISTS `horse_components` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `plate` int(11) NOT NULL,
  `components` varchar(8000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table redemrp.horse_components: ~0 rows (approximately)
DELETE FROM `horse_components`;
/*!40000 ALTER TABLE `horse_components` DISABLE KEYS */;
/*!40000 ALTER TABLE `horse_components` ENABLE KEYS */;

-- Dumping structure for table redemrp.outfits
DROP TABLE IF EXISTS `outfits`;
CREATE TABLE IF NOT EXISTS `outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `clothes` varchar(5000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table redemrp.outfits: ~0 rows (approximately)
DELETE FROM `outfits`;
/*!40000 ALTER TABLE `outfits` DISABLE KEYS */;
/*!40000 ALTER TABLE `outfits` ENABLE KEYS */;

-- Dumping structure for table redemrp.skins
DROP TABLE IF EXISTS `skins`;
CREATE TABLE IF NOT EXISTS `skins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `skin` varchar(5000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table redemrp.skins: ~1 rows (approximately)
DELETE FROM `skins`;
/*!40000 ALTER TABLE `skins` DISABLE KEYS */;
INSERT INTO `skins` (`id`, `identifier`, `charid`, `skin`) VALUES
	(1, 'steam:11000013b7ba013', 1, '{"moles_t":"1","mouth_x_pos":"0","nose_width":"0","bodysize":"3","eyebrows_t":"1","chin_depth":"0","nose_angle":"0","eyes_distance":"0","scars_op":"1","eyes_height":"0","spots_t":"1","moles_op":"1","blush_id":"1","lipsticks_id":"1","eyebrow_height":"0","mouth_depth":"0","eyebrows_id":"1","ears_width":"0","beard":"117","upper_lip_depth":"0","eyes_angle":"0","shadows_t":"1","cheekbones_height":"0","cheekbones_width":"0","eyebrow_width":"0","eyebrows_op":"1","shadows_id":"1","skincolor":"1","nose_curvature":"0","eyecolor":"1","spots_op":"1","earlobe_size":"0","eyebrows_c1":"1","ageing_t":"1","eyeliners_c2":"1","blush_c1":"1","ears_height":"0","eyeliners_op":"1","freckles_op":"1","lipsticks_c1":"1","nose_size":"0","upper_lip_height":"0","shadows_c2":"1","blush_op":"1","hair":"9","lower_lip_height":"0","ageing_op":"1","blush_c3":"1","freckles_t":"1","eyeliners_c1":"1","mouth_y_pos":"0","sex":"1","ears_angle":"0","eyelid_height":"0","jaw_width":"0","lipsticks_c3":"1","eyebrows_c2":"1","lipsticks_t":"1","face_width":"0","lower_lip_depth":"0","lower_lip_width":"0","cheekbones_depth":"0","eyeliners_id":"1","eyebrows_c3":"1","upper_lip_width":"0","shadows_c1":"1","eyes_depth":"0","jaw_depth":"0","shadows_op":"1","nostrils_distance":"0","shadows_c3":"1","eyebrow_depth":"0","blush_t":"1","jaw_height":"0","nose_height":"0","value":true,"eyeliners_c3":"1","blush_c2":"1","mouth_width":"0","chin_height":"0","eyeliners_t":"1","height":"100","chin_width":"0","lipsticks_c2":"1","lipsticks_op":"1","eyelid_width":"0","face":"1","scars_t":"1"}');
/*!40000 ALTER TABLE `skins` ENABLE KEYS */;

-- Dumping structure for table redemrp.stashes
DROP TABLE IF EXISTS `stashes`;
CREATE TABLE IF NOT EXISTS `stashes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stashid` text NOT NULL,
  `items` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table redemrp.stashes: ~0 rows (approximately)
DELETE FROM `stashes`;
/*!40000 ALTER TABLE `stashes` DISABLE KEYS */;
/*!40000 ALTER TABLE `stashes` ENABLE KEYS */;

-- Dumping structure for table redemrp.status
DROP TABLE IF EXISTS `status`;
CREATE TABLE IF NOT EXISTS `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL DEFAULT '0',
  `charid` int(11) NOT NULL DEFAULT 0,
  `status` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table redemrp.status: ~1 rows (approximately)
DELETE FROM `status`;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` (`id`, `identifier`, `charid`, `status`) VALUES
	(1, 'steam:11000013b7ba013', 1, '{"drugs":0,"thirst":100,"drunk":0,"hunger":100}');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;

-- Dumping structure for table redemrp.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  `permission_level` int(11) DEFAULT NULL,
  `group` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table redemrp.users: ~1 rows (approximately)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`identifier`, `license`, `money`, `bank`, `permission_level`, `group`) VALUES
	('steam:11000013b7ba013', 'license:rockstardevlicense', 0, 0, 0, 'user');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table redemrp.user_inventory
DROP TABLE IF EXISTS `user_inventory`;
CREATE TABLE IF NOT EXISTS `user_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `charid` int(11) NOT NULL,
  `items` varchar(16000) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table redemrp.user_inventory: ~1 rows (approximately)
DELETE FROM `user_inventory`;
/*!40000 ALTER TABLE `user_inventory` DISABLE KEYS */;
INSERT INTO `user_inventory` (`id`, `identifier`, `charid`, `items`) VALUES
	(1, 'steam:11000013b7ba013', 1, '[{"name":"WEAPON_MELEE_KNIFE","meta":[],"amount":1},{"name":"water","meta":[],"amount":10},{"name":"WEAPON_BOW","meta":[],"amount":1},{"name":"AMMO_ARROW","meta":[],"amount":1},{"name":"bread","meta":[],"amount":10}]');
/*!40000 ALTER TABLE `user_inventory` ENABLE KEYS */;

-- Dumping structure for table redemrp.user_locker
DROP TABLE IF EXISTS `user_locker`;
CREATE TABLE IF NOT EXISTS `user_locker` (
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `charid` int(11) NOT NULL,
  `items` varchar(16000) COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table redemrp.user_locker: ~10 rows (approximately)
DELETE FROM `user_locker`;
/*!40000 ALTER TABLE `user_locker` DISABLE KEYS */;
INSERT INTO `user_locker` (`identifier`, `charid`, `items`) VALUES
	('V_Doctor', 0, '[]'),
	('V_Sheriff', 0, '[]'),
	('V_Saloon', 0, '[]'),
	('lawman_saintdenis', 0, '[]'),
	('Banks_storage_Val', 0, '[]'),
	('stirling_bank_storage', 0, '[]'),
	('lawman_val', 0, '[]'),
	('lawman_blackwater', 0, '[]'),
	('leelay_house_1', 0, '[]'),
	('steam:11000013b7ba013', 1, '[]');
/*!40000 ALTER TABLE `user_locker` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
