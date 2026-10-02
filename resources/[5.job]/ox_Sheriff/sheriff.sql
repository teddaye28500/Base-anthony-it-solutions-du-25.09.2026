INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_sheriff', 'Sheriff', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_sheriff', 'Sheriff', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_sheriff', 'Sheriff', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('sheriff', 'Sheriff'),
	('offsheriff', 'Off Sheriff')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('sheriff',0,'recruit','Recrue',20,'{}','{}'),
	('sheriff',1,'officer','Officier',40,'{}','{}'),
	('sheriff',2,'sergeant','Sergent',60,'{}','{}'),
	('sheriff',3,'lieutenant','Lieutenant',85,'{}','{}'),
	('sheriff',4,'boss','Commandant',100,'{}','{}'),
	('offsheriff',0,'recruit','Off Recrue',0,'{}','{}'),
	('offsheriff',1,'officer','Off Officier',0,'{}','{}'),
	('offsheriff',2,'sergeant','Off Sergent',0,'{}','{}'),
	('offsheriff',3,'lieutenant','Off Lieutenant',0,'{}','{}'),
	('offsheriff',4,'boss','Off Commandant',0,'{}','{}')
;
