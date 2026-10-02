INSERT INTO addon_account (name, label, shared) VALUES
    ('society_cbd', 'CBD', 1);

INSERT INTO addon_inventory (name, label, shared) VALUES
    ('society_cbd', 'CBD', 1);

INSERT INTO datastore (name, label, shared) VALUES 
     ('society_cbd', 'CBD', 1);

INSERT INTO jobs (name, label) VALUES
    ('cbd', 'CBD');

INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
    ('cbd', 0, 'recrue', 'Intérimaire', 0, '{}', '{}'),
    ('cbd', 1, 'novice', 'Employé', 0, '{}', '{}'),
    ('cbd', 2, 'gerant','co-boss', 0, 'null', 'null'),
    ('cbd', 3, 'boss', 'Patron', 0, '{}', '{}');