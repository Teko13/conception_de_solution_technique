DROP SCHEMA IF EXISTS express_food;

create schema express_food;
use express_food;

CREATE TABLE client (
  id INT NOT NULL AUTO_INCREMENT,
  nom VARCHAR(255) NOT NULL,
  prenom VARCHAR(255) NOT NULL,
  telephone VARCHAR(20) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  active VARCHAR(255) NOT NULL DEFAULT "isActive",
  PRIMARY KEY (id)
);


CREATE TABLE adresse (
  id INT NOT NULL AUTO_INCREMENT,
  nomDeVoie VARCHAR(255) NOT NULL,
  numDeVoie INT NOT NULL,
  ville VARCHAR(255) NOT NULL,
  codePostal INT NOT NULL,
  idClient INT NOT NULL,
  active VARCHAR(255) NOT NULL DEFAULT "isActive",
  PRIMARY KEY (id),
  CONSTRAINT fk_adresse_client FOREIGN KEY (idClient) REFERENCES client(id)
);

CREATE TABLE commande (
    id INT NOT NULL AUTO_INCREMENT,
    prixTotal INT NOT NULL,
    dateDeCommande DATETIME NOT NULL DEFAULT (DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s')),
    idClient INT NOT NULL,
    idAdresse INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_commande_client FOREIGN KEY (idClient) REFERENCES client(id),
    CONSTRAINT fk_commande_adresse FOREIGN KEY (idAdresse) REFERENCES adresse(id)
);

CREATE TABLE plat (
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    prix INT NOT NULL,
    type VARCHAR(255) NOT NULL,
    dateAjout DATE NOT NULL,
    description VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE ligneDeCommande (
    idPlat INT NOT NULL,
    commandeRef INT NOT NULL,
    quantite INT NOT NULL,
    PRIMARY KEY (idPlat, commandeRef),
    CONSTRAINT fk_ligneDeCommande_plat FOREIGN KEY (idPlat) REFERENCES plat(id),
    CONSTRAINT fk_ligneDeCommande_commande FOREIGN KEY (commandeRef) REFERENCES commande(id)
);

CREATE TABLE livreur (
  id INT NOT NULL AUTO_INCREMENT,
  nom VARCHAR(255) NOT NULL,
  prenom VARCHAR(255) NOT NULL,
  telephone VARCHAR(20) NOT NULL,
  status VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  longitude VARCHAR(255),
  latitude VARCHAR(255),
  password VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE livraison (
    id INT NOT NULL AUTO_INCREMENT,
    status VARCHAR(255) NOT NULL,
    dateLivraison DATETIME NOT NULL DEFAULT (DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s')),
    commandeRef INT NOT NULL,
    idLivreur INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT livraison_commande FOREIGN KEY (commandeRef) REFERENCES commande(id),
    CONSTRAINT livraison_livreur FOREIGN KEY (idLivreur) REFERENCES livreur(id)
);

INSERT INTO client (nom, prenom, telephone, email, password) VALUES ('Dupont', 'Sophie', '0612345678', 'sophie.dupont@gmail.com', 'motdepasse123');
INSERT INTO client (nom, prenom, telephone, email, password) VALUES ('Martin', 'Pierre', '0654321098', 'pierre.martin@yahoo.fr', 'azertyuiop');
INSERT INTO client (nom, prenom, telephone, email, password) VALUES ('Garcia', 'Laura', '0678901234', 'laura.garcia@hotmail.com', 'mdp1234');
INSERT INTO client (nom, prenom, telephone, email, password) VALUES ('Leroy', 'Alexandre', '0612458796', 'alexandre.leroy@orange.fr', 'monmotdepasse');
INSERT INTO client (nom, prenom, telephone, email, password) VALUES ('Fournier', 'Lucie', '0687451230', 'lucie.fournier@gmail.com', 'motdepasse456');

INSERT INTO adresse (nomDeVoie, numDeVoie, ville, codePostal, idClient) VALUES ('Rue du Paradis', 25, 'Paris', 75001, 1);
INSERT INTO adresse (nomDeVoie, numDeVoie, ville, codePostal, idClient) VALUES ('Avenue des Champs-Élysées', 60, 'Paris', 75008, 2);
INSERT INTO adresse (nomDeVoie, numDeVoie, ville, codePostal, idClient) VALUES ('Boulevard Saint-Germain', 145, 'Paris', 75006, 3);
INSERT INTO adresse (nomDeVoie, numDeVoie, ville, codePostal, idClient) VALUES ('Rue du Faubourg Saint-Honoré', 300, 'Paris', 75008, 4);
INSERT INTO adresse (nomDeVoie, numDeVoie, ville, codePostal, idClient) VALUES ('Rue de Rivoli', 50, 'Paris', 75001, 5);

INSERT INTO commande (prixTotal, idClient, idAdresse) VALUES (15, 1, 2);
INSERT INTO commande (prixTotal, idClient, idAdresse) VALUES (25, 2, 3);
INSERT INTO commande (prixTotal, idClient, idAdresse) VALUES (18, 3, 4);
INSERT INTO commande (prixTotal, idClient, idAdresse) VALUES (12, 4, 5);
INSERT INTO commande (prixTotal, idClient, idAdresse) VALUES (20, 5, 1);

INSERT INTO plat (nom, prix, dateAjout, description, type) VALUES ('Pizza Margherita', 12, '2023-03-31', 'Tomate, mozzarella, basilic', 'plat');
INSERT INTO plat (nom, prix, dateAjout, description, type) VALUES ('Poulet rôti', 15, '2023-03-31', 'Poulet, herbes de Provence, pommes de terre', 'plat');
INSERT INTO plat (nom, prix, dateAjout, description, type) VALUES ('Lasagne bolognaise', 10, '2023-03-31', 'Pâtes, viande hachée, sauce tomate, béchamel', 'plat');
INSERT INTO plat (nom, prix, dateAjout, description, type) VALUES ('Sushi saumon', 18, '2023-03-31', 'Riz vinaigré, saumon frais, avocat', 'plat');
INSERT INTO plat (nom, prix, dateAjout, description, type) VALUES ('Salade Caesar', 8, '2023-03-31', 'Salade romaine, poulet grillé, croûtons, sauce Caesar', 'plat');
INSERT INTO plat (nom, prix, dateAjout, description, type) VALUES ('creme bulé', 12, '2023-03-31', 'Tomate, mozzarella, basilic', 'dessert');
INSERT INTO plat (nom, prix, dateAjout, description, type) VALUES ('creme chocolat', 15, '2023-03-31', 'Poulet, herbes de Provence, pommes de terre', 'dessert');
INSERT INTO plat (nom, prix, dateAjout, description, type) VALUES ('yaourt maison', 10, '2023-03-31', 'Pâtes, viande hachée, sauce tomate, béchamel', 'dessert');
INSERT INTO plat (nom, prix, dateAjout, description, type) VALUES ('sirop a la fraise', 18, '2023-03-31', 'Riz vinaigré, saumon frais, avocat', 'dessert');
INSERT INTO plat (nom, prix, dateAjout, description, type) VALUES ('pain perdu', 8, '2023-03-31', 'Salade romaine, poulet grillé, croûtons, sauce Caesar', 'dessert');

INSERT INTO ligneDeCommande (idPlat, commandeRef, quantite) VALUES (1, 1, 2);
INSERT INTO ligneDeCommande (idPlat, commandeRef, quantite) VALUES (2, 1, 1);
INSERT INTO ligneDeCommande (idPlat, commandeRef, quantite) VALUES (3, 2, 3);
INSERT INTO ligneDeCommande (idPlat, commandeRef, quantite) VALUES (4, 3, 1);
INSERT INTO ligneDeCommande (idPlat, commandeRef, quantite) VALUES (5, 4, 2);

INSERT INTO livreur (nom, prenom, telephone, email, longitude, latitude, status, password) VALUES ('Dupont', 'Jean', '06 12 34 56 78', 'jean.dupont@example.com', '2.2938', '48.8584', 'disponible', 'password123');
INSERT INTO livreur (nom, prenom, email, telephone, longitude, latitude, status, password) VALUES ('Dupont', 'Jean', 'jean.dupont@mail.com', '0612345678', '', '', 'indisponible', 'slcjdlkdjslk');
INSERT INTO livreur (nom, prenom, email, telephone, longitude, latitude, status, password) VALUES ('Garcia', 'Marie', 'marie.garcia@mail.com', '0678452315', '', '', 'indisponible', 'lscjsljcdkl');
INSERT INTO livreur (nom, prenom, email, telephone, longitude, latitude, status, password) VALUES ('Leclerc', 'Paul', 'paul.leclerc@mail.com', '0623456789', '', '', 'indisponible', 'klsclkskljkcd');
INSERT INTO livreur (nom, prenom, email, telephone, longitude, latitude, status, password) VALUES ('Martin', 'Sophie', 'sophie.martin@mail.com', '0698765432', '2.3417', '48.8592', 'disponible', 'lcsozjicj');
INSERT INTO livreur (nom, prenom, email, telephone, longitude, latitude, status, password) VALUES ('Dubois', 'Pierre', 'pierre.dubois@mail.com', '0645123897', '', '', 'indisponible', 'lsljcosjooij');


INSERT INTO livraison (status, commandeRef, idLivreur) VALUES ('en cours', 1, 2);
INSERT INTO livraison (status, commandeRef, idLivreur) VALUES ('en cours', 2, 3);
INSERT INTO livraison (status, commandeRef, idLivreur) VALUES ('en attente', 3, 3);
INSERT INTO livraison (status, commandeRef, idLivreur) VALUES ('terminée', 4, 1);
INSERT INTO livraison (status, commandeRef, idLivreur) VALUES ('en cours', 5, 5);

