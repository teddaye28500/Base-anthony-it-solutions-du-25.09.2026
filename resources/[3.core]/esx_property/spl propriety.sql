CREATE TABLE IF NOT EXISTS `properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `label` varchar(100) NOT NULL,
  `entering` longtext NOT NULL,
  `exit` longtext NOT NULL,
  `inside` longtext NOT NULL,
  `outside` longtext NOT NULL,
  `ipls` longtext DEFAULT NULL,
  `gateway` int(11) DEFAULT NULL,
  `is_single` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `property_rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NOT NULL,
  `room_name` varchar(50) NOT NULL,
  `coords` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `owned_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(60) NOT NULL,
  `property_id` int(11) NOT NULL,
  `rented` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `properties` (`name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`) VALUES
('appart1', 'Appartement Centre Ville', '{"x":-268.0,"y":-957.0,"z":31.2}', '{"x":266.0,"y":-1007.0,"z":29.0}', '{"x":266.0,"y":-1007.0,"z":29.0}', '{"x":-268.0,"y":-957.0,"z":31.2}', NULL, NULL, 1),
('villa1', 'Villa Vinewood', '{"x":-763.0,"y":430.0,"z":100.0}', '{"x":-781.0,"y":318.0,"z":85.0}', '{"x":-781.0,"y":318.0,"z":85.0}', '{"x":-763.0,"y":430.0,"z":100.0}', NULL, NULL, 1),
('maison1', 'Petite Maison', '{"x":-1100.0,"y":-1500.0,"z":4.0}', '{"x":-1110.0,"y":-1490.0,"z":4.0}', '{"x":-1110.0,"y":-1490.0,"z":4.0}', '{"x":-1100.0,"y":-1500.0,"z":4.0}', NULL, NULL, 1);
