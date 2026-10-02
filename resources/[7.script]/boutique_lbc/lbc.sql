CREATE TABLE IF NOT EXISTS lbc_annonces (
    id INT AUTO_INCREMENT PRIMARY KEY,
    seller_identifier VARCHAR(64) NOT NULL,
    seller_name VARCHAR(64) NOT NULL,
    item_name VARCHAR(64) NOT NULL,
    item_label VARCHAR(64) NOT NULL,
    amount INT NOT NULL,
    price INT NOT NULL,
    image_url VARCHAR(255) DEFAULT NULL,
    description TEXT,
    status ENUM('en_vente', 'vendu', 'supprime_admin') DEFAULT 'en_vente',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS lbc_historique (
    id INT AUTO_INCREMENT PRIMARY KEY,
    annonce_id INT NOT NULL,
    buyer_identifier VARCHAR(64) NOT NULL,
    buyer_name VARCHAR(64) NOT NULL,
    price INT NOT NULL,
    bought_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    seller_identifier VARCHAR(64) NOT NULL,
    seller_name VARCHAR(64) NOT NULL,
    item_name VARCHAR(64) NOT NULL,
    item_label VARCHAR(64) NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (annonce_id) REFERENCES lbc_annonces(id)
);

ALTER TABLE lbc_annonces ADD COLUMN pending_money INT DEFAULT 0;

CREATE TABLE IF NOT EXISTS lbc_badges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(32) NOT NULL UNIQUE,   -- ex: "certified", "10sales"
    name VARCHAR(64) NOT NULL,          -- ex: "Vendeur certifié"
    description VARCHAR(255) DEFAULT NULL,
    image_url VARCHAR(255) DEFAULT NULL -- (logo du badge)
);

CREATE TABLE IF NOT EXISTS lbc_user_badges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(64) NOT NULL,
    badge_code VARCHAR(32) NOT NULL,
    granted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(identifier, badge_code)
);

--Ajouter un badge manuellement:
--MySQL.insert('INSERT IGNORE INTO lbc_user_badges (identifier, badge_code) VALUES (?, ?)', {identifier, '10ventes'})

--Ajouter un badge a un joueur:
--INSERT INTO lbc_user_badges (identifier, badge_code)
--VALUES ('steam:11000011abcdefg/CFX', 'certifie');

