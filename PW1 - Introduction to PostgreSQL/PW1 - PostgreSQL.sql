SELECT 10 * 3 + 5;

SELECT 10 * 3 + 5 AS "Resultat de l\'operation";

CREATE DATABASE Commandes;

CREATE TABLE Client
(
    NumClient     INT PRIMARY KEY,
    Nom           VARCHAR(50) NOT NULL,
    Prenom        VARCHAR(50) NOT NULL,
    DateNaissance DATE        NOT NULL,
    Rue           VARCHAR(50) NOT NULL,
    CP            CHAR(5)     NOT NULL,
    Ville         VARCHAR(50) NOT NULL
);

CREATE TABLE Fournisseur
(
    NumFournisseur INT PRIMARY KEY,
    RaisonSociale  VARCHAR(50) NOT NULL
);

CREATE TABLE Produit
(
    NumProduit     INT PRIMARY KEY,
    Designation    VARCHAR(50) NOT NULL,
    PrixUnitaire   MONEY       NOT NULL,
    NumFournisseur INT         NOT NULL,
    FOREIGN KEY (NumFournisseur) REFERENCES Fournisseur (NumFournisseur)
);

CREATE TABLE Commande
(
    NumClient  INT,
    NumProduit INT,
    Quantite   INT,
    Date       DATE NOT NULL,
    FOREIGN KEY (NumProduit) REFERENCES Produit (NumProduit),
    FOREIGN KEY (NumClient) REFERENCES Client (NumClient),
    PRIMARY KEY (NumProduit, NumClient)
);

INSERT INTO Client
VALUES
    (1, 'Dupont', 'Albert', '1970-06-01', 'Rue de Crimée', '69001', 'Lyon'),
    (2, 'West', 'James', '1963-09-03', 'Studio', '00000', 'Hollywood'),
    (3, 'Martin', 'Marie', '1978-06-05', 'Rue des Acacias', '69001', 'Ecully'),
    (4, 'Durand', 'Gaston', '1980-11-15', 'Rue de la Meuse', '69001', 'Lyon'),
    (5, 'Titgoutte', 'Justine', '1975-02-28', 'Chemin du Château', '69001', 'Chanonost'),
    (6, 'Dupont', 'Noémie', '1957-09-18', 'Rue de Dôle', '69001', 'Lyon');

INSERT INTO Fournisseur
VALUES
    (11, 'Top Jouet'),
    (12, 'Méga Fringue'),
    (13, 'Madame Meuble'),
    (14, 'Tout le Sport');

INSERT INTO Produit
VALUES
    (101, 'Soldat qui tire', 50.00, 11),
    (102, 'Cochon qui rit', 50.00, 11),
    (103, 'Poupée qui pleure', 100.00, 11),
    (104, 'Jean', 250.00, 12),
    (105, 'Blouson', 350.00, 12),
    (106, 'Chaussures', 200.00, 12),
    (107, 'T-Shirt', 100.00, 12),
    (108, 'Table', 500.00, 13),
    (109, 'Chaise', 100.00, 13),
    (110, 'Armoire', 1000.00, 13),
    (111, 'Lit', 5000.00, 13),
    (112, 'Raquette de tennis', 300.00, 14),
    (113, 'VTT', 699.00, 14),
    (114, 'Ballon', 75.00, 14);

INSERT INTO Commande
VALUES
    (1, 110, 1, '1999-09-24'),
    (1, 108, 1, '1999-09-24'),
    (1, 109, 4, '1999-09-24'),
    (3, 101, 2, '1999-09-24'),
    (3, 102, 1, '1999-09-24'),
    (4, 104, 3, '1999-09-24'),
    (4, 105, 1, '1999-09-24'),
    (4, 106, 2, '1999-09-24'),
    (4, 107, 5, '1999-09-24'),
    (5, 114, 10, '1999-09-24'),
    (6, 102, 2, '1999-09-24'),
    (6, 103, 5, '1999-09-24'),
    (6, 114, NULL, '1999-09-24');

-- Q1
SELECT *
FROM CLIENT;

-- Q2
SELECT *
FROM CLIENT
ORDER BY Nom DESC;

-- Q3
SELECT Designation, PrixUnitaire / 6
FROM Produit;

-- Q4
SELECT Nom, Prenom
FROM Client;

-- Q5
SELECT Nom, Prenom
FROM Client
WHERE Ville = 'Lyon';

-- Q6
SELECT *
FROM Commande
WHERE Quantite >= 3;

-- Q7
SELECT Designation
FROM Produit
WHERE PrixUnitaire >= '50'
  AND PrixUnitaire <= '100';

-- Q8
SELECT *
FROM Commande
WHERE Quantite IS NULL;

-- Q9
SELECT Nom, Ville
FROM Client
WHERE Ville LIKE '%ll%';

-- Q10
SELECT Nom
FROM Client
WHERE Prenom = 'Albert'
   OR Prenom = 'Marie'
   OR Prenom = 'Gaston';

-- Q11
SELECT AVG(PrixUnitaire::numeric)
FROM Produit;

-- Q12
SELECT COUNT(*)
FROM Commande;

-- Q13
SELECT Cl.Nom, Co.Date, Co.Quantite
FROM Client Cl,
     Commande Co
WHERE Cl.NumClient = Co.NumClient;

-- Q14
SELECT Cl.NumClient, Cl.Nom, Co.Date, Co.Quantite
FROM Client Cl,
     Commande Co
WHERE Cl.NumClient = Co.NumClient;

-- Q15
SELECT DISTINCT Cl.Nom
FROM Client Cl,
     Commande Co
WHERE Cl.NumClient = Co.NumClient
  AND Co.Quantite = 1;

-- Q16
SELECT NumClient, SUM(Quantite) Quantite
FROM Commande
GROUP BY NumClient
ORDER BY NumClient;

-- Q17
SELECT NumProduit, AVG(Quantite)
FROM Commande
GROUP BY NumProduit
HAVING COUNT(*) > 1
ORDER BY NumProduit;

-- Q18
SELECT NumProduit
FROM Produit
GROUP BY NumProduit
HAVING PrixUnitaire = MIN(PrixUnitaire);

-- Q19
INSERT INTO Fournisseur
VALUES
    (15, 'Supergame');

-- Q20
UPDATE Produit
SET PrixUnitaire = PrixUnitaire * 0.8
WHERE PrixUnitaire > '600';

-- Q21
DELETE
FROM Produit
WHERE PrixUnitaire::numeric BETWEEN 25.0 AND 80.0;

-- Q22
INSERT INTO Produit
VALUES
    (115, 'WII', 149.600, 15),
    (116, 'Playstation', 149.600, 15);

-- Q23
SELECT cl.Nom, SUM(pr.PrixUnitaire * co.Quantite)
FROM Client cl,
     Produit pr,
     Commande co
WHERE cl.NumClient = co.NumClient
  AND co.NumProduit = pr.numproduit
GROUP BY cl.NumClient;

-- Q24








