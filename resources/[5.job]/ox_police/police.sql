INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('police', 'LSPD'),
	('offpolice', 'Off Police')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('police',0,'recruit','Recrue',20,'{}','{}'),
	('police',1,'officer','Officier',40,'{}','{}'),
	('police',2,'sergeant','Sergent',60,'{}','{}'),
	('police',3,'lieutenant','Lieutenant',85,'{}','{}'),
	('police',4,'boss','Commandant',100,'{}','{}'),
	('offpolice',0,'recruit','Off Recrue',0,'{}','{}'),
	('offpolice',1,'officer','Off Officier',0,'{}','{}'),
	('offpolice',2,'sergeant','Off Sergent',0,'{}','{}'),
	('offpolice',3,'lieutenant','Off Lieutenant',0,'{}','{}'),
	('offpolice',4,'boss','Off Commandant',0,'{}','{}')
;
