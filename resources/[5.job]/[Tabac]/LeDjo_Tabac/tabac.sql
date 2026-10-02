

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_tabac', 'Tabac', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_tabac', 'Tabac', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_tabac', 'Tabac', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('tabac', 'Tabac')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('tabac',0,'recrut','Employer',20,'{}','{}'),
	('tabac',1,'farm','Farmeur',40,'{}','{}'),
	('tabac',2,'transformer','Transformeur',60,'{}','{}'),
	('tabac',3,'boss','Patron',85,'{}','{}')
;


