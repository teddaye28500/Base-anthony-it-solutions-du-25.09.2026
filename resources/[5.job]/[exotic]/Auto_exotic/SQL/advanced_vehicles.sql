SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for advanced_vehicles
-- ----------------------------
DROP TABLE IF EXISTS `advanced_vehicles`;
CREATE TABLE `advanced_vehicles` (
  `vehicle` varchar(50) NOT NULL,
  `user_id` varchar(55) NOT NULL,
  `plate` varchar(12) NOT NULL DEFAULT '',
  `km` double NOT NULL DEFAULT 0,
  `vehicle_handling` longtext NULL,
  `nitroAmount` int(11) NOT NULL DEFAULT 0,
  `nitroRecharges` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`vehicle`, `user_id`, `plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of advanced_vehicles
-- ----------------------------

-- ----------------------------
-- Table structure for advanced_vehicles_inspection
-- ----------------------------
DROP TABLE IF EXISTS `advanced_vehicles_inspection`;
CREATE TABLE `advanced_vehicles_inspection` (
  `vehicle` varchar(50) NOT NULL,
  `user_id` varchar(55) NOT NULL,
  `plate` varchar(12) NOT NULL DEFAULT '',
  `item` varchar(50) NOT NULL,
  `km` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `value` double NOT NULL DEFAULT 0,
  `timer` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`vehicle`, `user_id`, `plate`, `item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of advanced_vehicles_inspection
-- ----------------------------

-- ----------------------------
-- Table structure for advanced_vehicles_services
-- ----------------------------
DROP TABLE IF EXISTS `advanced_vehicles_services`;
CREATE TABLE `advanced_vehicles_services` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `vehicle` varchar(50) NOT NULL,
  `user_id` varchar(55) NOT NULL,
  `plate` varchar(12) NOT NULL DEFAULT '',
  `item` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(50) NOT NULL DEFAULT '',
  `km` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `img` varchar(255) NOT NULL DEFAULT '',
  `timer` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `vehicle` (`vehicle`),
  KEY `user_id` (`user_id`),
  KEY `plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of advanced_vehicles_services
-- ----------------------------

-- ----------------------------
-- Table structure for advanced_vehicles_upgrades
-- ----------------------------
DROP TABLE IF EXISTS `advanced_vehicles_upgrades`;
CREATE TABLE `advanced_vehicles_upgrades` (
  `vehicle` varchar(50) NOT NULL,
  `user_id` varchar(55) NOT NULL,
  `plate` varchar(12) NOT NULL DEFAULT '',
  `class` varchar(50) NOT NULL,
  `item` varchar(50) NOT NULL,
  PRIMARY KEY (`vehicle`, `user_id`, `plate`, `class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of advanced_vehicles_upgrades
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
