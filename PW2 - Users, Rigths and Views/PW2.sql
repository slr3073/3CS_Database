--Connection with postgres on postgres
CREATE USER "Antony" WITH PASSWORD 'antpass' CREATEDB CREATEROLE;
CREATE USER "Fabrice" WITH PASSWORD 'fabword';
CREATE USER "Marven" WITH PASSWORD 'marword' CREATEDB;

-- Connection with antony on postgres
CREATE DATABASE cirque;

-- Connection with Antony on cirque

CREATE TABLE Personnel
(
    Nom  VARCHAR(20) PRIMARY KEY,
    Role VARCHAR(20) NOT NULL
);

CREATE TABLE Numero
(
    Titre       VARCHAR(30) PRIMARY KEY,
    Nature      VARCHAR(20) NOT NULL,
    Responsable VARCHAR(20),
    FOREIGN KEY (Responsable) REFERENCES Personnel (Nom)
);

CREATE TABLE Accessoire
(
    Nom      VARCHAR(30) PRIMARY KEY,
    Couleur  VARCHAR(10),
    Volume   DECIMAL(5, 2),
    Ratelier INT,
    Camion   INT
);

CREATE TABLE Utilisation
(
    Titre       VARCHAR(30),
    Utilisateur VARCHAR(30),
    Accessoire  VARCHAR(30),
    FOREIGN KEY (Titre) REFERENCES Numero (Titre),
    FOREIGN KEY (Utilisateur) REFERENCES Personnel (Nom),
    FOREIGN KEY (Accessoire) REFERENCES Accessoire (Nom),
    PRIMARY KEY (Titre, Utilisateur, Accessoire)
);

-- Connection on cirque with Marven but cannot populate cirque
-- Connection on cirque with postgres
ALTER DATABASE cirque OWNER TO "Marven";

-- Check ownership
SELECT d.datname                            as "Name",
       pg_catalog.pg_get_userbyid(d.datdba) as "Owner"
FROM pg_catalog.pg_database d
WHERE d.datname = 'cirque'
ORDER BY 1;

-- Connection on cirque with Marven but cannot insert data
-- Connection with postgres on cirque
GRANT INSERT ON Personnel, Utilisation, Numero, Accessoire TO "Marven";

-- Connection with Marven on cirque
INSERT INTO Personnel
VALUES
    ('Clovis', 'Jongleur'),
    ('Reine de May', 'Ecuyer'),
    ('Louche', 'Clown'),
    ('Attention', 'Equilibriste'),
    ('Partition', 'Musicien'),
    ('Crinière', 'Dompteur'),
    ('Jerry', 'Clown'),
    ('Bal', 'Jongleur'),
    ('Final', 'Musicien'),
    ('Louis', 'Jongleur'),
    ('Léo', 'Jongleur'),
    ('Lulu', 'Ecuyer'),
    ('Coloquinte', 'Equilibriste'),
    ('Grostas', 'Jongleur'),
    ('Sangtrèspur', 'Dompteur');

INSERT INTO Numero
VALUES
    ('Les Zoupalas', 'Jonglerie', 'Clovis'),
    ('Le coche infernal', 'Equitation', 'Reine de May'),
    ('Les fauves', 'Clownerie', 'Louche'),
    ('Les Smilers', 'Equilibre', 'Attention'),
    ('La passoire magique', 'Lion', 'Crinière'),
    ('Les Zozos', 'Clownerie', 'Jerry'),
    ('Les Tartarins', 'Jonglerie', 'Bal');

INSERT INTO Accessoire
VALUES
    ('Ballon', 'Rouge', 0.3, 15, 5),
    ('Barre', 'Blanc', 0.6, 19, 5),
    ('Fouet', 'Marron', 0.2, 11, 3),
    ('Bicyclette à éléphant', 'Vert', 0.4, 27, 8),
    ('Trompette', 'Rouge', 0.2, 2, 1),
    ('Cercle magique', 'Orange', 0.2, 1, 1),
    ('Boule', 'Cristal', 0.2, 88, 8),
    ('Cage à lions', 'Noir', 10.0, 10, 2),
    ('Chaise longue de lion', 'Bleu', 0.9, 11, 5),
    ('Peigne de chimpanzé', 'Jaune', 0.2, 23, 3),
    ('Etrier', NULL, NULL, NULL, NULL);

INSERT INTO Utilisation
VALUES
    ('Les Zoupalas', 'Louis', 'Ballon'),
    ('Les Zoupalas', 'Léo', 'Ballon'),
    ('Les Zoupalas', 'Louis', 'Barre'),
    ('Le coche infernal', 'Grostas', 'Bicyclette à éléphant'),
    ('Le coche infernal', 'Lulu', 'Fouet'),
    ('Les fauves', 'Jerry', 'Trompette'),
    ('Les Smilers', 'Attention', 'Cercle magique'),
    ('Les Smilers', 'Attention', 'Boule'),
    ('Les Smilers', 'Coloquinte', 'Bicyclette à éléphant'),
    ('La passoire magique', 'Crinière', 'Cage à lions'),
    ('La passoire magique', 'Crinière', 'Chaise longue de lion'),
    ('Les Zozos', 'Jerry', 'Bicyclette à éléphant'),
    ('Les Zozos', 'Jerry', 'Peigne de chimpanzé'),
    ('Les Tartarins', 'Grostas', 'Bicyclette à éléphant'),
    ('Le coche infernal', 'Sangtrèspur', 'Etrier');

-- Connection with Fabrice on cirque
CREATE VIEW Res_Numero AS
SELECT Titre, Responsable
FROM Numero;

-- Connection with postgres on cirque
GRANT INSERT, DELETE, UPDATE, SELECT ON Numero TO "Fabrice";

-- Connection with Frabrice on cirque
UPDATE Res_Numero
SET Responsable = 'Léo'
WHERE Titre = 'Les Zoupalas';
-- Both view and Numero has been updated Responsable = Léo

CREATE VIEW ListeAccesoiresUtilisees AS
SELECT a.Nom, n.Titre, a.Camion, a.Ratelier
FROM Utilisation u,
     Accessoire a,
     Numero n
WHERE a.Nom = u.Accessoire
  AND n.Titre = u.Titre;

-- Connection with postgres on cirque
GRANT SELECT, UPDATE, INSERT ON ListeAccesoiresUtilisees TO "Marven";

GRANT SELECT, UPDATE ON Res_Numero TO "Antony";

-- Connection with Antony on cirque
SELECT Titre
FROM Res_Numero
WHERE Titre LIKE '%zo%';

CREATE USER "Carol" WITH PASSWORD 'myworld' VALID UNTIL 'Jan 1 2021' CREATEDB;

ALTER USER "Carol" WITH PASSWORD 'yesworld';
ALTER USER "Carol" VALID UNTIL 'infinity';

-- Connection with postgres on cirque
GRANT CREATE ON DATABASE Cirque TO "Carol";
GRANT SELECT ON Personnel To "Carol";

-- Connection with Carol on cirque
CREATE SCHEMA AUTHORIZATION "Carol";


CREATE TABLE Personnel AS
SELECT *
FROM Personnel
