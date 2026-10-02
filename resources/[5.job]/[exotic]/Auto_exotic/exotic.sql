INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_exotic', 'Exotic Auto', 1);

-- --------------------------------------------------------
INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
(39, 'society_exotic', 0, NULL);

-- --------------------------------------------------------
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_exotic', 'Auto Exotic', 1);

-- --------------------------------------------------------
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('society_exotic', 'Auto Exotic', 1);

-- --------------------------------------------------------
INSERT INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
(66, 'society_exotic', NULL, '\'{}\'');

-- --------------------------------------------------------
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('exotic', 'Auto Exotic', 0);

-- --------------------------------------------------------
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(10026, 'exotic', 0, 'recruit', 'Apprenti', 20, '{}', '{}'),
(10027, 'exotic', 1, 'officer', 'Mecano', 40, '{}', '{}'),
(10028, 'exotic', 2, 'sergeant', 'Chef de projet', 60, '{}', '{}'),
(10029, 'exotic', 3, 'lieutenant', 'Co-Patron', 85, '{}', '{}'),
(10030, 'exotic', 4, 'boss', 'Patron', 100, '{}', '{}');

