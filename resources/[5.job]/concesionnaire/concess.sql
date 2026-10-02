INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_cardealer', 'CarDealer', 0);

INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
(17, 'society_cardealer', 0, NULL),
(18, 'society_cardealer', 0, NULL),
(19, 'society_cardealer', 0, NULL),
(20, 'society_cardealer', 0, 'char1:b4c6ff01496135d6a5b51dfb88d00cb0efc2adda');

INSERT INTO `jobs` (`name`, `label`) VALUES
('cardealer', 'CarDealer');

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(66, 'cardealer', 1, 'employed', 'Employé', 1500, '{}', '{}'),
(67, 'cardealer', 2, 'avanced', 'Vendeur', 2000, '{}', '{}'),
(68, 'cardealer', 3, 'leader', 'Chef Equipe', 2500, '', ''),
(69, 'cardealer', 4, 'boss', 'Patron', 5000, '', '');


INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('society_cardealer', 'CarDealer', 1);


INSERT INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
(1, 'society_cardealer', NULL, '\'{}\'');

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_cardealer', 'CarDealer', 1);