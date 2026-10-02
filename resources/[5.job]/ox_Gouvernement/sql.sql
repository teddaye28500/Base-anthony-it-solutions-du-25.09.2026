INSERT INTO addon_account (name, label, shared) VALUES
    ('society_gouv', 'gouv', 1);

INSERT INTO addon_inventory (name, label, shared) VALUES
    ('society_gouv', 'gouv', 1);

INSERT INTO datastore (name, label, shared) VALUES 
     ('society_gouv', 'gouv', 1);

INSERT INTO jobs (name, label) VALUES
    ('gouv', 'gouvernement');

INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
    ('gouv', 0, 'recrue', 'Agent De Sécurité', 0, '{}', '{}'),
    ('gouv', 1, 'novice', 'Ministre', 0, '{}', '{}'),
    ('gouv', 2, 'gerant',' Premier Ministre', 0, 'null', 'null'),
    ('gouv', 3, 'boss', 'Président', 0, '{}', '{}');