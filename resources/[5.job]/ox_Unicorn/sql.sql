INSERT INTO addon_account (name, label, shared) VALUES
    ('society_unicorn', 'unicorn', 1);

INSERT INTO addon_inventory (name, label, shared) VALUES
    ('society_unicorn', 'unicorn', 1);

INSERT INTO datastore (name, label, shared) VALUES 
     ('society_unicorn', 'unicorn', 1);

INSERT INTO jobs (name, label) VALUES
    ('unicorn', 'unicorn');

INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
    ('unicorn', 0, 'recrue', 'Intérimaire', 0, '{}', '{}'),
    ('unicorn', 1, 'novice', 'Experimenté', 0, '{}', '{}'),
    ('unicorn', 2, 'gerant','Gérant', 0, 'null', 'null'),
    ('unicorn', 3, 'boss', 'Patron', 0, '{}', '{}');