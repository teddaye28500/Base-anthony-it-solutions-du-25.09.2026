INSERT INTO addon_account (name, label, shared) VALUES
    ('society_weazel', 'weazel', 1);

INSERT INTO addon_inventory (name, label, shared) VALUES
    ('society_weazel', 'weazel', 1);

INSERT INTO datastore (name, label, shared) VALUES 
     ('society_weazel', 'weazel', 1);

INSERT INTO jobs (name, label) VALUES
    ('weazel', 'weazel');

INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
    ('weazel', 0, 'recrue', 'Intérimaire', 0, '{}', '{}'),
    ('weazel', 1, 'novice', 'Experimenté', 0, '{}', '{}'),
    ('weazel', 2, 'gerant','Gérant', 0, 'null', 'null'),
    ('weazel', 3, 'boss', 'Patron', 0, '{}', '{}');