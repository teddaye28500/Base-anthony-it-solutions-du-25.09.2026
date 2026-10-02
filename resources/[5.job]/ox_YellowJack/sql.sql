INSERT INTO addon_account (name, label, shared) VALUES
    ('society_yellowjack', 'yellowjack', 1);

INSERT INTO addon_inventory (name, label, shared) VALUES
    ('society_yellowjack', 'yellowjack', 1);

INSERT INTO datastore (name, label, shared) VALUES 
     ('society_yellowjack', 'yellowjack', 1);

INSERT INTO jobs (name, label) VALUES
    ('yellowjack', 'yellowjack');

INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
    ('yellowjack', 0, 'recrue', 'Intérimaire', 0, '{}', '{}'),
    ('yellowjack', 1, 'novice', 'Experimenté', 0, '{}', '{}'),
    ('yellowjack', 2, 'gerant','Gérant', 0, 'null', 'null'),
    ('yellowjack', 3, 'boss', 'Patron', 0, '{}', '{}');