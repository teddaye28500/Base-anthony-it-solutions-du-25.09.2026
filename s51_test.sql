-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : dim. 27 sep. 2026 à 18:55
-- Version du serveur : 10.11.11-MariaDB-0+deb12u1
-- Version de PHP : 8.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `s51_test`
--

-- --------------------------------------------------------

--
-- Structure de la table `account_info`
--

CREATE TABLE `account_info` (
  `license` varchar(255) NOT NULL,
  `steam` varchar(255) DEFAULT NULL,
  `xbl` varchar(255) DEFAULT NULL,
  `discord` varchar(255) DEFAULT NULL,
  `live` varchar(255) DEFAULT NULL,
  `fivem` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `guid` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `addon_account`
--

CREATE TABLE `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Déchargement des données de la table `addon_account`
--

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('caution', 'caution', 0),
('society_ambulance', 'Ambulance', 1),
('society_burgershot', 'Burgershot', 1),
('society_cardealer', 'CarDealer', 0),
('society_cbd', 'CBD', 1),
('society_exotic', 'Exotic Auto', 1),
('society_gouv', 'gouv', 1),
('society_police', 'Police', 1),
('society_realestateagent', 'Agent immobilier', 1),
('society_sheriff', 'Sheriff', 1),
('society_tabac', 'Tabac', 1),
('society_taxi', 'Taxi', 1),
('society_unicorn', 'unicorn', 1),
('society_vigneron', 'vigneron', 1),
('society_weazel', 'weazel', 1),
('society_yellowjack', 'yellowjack', 1);

-- --------------------------------------------------------

--
-- Structure de la table `addon_account_data`
--

CREATE TABLE `addon_account_data` (
  `id` int(11) NOT NULL,
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(46) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Déchargement des données de la table `addon_account_data`
--

INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
(17, 'society_cardealer', 0, NULL),
(18, 'society_cardealer', 0, NULL),
(19, 'society_cardealer', 0, NULL),
(20, 'society_cardealer', 0, NULL),
(39, 'society_exotic', 0, NULL),
(44, 'society_realestateagent', 0, NULL),
(45, 'caution', 0, NULL),
(47, 'society_police', 0, NULL),
(48, 'society_ambulance', 0, NULL),
(49, 'society_sheriff', 0, NULL),
(50, 'society_burgershot', 0, NULL),
(51, 'society_gouv', 0, NULL),
(52, 'society_taxi', 0, NULL),
(53, 'society_unicorn', 0, NULL),
(54, 'society_vigneron', 0, NULL),
(55, 'society_weazel', 0, NULL),
(56, 'society_yellowjack', 0, NULL),
(57, 'society_cardealer', 0, NULL),
(58, 'society_tabac', 0, NULL),
(59, 'society_cbd', 0, NULL),
(60, 'society_cardealer', 0, NULL),
(61, 'caution', 0, NULL),
(62, 'caution', 0, NULL),
(63, 'society_cardealer', 0, NULL),
(64, 'caution', 0, NULL),
(65, 'society_cardealer', 0, 'char1:5d95dd8dfd66b9ce067e4dc69eda1560672ab316');

-- --------------------------------------------------------

--
-- Structure de la table `addon_inventory`
--

CREATE TABLE `addon_inventory` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Déchargement des données de la table `addon_inventory`
--

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_ambulance', 'Ambulance', 1),
('society_burgershot', 'Burgershot', 1),
('society_cardealer', 'CarDealer', 1),
('society_cbd', 'CBD', 1),
('society_exotic', 'Auto Exotic', 1),
('society_gouv', 'gouv', 1),
('society_police', 'Police', 1),
('society_sheriff', 'Sheriff', 1),
('society_tabac', 'Tabac', 1),
('society_taxi', 'Taxi', 1),
('society_unicorn', 'unicorn', 1),
('society_vigneron', 'vigneron', 1),
('society_weazel', 'weazel', 1),
('society_yellowjack', 'yellowjack', 1);

-- --------------------------------------------------------

--
-- Structure de la table `addon_inventory_items`
--

CREATE TABLE `addon_inventory_items` (
  `id` int(11) NOT NULL,
  `inventory_name` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(46) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `advanced_vehicles`
--

CREATE TABLE `advanced_vehicles` (
  `vehicle` varchar(50) NOT NULL,
  `user_id` varchar(55) NOT NULL,
  `plate` varchar(12) NOT NULL DEFAULT '',
  `km` double NOT NULL DEFAULT 0,
  `vehicle_handling` longtext NOT NULL,
  `nitroAmount` int(11) NOT NULL DEFAULT 0,
  `nitroRecharges` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `advanced_vehicles_inspection`
--

CREATE TABLE `advanced_vehicles_inspection` (
  `vehicle` varchar(50) NOT NULL,
  `user_id` varchar(55) NOT NULL,
  `plate` varchar(12) NOT NULL DEFAULT '',
  `item` varchar(50) NOT NULL,
  `km` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `value` double NOT NULL DEFAULT 0,
  `timer` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `advanced_vehicles_services`
--

CREATE TABLE `advanced_vehicles_services` (
  `id` int(10) UNSIGNED NOT NULL,
  `vehicle` varchar(50) NOT NULL,
  `user_id` varchar(55) NOT NULL,
  `plate` varchar(12) NOT NULL DEFAULT '',
  `item` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(50) NOT NULL DEFAULT '',
  `km` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `img` varchar(255) NOT NULL DEFAULT '',
  `timer` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `advanced_vehicles_upgrades`
--

CREATE TABLE `advanced_vehicles_upgrades` (
  `vehicle` varchar(50) NOT NULL,
  `user_id` varchar(55) NOT NULL,
  `plate` varchar(12) NOT NULL DEFAULT '',
  `class` varchar(50) NOT NULL,
  `item` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `banking`
--

CREATE TABLE `banking` (
  `identifier` varchar(46) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `amount` int(64) DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL,
  `ID` int(11) NOT NULL,
  `balance` int(11) DEFAULT 0,
  `label` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `banlist`
--

CREATE TABLE `banlist` (
  `id` int(11) NOT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `playerName` varchar(64) NOT NULL,
  `reason` text NOT NULL,
  `banTime` bigint(20) NOT NULL,
  `expireTime` bigint(20) NOT NULL,
  `adminName` varchar(64) NOT NULL,
  `xbl` varchar(64) DEFAULT NULL,
  `discord` varchar(64) DEFAULT NULL,
  `live` varchar(64) DEFAULT NULL,
  `fivem` varchar(64) DEFAULT NULL,
  `char1` varchar(64) DEFAULT NULL,
  `ip` varchar(64) DEFAULT NULL,
  `guid` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `billing`
--

CREATE TABLE `billing` (
  `id` int(11) NOT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `sender` varchar(60) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target` varchar(40) NOT NULL,
  `label` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `datastore`
--

CREATE TABLE `datastore` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Déchargement des données de la table `datastore`
--

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('property', 'Property', 0),
('society_ambulance', 'Ambulance', 1),
('society_burgershot', 'Burgershot', 1),
('society_cardealer', 'CarDealer', 1),
('society_cbd', 'CBD', 1),
('society_exotic', 'Auto Exotic', 1),
('society_gouv', 'gouv', 1),
('society_police', 'Police', 1),
('society_sheriff', 'Sheriff', 1),
('society_tabac', 'Tabac', 1),
('society_taxi', 'Taxi', 1),
('society_unicorn', 'unicorn', 1),
('society_vigneron', 'vigneron', 1),
('society_weazel', 'weazel', 1),
('society_yellowjack', 'yellowjack', 1),
('user_ears', 'Ears', 0),
('user_glasses', 'Glasses', 0),
('user_helmet', 'Helmet', 0),
('user_mask', 'Mask', 0);

-- --------------------------------------------------------

--
-- Structure de la table `datastore_data`
--

CREATE TABLE `datastore_data` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `owner` varchar(46) DEFAULT NULL,
  `data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Déchargement des données de la table `datastore_data`
--

INSERT INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
(1, 'society_cardealer', NULL, '\'{}\''),
(52, 'property', NULL, '{}'),
(53, 'property', NULL, '{}'),
(54, 'user_ears', NULL, '{}'),
(55, 'property', NULL, '{}'),
(56, 'user_glasses', NULL, '{}'),
(57, 'user_helmet', NULL, '{}'),
(58, 'user_mask', NULL, '{}'),
(59, 'property', NULL, '{}'),
(60, 'property', NULL, '{}'),
(61, 'property', NULL, '{}'),
(62, 'property', NULL, '{}'),
(63, 'user_helmet', NULL, '{}'),
(64, 'user_mask', NULL, '{}'),
(65, 'property', NULL, ''),
(66, 'user_ears', NULL, '{}'),
(67, 'user_glasses', NULL, '{}'),
(68, 'property', NULL, '{}'),
(69, 'property', NULL, '{}'),
(70, 'property', NULL, '{}'),
(71, 'property', NULL, '{}'),
(72, 'property', NULL, '{}'),
(73, 'property', NULL, '{}'),
(74, 'property', NULL, '{}'),
(75, 'property', NULL, '{}'),
(76, 'property', NULL, '{}'),
(77, 'property', NULL, '{}'),
(78, 'property', NULL, '{}'),
(79, 'property', NULL, '{}'),
(80, 'property', NULL, '{}'),
(81, 'property', NULL, '{}'),
(82, 'property', NULL, '{}'),
(83, 'property', NULL, '{}'),
(84, 'property', NULL, '{}'),
(85, 'property', NULL, '{}'),
(86, 'property', NULL, '{}'),
(87, 'property', NULL, '{}'),
(88, 'property', NULL, '{}'),
(89, 'property', NULL, '{}'),
(90, 'property', NULL, '{}'),
(91, 'property', NULL, '{}'),
(92, 'property', NULL, '{}'),
(93, 'property', NULL, '{}'),
(94, 'property', NULL, '{}'),
(95, 'property', NULL, '{}'),
(96, 'property', NULL, '{}'),
(97, 'property', NULL, '{}'),
(98, 'property', NULL, '{}'),
(99, 'property', NULL, '{}'),
(100, 'property', NULL, '{}'),
(101, 'property', NULL, '{}'),
(102, 'property', NULL, '{}'),
(103, 'property', NULL, '{}'),
(104, 'property', NULL, '{}'),
(105, 'property', NULL, '{}'),
(106, 'property', NULL, '{}'),
(107, 'property', NULL, '{}'),
(108, 'property', NULL, '{}'),
(109, 'property', NULL, '{}'),
(110, 'property', NULL, '{}'),
(111, 'property', NULL, '{}'),
(112, 'property', NULL, '{}'),
(113, 'property', NULL, '{}'),
(114, 'property', NULL, '{}'),
(115, 'property', NULL, '{}'),
(116, 'property', NULL, '{}'),
(117, 'property', NULL, '{}'),
(118, 'property', NULL, '{}'),
(119, 'property', NULL, '{}'),
(120, 'property', NULL, '{}'),
(121, 'property', NULL, '{}'),
(122, 'property', NULL, '{}'),
(123, 'property', NULL, '{}'),
(124, 'property', NULL, '{}'),
(125, 'property', NULL, '{}'),
(126, 'property', NULL, '{}'),
(127, 'property', NULL, '{}'),
(128, 'property', NULL, '{}'),
(129, 'property', NULL, '{}'),
(130, 'property', NULL, '{}'),
(131, 'property', NULL, '{}'),
(132, 'property', NULL, '{}'),
(133, 'property', NULL, '{}'),
(134, 'property', NULL, '{}'),
(135, 'property', NULL, '{}'),
(136, 'property', NULL, '{}'),
(137, 'property', NULL, '{}'),
(138, 'property', NULL, '{}'),
(139, 'property', NULL, '{}'),
(140, 'property', NULL, '{}'),
(141, 'property', NULL, '{}'),
(142, 'property', NULL, '{}'),
(143, 'property', NULL, '{}'),
(144, 'property', NULL, '{}'),
(145, 'property', NULL, '{}'),
(146, 'property', NULL, '{}'),
(147, 'property', NULL, '{}'),
(148, 'property', NULL, '{}'),
(149, 'user_ears', NULL, '{}'),
(150, 'user_glasses', NULL, '{}'),
(151, 'user_mask', NULL, '{}'),
(152, 'user_helmet', NULL, '{}'),
(153, 'property', NULL, '{}'),
(154, 'property', NULL, '{}'),
(155, 'property', NULL, '{}'),
(156, 'property', NULL, '{}'),
(157, 'property', NULL, '{}'),
(158, 'property', NULL, '{}'),
(159, 'property', NULL, '{}'),
(160, 'property', NULL, '{}'),
(161, 'property', NULL, '{}'),
(162, 'property', NULL, '{}'),
(163, 'property', NULL, '{}'),
(164, 'property', NULL, '{}'),
(165, 'property', NULL, '{}'),
(166, 'property', NULL, '{}'),
(167, 'property', NULL, '{}'),
(168, 'property', NULL, '{}'),
(169, 'user_glasses', NULL, '{}'),
(170, 'property', NULL, '{}'),
(171, 'user_mask', NULL, '{}'),
(172, 'user_helmet', NULL, '{}'),
(173, 'user_ears', NULL, '{}'),
(174, 'property', NULL, '{}'),
(175, 'property', NULL, '{}'),
(176, 'user_ears', NULL, '{}'),
(177, 'user_glasses', NULL, '{}'),
(178, 'user_helmet', NULL, '{}'),
(179, 'user_mask', NULL, '{}'),
(180, 'property', NULL, '{}'),
(181, 'property', NULL, '{}'),
(182, 'property', NULL, '{}'),
(183, 'property', NULL, '{}'),
(184, 'property', NULL, '{}'),
(185, 'property', NULL, '{}'),
(186, 'user_ears', NULL, '{}'),
(187, 'user_glasses', NULL, '{}'),
(188, 'user_helmet', NULL, '{}'),
(189, 'user_mask', NULL, '{}'),
(190, 'property', NULL, '{}'),
(191, 'property', NULL, '{}'),
(192, 'property', NULL, '{}'),
(193, 'property', NULL, '{}'),
(194, 'property', NULL, '{}'),
(195, 'property', NULL, '{}'),
(196, 'property', NULL, '{}'),
(197, 'property', NULL, '{}'),
(198, 'property', NULL, '{}'),
(199, 'property', NULL, '{}'),
(200, 'property', NULL, '{}'),
(201, 'property', NULL, '{}'),
(202, 'property', NULL, '{}'),
(203, 'property', NULL, '{}'),
(204, 'property', NULL, '{}'),
(205, 'property', NULL, '{}'),
(206, 'property', NULL, '{}'),
(207, 'property', NULL, '{}'),
(208, 'property', NULL, '{}'),
(209, 'property', NULL, '{}'),
(210, 'property', NULL, '{}'),
(211, 'property', NULL, '{}'),
(212, 'property', NULL, '{}'),
(213, 'property', NULL, '{}'),
(214, 'property', NULL, '{}'),
(215, 'property', NULL, '{}'),
(216, 'property', NULL, '{}'),
(218, 'property', NULL, '{}'),
(219, 'property', NULL, '{}'),
(220, 'property', NULL, '{}'),
(221, 'property', NULL, '{}'),
(222, 'property', NULL, '{}'),
(223, 'property', NULL, '{}'),
(224, 'society_police', NULL, '\'{}\''),
(225, 'property', NULL, '{}'),
(226, 'property', NULL, '{}'),
(227, 'property', NULL, '{}'),
(228, 'property', NULL, '{}'),
(229, 'property', NULL, '{}'),
(230, 'property', NULL, '{}'),
(231, 'property', NULL, '{}'),
(232, 'property', NULL, '{}'),
(233, 'property', NULL, '{}'),
(234, 'property', NULL, '{}'),
(235, 'property', NULL, '{}'),
(236, 'property', NULL, '{}'),
(237, 'property', NULL, '{}'),
(238, 'property', NULL, '{}'),
(239, 'property', NULL, '{}'),
(240, 'society_ambulance', NULL, '\'{}\''),
(241, 'society_sheriff', NULL, '\'{}\''),
(242, 'property', NULL, '{}'),
(243, 'property', NULL, '{}'),
(244, 'property', NULL, '{}'),
(245, 'property', NULL, '{}'),
(246, 'property', NULL, '{}'),
(247, 'property', NULL, '{}'),
(248, 'property', NULL, '{}'),
(249, 'property', NULL, '{}'),
(250, 'property', NULL, '{}'),
(251, 'property', NULL, '{}'),
(252, 'property', NULL, '{}'),
(253, 'society_burgershot', NULL, '\'{}\''),
(254, 'society_gouv', NULL, '\'{}\''),
(255, 'society_taxi', NULL, '\'{}\''),
(256, 'society_unicorn', NULL, '\'{}\''),
(257, 'society_vigneron', NULL, '\'{}\''),
(258, 'property', NULL, '{}'),
(259, 'property', NULL, '{}'),
(260, 'property', NULL, '{}'),
(261, 'society_weazel', NULL, '\'{}\''),
(262, 'society_yellowjack', NULL, '\'{}\''),
(263, 'property', NULL, '{}'),
(264, 'property', NULL, '{}'),
(265, 'property', NULL, '{}'),
(266, 'property', NULL, '{}'),
(267, 'society_tabac', NULL, '\'{}\''),
(268, 'property', NULL, '{}'),
(269, 'property', NULL, '{}'),
(270, 'society_cbd', NULL, '\'{}\''),
(271, 'property', NULL, '{}'),
(272, 'property', NULL, '{}'),
(273, 'property', NULL, '{}'),
(274, 'property', NULL, '{}'),
(275, 'property', NULL, '{}'),
(276, 'property', NULL, '{}'),
(277, 'property', NULL, '{}'),
(278, 'property', NULL, '{}'),
(279, 'property', NULL, '{}'),
(280, 'property', NULL, '{}'),
(281, 'property', NULL, '{}'),
(282, 'property', NULL, '{}'),
(283, 'property', NULL, '{}'),
(284, 'property', NULL, '{}'),
(285, 'property', NULL, '{}'),
(286, 'property', NULL, '{}'),
(287, 'property', NULL, '{}'),
(288, 'property', NULL, '{}'),
(289, 'property', NULL, '{}'),
(290, 'property', NULL, '{}'),
(291, 'property', NULL, '{}'),
(292, 'property', NULL, '{}'),
(293, 'property', NULL, '{}'),
(294, 'property', NULL, '{}'),
(295, 'property', NULL, '{}'),
(296, 'property', NULL, '{}'),
(297, 'property', NULL, '{}'),
(298, 'property', NULL, '{}'),
(299, 'property', NULL, '{}'),
(300, 'property', NULL, '{}'),
(301, 'property', NULL, '{}'),
(302, 'property', NULL, '{}'),
(303, 'property', NULL, '{}'),
(304, 'property', NULL, '{}'),
(305, 'property', NULL, '{}'),
(306, 'property', NULL, '{}'),
(307, 'property', NULL, '{}'),
(308, 'property', NULL, '{}'),
(309, 'property', NULL, '{}'),
(310, 'property', NULL, '{}'),
(311, 'property', NULL, '{}'),
(312, 'property', NULL, '{}'),
(313, 'property', NULL, '{}'),
(314, 'property', NULL, '{}'),
(315, 'property', NULL, '{}'),
(316, 'society_exotic', NULL, '\'{}\''),
(317, 'property', NULL, '{}'),
(318, 'property', NULL, '{}'),
(319, 'user_ears', NULL, '{}'),
(320, 'user_glasses', NULL, '{}'),
(321, 'user_helmet', NULL, '{}'),
(322, 'user_mask', NULL, '{}'),
(323, 'property', NULL, '{}'),
(324, 'property', NULL, '{}'),
(325, 'property', NULL, '{}'),
(326, 'property', NULL, '{}'),
(327, 'property', NULL, '{}'),
(328, 'property', NULL, '{}'),
(329, 'property', NULL, '{}'),
(330, 'property', NULL, '{}'),
(331, 'property', NULL, '{}'),
(332, 'property', NULL, '{}'),
(333, 'property', NULL, '{}'),
(334, 'property', NULL, '{}'),
(335, 'property', NULL, '{}'),
(336, 'property', NULL, '{}'),
(337, 'property', NULL, '{}'),
(338, 'property', NULL, '{}'),
(339, 'property', NULL, '{}'),
(340, 'property', NULL, '{}'),
(341, 'property', NULL, '{}'),
(342, 'property', NULL, '{}'),
(343, 'property', NULL, '{}'),
(344, 'property', NULL, '{}'),
(345, 'property', NULL, '{}'),
(346, 'property', NULL, '{}'),
(347, 'property', NULL, '{}');

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 1,
  `rare` tinyint(4) NOT NULL DEFAULT 0,
  `can_remove` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Déchargement des données de la table `items`
--

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('alive_chicken', 'Living chicken', 1, 0, 1),
('baking_soda', 'Baking Soda', 1, 0, 1),
('bandage', 'Bandage', 2, 0, 1),
('blowpipe', 'Blowtorch', 2, 0, 1),
('bread', 'Bread', 1, 0, 1),
('cannabis', 'Cannabis', 3, 0, 1),
('carokit', 'Body Kit', 3, 0, 1),
('carotool', 'Tools', 2, 0, 1),
('clothe', 'Cloth', 1, 0, 1),
('coke_access', 'Access card', 1, 0, 1),
('coke_box', 'Box with Coke', 1, 0, 1),
('coke_figure', 'Action Figure', 1, 0, 1),
('coke_figurebroken', 'Pieces of Action Figure', 1, 0, 1),
('coke_figureempty', 'Action Figure', 1, 0, 1),
('coke_leaf', 'Coca Leaf', 1, 0, 1),
('coke_pure', 'Pure Coke', 1, 0, 1),
('coke_raw', 'Raw Coke', 1, 0, 1),
('copper', 'Copper', 1, 0, 1),
('crack', 'Crack', 1, 0, 1),
('crack_pipe', 'Crack Pipe', 1, 0, 1),
('cutted_wood', 'Cut wood', 1, 0, 1),
('diamond', 'Diamond', 1, 0, 1),
('ecstasy1', 'Ecstasy', 1, 0, 1),
('ecstasy2', 'Ecstasy', 1, 0, 1),
('ecstasy3', 'Ecstasy', 1, 0, 1),
('ecstasy4', 'Ecstasy', 1, 0, 1),
('ecstasy5', 'Ecstasy', 1, 0, 1),
('essence', 'Gas', 1, 0, 1),
('fabric', 'Fabric', 1, 0, 1),
('fish', 'Fish', 1, 0, 1),
('fixkit', 'Repair Kit', 3, 0, 1),
('fixtool', 'Repair Tools', 2, 0, 1),
('gazbottle', 'Gas Bottle', 2, 0, 1),
('glue', 'Glue', 1, 0, 1),
('gold', 'Gold', 1, 0, 1),
('hammer', 'Hammer', 1, 0, 1),
('heroin', 'Heroin', 1, 0, 1),
('heroin_syringe', 'Heroin Syringe', 1, 0, 1),
('iron', 'Iron', 1, 0, 1),
('jewels', 'bijoux', 25, 0, 1),
('lsd1', 'LSD', 1, 0, 1),
('lsd2', 'LSD', 1, 0, 1),
('lsd3', 'LSD', 1, 0, 1),
('lsd4', 'LSD', 1, 0, 1),
('lsd5', 'LSD', 1, 0, 1),
('magicmushroom', 'Mushroom', 1, 0, 1),
('marijuana', 'Marijuana', 2, 0, 1),
('meth_access', 'Access card', 1, 0, 1),
('meth_amoniak', 'Ammonia', 1, 0, 1),
('meth_bag', 'Meth bag', 1, 0, 1),
('meth_emptysacid', 'Empty Canister', 1, 0, 1),
('meth_glass', 'Tray with meth', 1, 0, 1),
('meth_pipe', 'Meth Pipe', 1, 0, 1),
('meth_sacid', 'Sodium Benzoate Canister', 1, 0, 1),
('meth_sharp', 'Tray with smashed meth', 1, 0, 1),
('meth_syringe', 'Meth Syringe', 1, 0, 1),
('packaged_chicken', 'Chicken fillet', 1, 0, 1),
('packaged_plank', 'Packaged wood', 1, 0, 1),
('petrol', 'Oil', 1, 0, 1),
('petrol_raffin', 'Processed oil', 1, 0, 1),
('phone', 'Phone', 1, 0, 1),
('plastic_bag', 'Plastic bag', 1, 0, 1),
('poppyplant', 'Poppy Plant', 1, 0, 1),
('radio', 'Radio', 1, 0, 1),
('scale', 'Scale', 1, 0, 1),
('scissors', 'Scissors', 1, 0, 1),
('slaughtered_chicken', 'Slaughtered chicken', 1, 0, 1),
('stone', 'Stone', 1, 0, 1),
('stretcher', 'stretcher', 1, 0, 1),
('syringe', 'Syringe', 1, 0, 1),
('trowel', 'Trowel', 1, 0, 1),
('washed_stone', 'Washed stone', 1, 0, 1),
('water', 'Water', 1, 0, 1),
('weed_access', 'Access card', 1, 0, 1),
('weed_blunt', 'Blunt', 1, 0, 1),
('weed_bud', 'Weed Bud', 1, 0, 1),
('weed_budclean', 'Weed Bud', 1, 0, 1),
('weed_joint', 'Joint', 1, 0, 1),
('weed_package', 'Weed Bag', 1, 0, 1),
('weed_papers', 'Weed papers', 1, 0, 1),
('weed_wrap', 'Blunt wraps', 1, 0, 1),
('wood', 'Wood', 1, 0, 1),
('wool', 'Wool', 1, 0, 1),
('xanaxpack', 'Pack of Xanax', 1, 0, 1),
('xanaxpill', 'Xanax pill', 1, 0, 1),
('xanaxplate', 'Plate of Xanax', 1, 0, 1);

-- --------------------------------------------------------

--
-- Structure de la table `jail`
--

CREATE TABLE `jail` (
  `id` int(11) NOT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `jailTime` int(11) NOT NULL DEFAULT 0,
  `reason` text NOT NULL,
  `jailer` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job2_grades`
--

CREATE TABLE `job2_grades` (
  `id` int(11) NOT NULL,
  `job2_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) DEFAULT 0,
  `skin_male` longtext DEFAULT '{}',
  `skin_female` longtext DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `job2_grades`
--

INSERT INTO `job2_grades` (`id`, `job2_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(1, 'nojob2', 0, 'nojob2', 'Sans job2', 0, '{}', '{}');

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Déchargement des données de la table `jobs`
--

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('ambulance', 'Ambulance', 1),
('burgershot', 'Burgershot', 1),
('cardealer', 'CarDealer', 1),
('cbd', 'CBD', 1),
('exotic', 'Auto Exotic', 0),
('gouv', 'gouvernement', 1),
('offpolice', 'Off Police', 1),
('offsheriff', 'Off Sheriff', 1),
('police', 'LSPD', 1),
('realestateagent', 'Agent immobilier', 1),
('sheriff', 'Sheriff', 1),
('tabac', 'Tabac', 1),
('taxi', 'Taxi', 1),
('unemployed', 'Unemployed', 0),
('unicorn', 'unicorn', 1),
('vigneron', 'vigneron', 1),
('weazel', 'weazel', 1),
('yellowjack', 'yellowjack', 1);

-- --------------------------------------------------------

--
-- Structure de la table `jobs2`
--

CREATE TABLE `jobs2` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `jobs2`
--

INSERT INTO `jobs2` (`name`, `label`) VALUES
('nojob2', 'NoGang');

-- --------------------------------------------------------

--
-- Structure de la table `job_grades`
--

CREATE TABLE `job_grades` (
  `id` int(11) NOT NULL,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Déchargement des données de la table `job_grades`
--

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(1, 'unemployed', 0, 'unemployed', 'Unemployed', 200, '{}', '{}'),
(66, 'cardealer', 1, 'employed', 'Employé', 1500, '{}', '{}'),
(67, 'cardealer', 2, 'avanced', 'Vendeur', 2000, '{}', '{}'),
(68, 'cardealer', 3, 'leader', 'Chef Equipe', 2500, '', ''),
(69, 'cardealer', 4, 'boss', 'Patron', 5000, '', ''),
(104, 'realestateagent', 0, 'location', 'Location', 0, '{}', '{}'),
(105, 'realestateagent', 1, 'vendeur', 'Vendeur', 0, '{}', '{}'),
(106, 'realestateagent', 2, 'gestion', 'Gestion', 0, '{}', '{}'),
(107, 'realestateagent', 3, 'boss', 'Patron', 0, '{}', '{}'),
(124, 'police', 0, 'recruit', 'Recrue', 20, '{}', '{}'),
(125, 'police', 1, 'officer', 'Officier', 40, '{}', '{}'),
(126, 'police', 2, 'sergeant', 'Sergent', 60, '{}', '{}'),
(127, 'police', 3, 'lieutenant', 'Lieutenant', 85, '{}', '{}'),
(128, 'police', 4, 'boss', 'Commandant', 100, '{}', '{}'),
(129, 'offpolice', 0, 'recruit', 'Off Recrue', 0, '{}', '{}'),
(130, 'offpolice', 1, 'officer', 'Off Officier', 0, '{}', '{}'),
(131, 'offpolice', 2, 'sergeant', 'Off Sergent', 0, '{}', '{}'),
(132, 'offpolice', 3, 'lieutenant', 'Off Lieutenant', 0, '{}', '{}'),
(133, 'offpolice', 4, 'boss', 'Off Commandant', 0, '{}', '{}'),
(134, 'ambulance', 0, 'ambulance', 'Ambulancier', 20, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(135, 'ambulance', 1, 'doctor', 'Medecin', 40, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(136, 'ambulance', 2, 'chief_doctor', 'Medecin-chef', 60, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(137, 'ambulance', 3, 'boss', 'Chirurgien', 80, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(138, 'sheriff', 0, 'recruit', 'Recrue', 20, '{}', '{}'),
(139, 'sheriff', 1, 'officer', 'Officier', 40, '{}', '{}'),
(140, 'sheriff', 2, 'sergeant', 'Sergent', 60, '{}', '{}'),
(141, 'sheriff', 3, 'lieutenant', 'Lieutenant', 85, '{}', '{}'),
(142, 'sheriff', 4, 'boss', 'Commandant', 100, '{}', '{}'),
(143, 'offsheriff', 0, 'recruit', 'Off Recrue', 0, '{}', '{}'),
(144, 'offsheriff', 1, 'officer', 'Off Officier', 0, '{}', '{}'),
(145, 'offsheriff', 2, 'sergeant', 'Off Sergent', 0, '{}', '{}'),
(146, 'offsheriff', 3, 'lieutenant', 'Off Lieutenant', 0, '{}', '{}'),
(147, 'offsheriff', 4, 'boss', 'Off Commandant', 0, '{}', '{}'),
(148, 'unicorn', 0, 'recrue', 'Intérimaire', 0, '{}', '{}'),
(149, 'unicorn', 1, 'novice', 'Experimenté', 0, '{}', '{}'),
(150, 'unicorn', 2, 'gerant', 'Gérant', 0, 'null', 'null'),
(151, 'unicorn', 3, 'boss', 'Patron', 0, '{}', '{}'),
(152, 'vigneron', 0, 'stage', 'Stagiare', 0, '{}', '{}'),
(153, 'vigneron', 1, 'novice', 'Vigneron', 0, '{}', '{}'),
(154, 'vigneron', 2, 'gerant', 'Gérant', 0, '{}', '{}'),
(155, 'vigneron', 3, 'boss', 'Patron', 0, '{}', '{}'),
(156, 'burgershot', 0, 'recruit', 'Cuisinier', 20, '{}', '{}'),
(157, 'burgershot', 1, 'officer', 'Livreur', 40, '{}', '{}'),
(158, 'burgershot', 2, 'sergeant', 'Co-Patron', 60, '{}', '{}'),
(159, 'burgershot', 3, 'boss', 'Patron', 0, '{}', '{}'),
(160, 'gouv', 0, 'recrue', 'Agent De Sécurité', 0, '{}', '{}'),
(161, 'gouv', 1, 'novice', 'Ministre', 0, '{}', '{}'),
(162, 'gouv', 2, 'gerant', ' Premier Ministre', 0, 'null', 'null'),
(163, 'gouv', 3, 'boss', 'Président', 0, '{}', '{}'),
(164, 'taxi', 0, 'recruit', 'Recrue', 20, '{}', '{}'),
(165, 'taxi', 1, 'chauffeur', 'Chauffeur', 40, '{}', '{}'),
(166, 'taxi', 2, 'cadre', 'Cadre', 60, '{}', '{}'),
(167, 'taxi', 4, 'boss', 'Commandant', 100, '{}', '{}'),
(168, 'weazel', 0, 'recrue', 'Intérimaire', 0, '{}', '{}'),
(169, 'weazel', 1, 'novice', 'Experimenté', 0, '{}', '{}'),
(170, 'weazel', 2, 'gerant', 'Gérant', 0, 'null', 'null'),
(171, 'weazel', 3, 'boss', 'Patron', 0, '{}', '{}'),
(172, 'yellowjack', 0, 'recrue', 'Intérimaire', 0, '{}', '{}'),
(173, 'yellowjack', 1, 'novice', 'Experimenté', 0, '{}', '{}'),
(174, 'yellowjack', 2, 'gerant', 'Gérant', 0, 'null', 'null'),
(175, 'yellowjack', 3, 'boss', 'Patron', 0, '{}', '{}'),
(176, 'tabac', 0, 'recrut', 'Employer', 20, '{}', '{}'),
(177, 'tabac', 1, 'farm', 'Farmeur', 40, '{}', '{}'),
(178, 'tabac', 2, 'transformer', 'Transformeur', 60, '{}', '{}'),
(179, 'tabac', 3, 'boss', 'Patron', 85, '{}', '{}'),
(180, 'cbd', 0, 'recrue', 'Intérimaire', 0, '{}', '{}'),
(181, 'cbd', 1, 'novice', 'Employé', 0, '{}', '{}'),
(182, 'cbd', 2, 'gerant', 'co-boss', 0, 'null', 'null'),
(183, 'cbd', 3, 'boss', 'Patron', 0, '{}', '{}'),
(184, 'exotic', 0, 'recruit', 'Apprenti', 20, '{}', '{}'),
(185, 'exotic', 1, 'officer', 'Mecano', 40, '{}', '{}'),
(186, 'exotic', 2, 'sergeant', 'Chef de projet', 60, '{}', '{}'),
(187, 'exotic', 3, 'lieutenant', 'Co-Patron', 85, '{}', '{}'),
(188, 'exotic', 4, 'boss', 'Patron', 100, '{}', '{}');

-- --------------------------------------------------------

--
-- Structure de la table `lbc_annonces`
--

CREATE TABLE `lbc_annonces` (
  `id` int(11) NOT NULL,
  `seller_identifier` varchar(64) NOT NULL,
  `seller_name` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_label` varchar(64) NOT NULL,
  `amount` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` enum('en_vente','vendu','supprime_admin') DEFAULT 'en_vente',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `pending_money` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `lbc_badges`
--

CREATE TABLE `lbc_badges` (
  `id` int(11) NOT NULL,
  `code` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `lbc_historique`
--

CREATE TABLE `lbc_historique` (
  `id` int(11) NOT NULL,
  `annonce_id` int(11) NOT NULL,
  `buyer_identifier` varchar(64) NOT NULL,
  `buyer_name` varchar(64) NOT NULL,
  `price` int(11) NOT NULL,
  `bought_at` timestamp NULL DEFAULT current_timestamp(),
  `seller_identifier` varchar(64) NOT NULL,
  `seller_name` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_label` varchar(64) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `lbc_user_badges`
--

CREATE TABLE `lbc_user_badges` (
  `id` int(11) NOT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `badge_code` varchar(32) NOT NULL,
  `granted_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `licenses`
--

CREATE TABLE `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Déchargement des données de la table `licenses`
--

INSERT INTO `licenses` (`type`, `label`) VALUES
('boat', 'Boat License'),
('dmv', 'Driving Permit'),
('drive', 'Drivers License'),
('drive_bike', 'Motorcycle License'),
('drive_truck', 'Commercial Drivers License'),
('weapon', 'Weapon License'),
('weed_processing', 'Weed Processing License');

-- --------------------------------------------------------

--
-- Structure de la table `lunar_fishing`
--

CREATE TABLE `lunar_fishing` (
  `user_identifier` varchar(50) NOT NULL,
  `xp` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `management_outfits`
--

CREATE TABLE `management_outfits` (
  `id` int(11) NOT NULL,
  `job_name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `minrank` int(11) NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL DEFAULT 'Cool Outfit',
  `gender` varchar(50) NOT NULL DEFAULT 'male',
  `model` varchar(50) DEFAULT NULL,
  `props` varchar(1000) DEFAULT NULL,
  `components` varchar(1500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `multicharacter_slots`
--

CREATE TABLE `multicharacter_slots` (
  `identifier` varchar(46) NOT NULL,
  `slots` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `owned_properties`
--

CREATE TABLE `owned_properties` (
  `id` int(11) NOT NULL,
  `owner` varchar(46) DEFAULT NULL,
  `property_id` int(11) NOT NULL,
  `rented` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `owned_vehicles`
--

CREATE TABLE `owned_vehicles` (
  `owner` varchar(46) DEFAULT NULL,
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) DEFAULT NULL,
  `stored` tinyint(1) NOT NULL DEFAULT 0,
  `mileage` float DEFAULT 0,
  `glovebox` longtext DEFAULT NULL,
  `trunk` longtext DEFAULT NULL,
  `vin` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ox_inventory`
--

CREATE TABLE `ox_inventory` (
  `owner` varchar(46) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `data` longtext DEFAULT NULL,
  `lastupdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `PedTable`
--

CREATE TABLE `PedTable` (
  `id` int(11) NOT NULL,
  `model` varchar(255) DEFAULT NULL,
  `coordX` float DEFAULT NULL,
  `coordY` float DEFAULT NULL,
  `coordZ` float DEFAULT NULL,
  `heading` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `playerskins`
--

CREATE TABLE `playerskins` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `skin` text NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `player_outfits`
--

CREATE TABLE `player_outfits` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `outfitname` varchar(50) NOT NULL DEFAULT '0',
  `model` varchar(50) DEFAULT NULL,
  `props` varchar(1000) DEFAULT NULL,
  `components` varchar(1500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `player_outfit_codes`
--

CREATE TABLE `player_outfit_codes` (
  `id` int(11) NOT NULL,
  `outfitid` int(11) NOT NULL,
  `code` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `properties`
--

CREATE TABLE `properties` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(100) NOT NULL,
  `entering` longtext NOT NULL,
  `exit` longtext NOT NULL,
  `inside` longtext NOT NULL,
  `outside` longtext NOT NULL,
  `ipls` longtext DEFAULT NULL,
  `gateway` int(11) DEFAULT NULL,
  `is_single` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `properties`
--

INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`) VALUES
(1, 'appart1', 'Appartement Centre Ville', '{\"x\":-268.0,\"y\":-957.0,\"z\":31.2}', '{\"x\":266.0,\"y\":-1007.0,\"z\":29.0}', '{\"x\":266.0,\"y\":-1007.0,\"z\":29.0}', '{\"x\":-268.0,\"y\":-957.0,\"z\":31.2}', NULL, NULL, 1),
(2, 'villa1', 'Villa Vinewood', '{\"x\":-763.0,\"y\":430.0,\"z\":100.0}', '{\"x\":-781.0,\"y\":318.0,\"z\":85.0}', '{\"x\":-781.0,\"y\":318.0,\"z\":85.0}', '{\"x\":-763.0,\"y\":430.0,\"z\":100.0}', NULL, NULL, 1),
(3, 'maison1', 'Petite Maison', '{\"x\":-1100.0,\"y\":-1500.0,\"z\":4.0}', '{\"x\":-1110.0,\"y\":-1490.0,\"z\":4.0}', '{\"x\":-1110.0,\"y\":-1490.0,\"z\":4.0}', '{\"x\":-1100.0,\"y\":-1500.0,\"z\":4.0}', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `property_rooms`
--

CREATE TABLE `property_rooms` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `room_name` varchar(50) NOT NULL,
  `coords` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `rented_vehicles`
--

CREATE TABLE `rented_vehicles` (
  `vehicle` varchar(60) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(46) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reports`
--

CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `reason` text NOT NULL,
  `admin_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `society_moneywash`
--

CREATE TABLE `society_moneywash` (
  `id` int(11) NOT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `society` varchar(60) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `t1ger_gangs`
--

CREATE TABLE `t1ger_gangs` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `notoriety` int(11) NOT NULL DEFAULT 0,
  `cash` int(11) NOT NULL DEFAULT 0,
  `leader` varchar(100) NOT NULL,
  `ranks` longtext DEFAULT NULL,
  `members` longtext DEFAULT NULL,
  `markers` longtext DEFAULT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT 0,
  `rackets` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `identifier` varchar(46) NOT NULL,
  `accounts` longtext DEFAULT NULL,
  `group` varchar(50) DEFAULT 'user',
  `inventory` longtext DEFAULT NULL,
  `job` varchar(20) DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `job2` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'nojob2',
  `job2_grade` int(11) NOT NULL DEFAULT 0,
  `loadout` longtext DEFAULT NULL,
  `metadata` longtext DEFAULT NULL,
  `position` longtext DEFAULT NULL,
  `firstname` varchar(16) DEFAULT NULL,
  `lastname` varchar(16) DEFAULT NULL,
  `dateofbirth` varchar(10) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `skin` longtext DEFAULT NULL,
  `status` longtext DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT 0,
  `id` int(11) NOT NULL,
  `disabled` tinyint(1) DEFAULT 0,
  `last_property` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `last_seen` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `phone_number` varchar(20) DEFAULT NULL,
  `pincode` int(11) DEFAULT NULL,
  `tattoos` longtext DEFAULT NULL,
  `animation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `demarche` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `expression` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user_licenses`
--

CREATE TABLE `user_licenses` (
  `id` int(11) NOT NULL,
  `type` varchar(60) NOT NULL,
  `owner` varchar(46) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `vehicles`
--

CREATE TABLE `vehicles` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `vehicles`
--

INSERT INTO `vehicles` (`name`, `model`, `price`, `category`) VALUES
('Adder', 'adder', 900000, 'super'),
('Akuma', 'AKUMA', 7500, 'motorcycles'),
('Alpha', 'alpha', 60000, 'sports'),
('Ardent', 'ardent', 1150000, 'sportsclassics'),
('Asea', 'asea', 5500, 'sedans'),
('Autarch', 'autarch', 1955000, 'super'),
('Avarus', 'avarus', 18000, 'motorcycles'),
('Bagger', 'bagger', 13500, 'motorcycles'),
('Baller', 'baller2', 40000, 'suvs'),
('Baller Sport', 'baller3', 60000, 'suvs'),
('Banshee', 'banshee', 70000, 'sports'),
('Banshee 900R', 'banshee2', 255000, 'super'),
('Bati 801', 'bati', 12000, 'motorcycles'),
('Bati 801RR', 'bati2', 19000, 'motorcycles'),
('Bestia GTS', 'bestiagts', 55000, 'sports'),
('BF400', 'bf400', 6500, 'motorcycles'),
('Bf Injection', 'bfinjection', 16000, 'offroad'),
('Bifta', 'bifta', 12000, 'offroad'),
('Bison', 'bison', 45000, 'vans'),
('Blade', 'blade', 15000, 'muscle'),
('Blazer', 'blazer', 6500, 'offroad'),
('Blazer Sport', 'blazer4', 8500, 'offroad'),
('blazer5', 'blazer5', 1755600, 'offroad'),
('Blista', 'blista', 8000, 'compacts'),
('BMX (velo)', 'bmx', 160, 'motorcycles'),
('Bobcat XL', 'bobcatxl', 32000, 'vans'),
('Brawler', 'brawler', 45000, 'offroad'),
('Brioso R/A', 'brioso', 18000, 'compacts'),
('Btype', 'btype', 62000, 'sportsclassics'),
('Btype Hotroad', 'btype2', 155000, 'sportsclassics'),
('Btype Luxe', 'btype3', 85000, 'sportsclassics'),
('Buccaneer', 'buccaneer', 18000, 'muscle'),
('Buccaneer Rider', 'buccaneer2', 24000, 'muscle'),
('Buffalo', 'buffalo', 12000, 'sports'),
('Buffalo S', 'buffalo2', 20000, 'sports'),
('Bullet', 'bullet', 90000, 'super'),
('Burrito', 'burrito3', 19000, 'vans'),
('Camper', 'camper', 42000, 'vans'),
('Carbonizzare', 'carbonizzare', 75000, 'sports'),
('Carbon RS', 'carbonrs', 18000, 'motorcycles'),
('Casco', 'casco', 30000, 'sportsclassics'),
('Cavalcade', 'cavalcade2', 55000, 'suvs'),
('Cheetah', 'cheetah', 375000, 'super'),
('Chimera', 'chimera', 38000, 'motorcycles'),
('Chino', 'chino', 15000, 'muscle'),
('Chino Luxe', 'chino2', 19000, 'muscle'),
('Cliffhanger', 'cliffhanger', 9500, 'motorcycles'),
('Cognoscenti Cabrio', 'cogcabrio', 55000, 'coupes'),
('Cognoscenti', 'cognoscenti', 55000, 'sedans'),
('Comet', 'comet2', 65000, 'sports'),
('Comet 5', 'comet5', 1145000, 'sports'),
('Contender', 'contender', 70000, 'suvs'),
('Coquette', 'coquette', 65000, 'sports'),
('Coquette Classic', 'coquette2', 40000, 'sportsclassics'),
('Coquette BlackFin', 'coquette3', 55000, 'muscle'),
('Cruiser (velo)', 'cruiser', 510, 'motorcycles'),
('Cyclone', 'cyclone', 1890000, 'super'),
('Daemon', 'daemon', 11500, 'motorcycles'),
('Daemon High', 'daemon2', 13500, 'motorcycles'),
('Defiler', 'defiler', 9800, 'motorcycles'),
('Deluxo', 'deluxo', 4721500, 'sportsclassics'),
('Dominator', 'dominator', 35000, 'muscle'),
('Double T', 'double', 28000, 'motorcycles'),
('Dubsta', 'dubsta', 45000, 'suvs'),
('Dubsta Luxuary', 'dubsta2', 60000, 'suvs'),
('Bubsta 6x6', 'dubsta3', 120000, 'offroad'),
('Dukes', 'dukes', 28000, 'muscle'),
('Dune Buggy', 'dune', 8000, 'offroad'),
('Elegy', 'elegy2', 38500, 'sports'),
('Emperor', 'emperor', 8500, 'sedans'),
('Enduro', 'enduro', 5500, 'motorcycles'),
('Entity XF', 'entityxf', 425000, 'super'),
('Esskey', 'esskey', 4200, 'motorcycles'),
('Exemplar', 'exemplar', 32000, 'coupes'),
('F620', 'f620', 40000, 'coupes'),
('Faction', 'faction', 20000, 'muscle'),
('Faction Rider', 'faction2', 30000, 'muscle'),
('Faction XL', 'faction3', 40000, 'muscle'),
('Faggio', 'faggio', 1900, 'motorcycles'),
('Vespa', 'faggio2', 2800, 'motorcycles'),
('Felon', 'felon', 42000, 'coupes'),
('Felon GT', 'felon2', 55000, 'coupes'),
('Feltzer', 'feltzer2', 55000, 'sports'),
('Stirling GT', 'feltzer3', 65000, 'sportsclassics'),
('Fixter (velo)', 'fixter', 225, 'motorcycles'),
('FMJ', 'fmj', 185000, 'super'),
('Fhantom', 'fq2', 17000, 'suvs'),
('Fugitive', 'fugitive', 12000, 'sedans'),
('Furore GT', 'furoregt', 45000, 'sports'),
('Fusilade', 'fusilade', 40000, 'sports'),
('Gargoyle', 'gargoyle', 16500, 'motorcycles'),
('Gauntlet', 'gauntlet', 30000, 'muscle'),
('Gang Burrito', 'gburrito', 45000, 'vans'),
('Burrito', 'gburrito2', 29000, 'vans'),
('Glendale', 'glendale', 6500, 'sedans'),
('Grabger', 'granger', 50000, 'suvs'),
('Gresley', 'gresley', 47500, 'suvs'),
('GT 500', 'gt500', 785000, 'sportsclassics'),
('Guardian', 'guardian', 45000, 'offroad'),
('Hakuchou', 'hakuchou', 31000, 'motorcycles'),
('Hakuchou Sport', 'hakuchou2', 55000, 'motorcycles'),
('Hermes', 'hermes', 535000, 'muscle'),
('Hexer', 'hexer', 12000, 'motorcycles'),
('Hotknife', 'hotknife', 125000, 'muscle'),
('Huntley S', 'huntley', 40000, 'suvs'),
('Hustler', 'hustler', 625000, 'muscle'),
('Infernus', 'infernus', 180000, 'super'),
('Innovation', 'innovation', 23500, 'motorcycles'),
('Intruder', 'intruder', 7500, 'sedans'),
('Issi', 'issi2', 10000, 'compacts'),
('Jackal', 'jackal', 38000, 'coupes'),
('Jester', 'jester', 65000, 'sports'),
('Jester(Racecar)', 'jester2', 135000, 'sports'),
('Journey', 'journey', 6500, 'vans'),
('Kamacho', 'kamacho', 345000, 'offroad'),
('Khamelion', 'khamelion', 38000, 'sports'),
('Kuruma', 'kuruma', 30000, 'sports'),
('Landstalker', 'landstalker', 35000, 'suvs'),
('RE-7B', 'le7b', 325000, 'super'),
('Lynx', 'lynx', 40000, 'sports'),
('Mamba', 'mamba', 70000, 'sports'),
('Manana', 'manana', 12800, 'sportsclassics'),
('Manchez', 'manchez', 5300, 'motorcycles'),
('Massacro', 'massacro', 65000, 'sports'),
('Massacro(Racecar)', 'massacro2', 130000, 'sports'),
('Mesa', 'mesa', 16000, 'suvs'),
('Mesa Trail', 'mesa3', 40000, 'suvs'),
('Minivan', 'minivan', 13000, 'vans'),
('Monroe', 'monroe', 55000, 'sportsclassics'),
('The Liberator', 'monster', 210000, 'offroad'),
('Moonbeam', 'moonbeam', 18000, 'vans'),
('Moonbeam Rider', 'moonbeam2', 35000, 'vans'),
('Nemesis', 'nemesis', 5800, 'motorcycles'),
('Neon', 'neon', 1500000, 'sports'),
('Nightblade', 'nightblade', 35000, 'motorcycles'),
('Nightshade', 'nightshade', 65000, 'muscle'),
('9F', 'ninef', 65000, 'sports'),
('9F Cabrio', 'ninef2', 80000, 'sports'),
('Omnis', 'omnis', 35000, 'sports'),
('Oppressor', 'oppressor', 3524500, 'super'),
('Oracle XS', 'oracle2', 35000, 'coupes'),
('Osiris', 'osiris', 160000, 'super'),
('Panto', 'panto', 10000, 'compacts'),
('Paradise', 'paradise', 19000, 'vans'),
('Pariah', 'pariah', 1420000, 'sports'),
('Patriot', 'patriot', 55000, 'suvs'),
('PCJ-600', 'pcj', 6200, 'motorcycles'),
('Penumbra', 'penumbra', 28000, 'sports'),
('Pfister', 'pfister811', 85000, 'super'),
('Phoenix', 'phoenix', 12500, 'muscle'),
('Picador', 'picador', 18000, 'muscle'),
('Pigalle', 'pigalle', 20000, 'sportsclassics'),
('Prairie', 'prairie', 12000, 'compacts'),
('Premier', 'premier', 8000, 'sedans'),
('Primo Custom', 'primo2', 14000, 'sedans'),
('X80 Proto', 'prototipo', 2500000, 'super'),
('Radius', 'radi', 29000, 'suvs'),
('raiden', 'raiden', 1375000, 'sports'),
('Rapid GT', 'rapidgt', 35000, 'sports'),
('Rapid GT Convertible', 'rapidgt2', 45000, 'sports'),
('Rapid GT3', 'rapidgt3', 885000, 'sportsclassics'),
('Reaper', 'reaper', 150000, 'super'),
('Rebel', 'rebel2', 35000, 'offroad'),
('Regina', 'regina', 5000, 'sedans'),
('Retinue', 'retinue', 615000, 'sportsclassics'),
('Revolter', 'revolter', 1610000, 'sports'),
('riata', 'riata', 380000, 'offroad'),
('Rocoto', 'rocoto', 45000, 'suvs'),
('Ruffian', 'ruffian', 6800, 'motorcycles'),
('Ruiner 2', 'ruiner2', 5745600, 'muscle'),
('Rumpo', 'rumpo', 15000, 'vans'),
('Rumpo Trail', 'rumpo3', 19500, 'vans'),
('Sabre Turbo', 'sabregt', 20000, 'muscle'),
('Sabre GT', 'sabregt2', 25000, 'muscle'),
('Sanchez', 'sanchez', 5300, 'motorcycles'),
('Sanchez Sport', 'sanchez2', 5300, 'motorcycles'),
('Sanctus', 'sanctus', 25000, 'motorcycles'),
('Sandking', 'sandking', 55000, 'offroad'),
('Savestra', 'savestra', 990000, 'sportsclassics'),
('SC 1', 'sc1', 1603000, 'super'),
('Schafter', 'schafter2', 25000, 'sedans'),
('Schafter V12', 'schafter3', 50000, 'sports'),
('Scorcher (velo)', 'scorcher', 280, 'motorcycles'),
('Seminole', 'seminole', 25000, 'suvs'),
('Sentinel', 'sentinel', 32000, 'coupes'),
('Sentinel XS', 'sentinel2', 40000, 'coupes'),
('Sentinel3', 'sentinel3', 650000, 'sports'),
('Seven 70', 'seven70', 39500, 'sports'),
('ETR1', 'sheava', 220000, 'super'),
('Shotaro Concept', 'shotaro', 320000, 'motorcycles'),
('Slam Van', 'slamvan3', 11500, 'muscle'),
('Sovereign', 'sovereign', 22000, 'motorcycles'),
('Stinger', 'stinger', 80000, 'sportsclassics'),
('Stinger GT', 'stingergt', 75000, 'sportsclassics'),
('Streiter', 'streiter', 500000, 'sports'),
('Stretch', 'stretch', 90000, 'sedans'),
('Stromberg', 'stromberg', 3185350, 'sports'),
('Sultan', 'sultan', 15000, 'sports'),
('Sultan RS', 'sultanrs', 65000, 'super'),
('Super Diamond', 'superd', 130000, 'sedans'),
('Surano', 'surano', 50000, 'sports'),
('Surfer', 'surfer', 12000, 'vans'),
('T20', 't20', 300000, 'super'),
('Tailgater', 'tailgater', 30000, 'sedans'),
('Tampa', 'tampa', 16000, 'muscle'),
('Drift Tampa', 'tampa2', 80000, 'sports'),
('Thrust', 'thrust', 24000, 'motorcycles'),
('Tri bike (velo)', 'tribike3', 520, 'motorcycles'),
('Trophy Truck', 'trophytruck', 60000, 'offroad'),
('Trophy Truck Limited', 'trophytruck2', 80000, 'offroad'),
('Tropos', 'tropos', 40000, 'sports'),
('Turismo R', 'turismor', 350000, 'super'),
('Tyrus', 'tyrus', 600000, 'super'),
('Vacca', 'vacca', 120000, 'super'),
('Vader', 'vader', 7200, 'motorcycles'),
('Verlierer', 'verlierer2', 70000, 'sports'),
('Vigero', 'vigero', 12500, 'muscle'),
('Virgo', 'virgo', 14000, 'muscle'),
('Viseris', 'viseris', 875000, 'sportsclassics'),
('Visione', 'visione', 2250000, 'super'),
('Voltic', 'voltic', 90000, 'super'),
('Voltic 2', 'voltic2', 3830400, 'super'),
('Voodoo', 'voodoo', 7200, 'muscle'),
('Vortex', 'vortex', 9800, 'motorcycles'),
('Warrener', 'warrener', 4000, 'sedans'),
('Washington', 'washington', 9000, 'sedans'),
('Windsor', 'windsor', 95000, 'coupes'),
('Windsor Drop', 'windsor2', 125000, 'coupes'),
('Woflsbane', 'wolfsbane', 9000, 'motorcycles'),
('XLS', 'xls', 32000, 'suvs'),
('Yosemite', 'yosemite', 485000, 'muscle'),
('Youga', 'youga', 10800, 'vans'),
('Youga Luxuary', 'youga2', 14500, 'vans'),
('Z190', 'z190', 900000, 'sportsclassics'),
('Zentorno', 'zentorno', 1500000, 'super'),
('Zion', 'zion', 36000, 'coupes'),
('Zion Cabrio', 'zion2', 45000, 'coupes'),
('Zombie', 'zombiea', 9500, 'motorcycles'),
('Zombie Luxuary', 'zombieb', 12000, 'motorcycles'),
('Z-Type', 'ztype', 220000, 'sportsclassics');

-- --------------------------------------------------------

--
-- Structure de la table `vehicle_categories`
--

CREATE TABLE `vehicle_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `vehicle_categories`
--

INSERT INTO `vehicle_categories` (`name`, `label`) VALUES
('compacts', 'Compacts'),
('coupes', 'CoupÃ©s'),
('motorcycles', 'Motos'),
('muscle', 'Muscle'),
('offroad', 'Off Road'),
('sedans', 'Sedans'),
('sports', 'Sports'),
('sportsclassics', 'Sports Classics'),
('super', 'Super'),
('suvs', 'SUVs'),
('vans', 'Vans');

-- --------------------------------------------------------

--
-- Structure de la table `vehicle_sold`
--

CREATE TABLE `vehicle_sold` (
  `client` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `soldby` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `account_info`
--
ALTER TABLE `account_info`
  ADD PRIMARY KEY (`license`);

--
-- Index pour la table `addon_account`
--
ALTER TABLE `addon_account`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `addon_account_data`
--
ALTER TABLE `addon_account_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  ADD KEY `index_addon_account_data_account_name` (`account_name`);

--
-- Index pour la table `addon_inventory`
--
ALTER TABLE `addon_inventory`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`),
  ADD KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`),
  ADD KEY `index_addon_inventory_inventory_name` (`inventory_name`);

--
-- Index pour la table `advanced_vehicles`
--
ALTER TABLE `advanced_vehicles`
  ADD PRIMARY KEY (`vehicle`,`user_id`,`plate`);

--
-- Index pour la table `advanced_vehicles_inspection`
--
ALTER TABLE `advanced_vehicles_inspection`
  ADD PRIMARY KEY (`vehicle`,`user_id`,`plate`,`item`);

--
-- Index pour la table `advanced_vehicles_services`
--
ALTER TABLE `advanced_vehicles_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vehicle` (`vehicle`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `plate` (`plate`);

--
-- Index pour la table `advanced_vehicles_upgrades`
--
ALTER TABLE `advanced_vehicles_upgrades`
  ADD PRIMARY KEY (`vehicle`,`user_id`,`plate`,`class`);

--
-- Index pour la table `banking`
--
ALTER TABLE `banking`
  ADD PRIMARY KEY (`ID`);

--
-- Index pour la table `banlist`
--
ALTER TABLE `banlist`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `billing`
--
ALTER TABLE `billing`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `datastore`
--
ALTER TABLE `datastore`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `datastore_data`
--
ALTER TABLE `datastore_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`),
  ADD KEY `index_datastore_data_name` (`name`);

--
-- Index pour la table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `jail`
--
ALTER TABLE `jail`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `job2_grades`
--
ALTER TABLE `job2_grades`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `jobs2`
--
ALTER TABLE `jobs2`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `job_grades`
--
ALTER TABLE `job_grades`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `lbc_annonces`
--
ALTER TABLE `lbc_annonces`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `lbc_badges`
--
ALTER TABLE `lbc_badges`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Index pour la table `lbc_historique`
--
ALTER TABLE `lbc_historique`
  ADD PRIMARY KEY (`id`),
  ADD KEY `annonce_id` (`annonce_id`);

--
-- Index pour la table `lbc_user_badges`
--
ALTER TABLE `lbc_user_badges`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `identifier` (`identifier`,`badge_code`);

--
-- Index pour la table `licenses`
--
ALTER TABLE `licenses`
  ADD PRIMARY KEY (`type`);

--
-- Index pour la table `lunar_fishing`
--
ALTER TABLE `lunar_fishing`
  ADD PRIMARY KEY (`user_identifier`);

--
-- Index pour la table `management_outfits`
--
ALTER TABLE `management_outfits`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `multicharacter_slots`
--
ALTER TABLE `multicharacter_slots`
  ADD PRIMARY KEY (`identifier`) USING BTREE,
  ADD KEY `slots` (`slots`) USING BTREE;

--
-- Index pour la table `owned_properties`
--
ALTER TABLE `owned_properties`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
  ADD PRIMARY KEY (`plate`);

--
-- Index pour la table `ox_inventory`
--
ALTER TABLE `ox_inventory`
  ADD UNIQUE KEY `owner` (`owner`,`name`);

--
-- Index pour la table `PedTable`
--
ALTER TABLE `PedTable`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `playerskins`
--
ALTER TABLE `playerskins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`),
  ADD KEY `active` (`active`);

--
-- Index pour la table `player_outfits`
--
ALTER TABLE `player_outfits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `citizenid_outfitname_model` (`citizenid`,`outfitname`,`model`),
  ADD KEY `citizenid` (`citizenid`);

--
-- Index pour la table `player_outfit_codes`
--
ALTER TABLE `player_outfit_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_player_outfit_codes_player_outfits` (`outfitid`);

--
-- Index pour la table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `property_rooms`
--
ALTER TABLE `property_rooms`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `rented_vehicles`
--
ALTER TABLE `rented_vehicles`
  ADD PRIMARY KEY (`plate`);

--
-- Index pour la table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `society_moneywash`
--
ALTER TABLE `society_moneywash`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `t1ger_gangs`
--
ALTER TABLE `t1ger_gangs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`identifier`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Index pour la table `user_licenses`
--
ALTER TABLE `user_licenses`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`model`);

--
-- Index pour la table `vehicle_categories`
--
ALTER TABLE `vehicle_categories`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `vehicle_sold`
--
ALTER TABLE `vehicle_sold`
  ADD PRIMARY KEY (`plate`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `addon_account_data`
--
ALTER TABLE `addon_account_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT pour la table `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `advanced_vehicles_services`
--
ALTER TABLE `advanced_vehicles_services`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `banking`
--
ALTER TABLE `banking`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `banlist`
--
ALTER TABLE `banlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `billing`
--
ALTER TABLE `billing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `datastore_data`
--
ALTER TABLE `datastore_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=348;

--
-- AUTO_INCREMENT pour la table `jail`
--
ALTER TABLE `jail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `job_grades`
--
ALTER TABLE `job_grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10031;

--
-- AUTO_INCREMENT pour la table `lbc_annonces`
--
ALTER TABLE `lbc_annonces`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `lbc_badges`
--
ALTER TABLE `lbc_badges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `lbc_historique`
--
ALTER TABLE `lbc_historique`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `lbc_user_badges`
--
ALTER TABLE `lbc_user_badges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `management_outfits`
--
ALTER TABLE `management_outfits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `owned_properties`
--
ALTER TABLE `owned_properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `PedTable`
--
ALTER TABLE `PedTable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `playerskins`
--
ALTER TABLE `playerskins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `player_outfits`
--
ALTER TABLE `player_outfits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `player_outfit_codes`
--
ALTER TABLE `player_outfit_codes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `properties`
--
ALTER TABLE `properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `property_rooms`
--
ALTER TABLE `property_rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `society_moneywash`
--
ALTER TABLE `society_moneywash`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `t1ger_gangs`
--
ALTER TABLE `t1ger_gangs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT pour la table `user_licenses`
--
ALTER TABLE `user_licenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `lbc_historique`
--
ALTER TABLE `lbc_historique`
  ADD CONSTRAINT `lbc_historique_ibfk_1` FOREIGN KEY (`annonce_id`) REFERENCES `lbc_annonces` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
