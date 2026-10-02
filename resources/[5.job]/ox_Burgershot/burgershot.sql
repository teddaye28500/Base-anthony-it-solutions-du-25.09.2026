INSERT INTO addon_account (name, label, shared) VALUES
    ('society_burgershot', 'Burgershot', 1)
;

INSERT INTO datastore (name, label, shared) VALUES
    ('society_burgershot', 'Burgershot', 1)
;

INSERT INTO addon_inventory (name, label, shared) VALUES
    ('society_burgershot', 'Burgershot', 1)
;

INSERT INTO jobs (name, label) VALUES
    ('burgershot', 'Burgershot')
;

INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
    ('burgershot',0,'recruit','Cuisinier',20,'{}','{}'),
    ('burgershot',1,'officer','Livreur',40,'{}','{}'),
    ('burgershot',2,'sergeant','Co-Patron',60,'{}','{}'),
    ('burgershot',3,'boss','Patron',0,'{}','{}')
;