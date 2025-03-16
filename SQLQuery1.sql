-- DROP dacă ai nevoie (opțional)
DROP TABLE IF EXISTS DetaliiComanda;
DROP TABLE IF EXISTS Comenzi;
DROP TABLE IF EXISTS Clienti;
DROP TABLE IF EXISTS Produse;
DROP TABLE IF EXISTS Furnizori;
DROP TABLE IF EXISTS Categorii;

-- CREARE TABELE
CREATE TABLE Categorii (
    CategorieID INT IDENTITY(1,1) PRIMARY KEY,
    NumeCategorie NVARCHAR(100) NOT NULL
);

CREATE TABLE Furnizori (
    FurnizorID INT IDENTITY(1,1) PRIMARY KEY,
    NumeFurnizor NVARCHAR(100) NOT NULL,
    Tara NVARCHAR(50) NOT NULL
);

CREATE TABLE Produse (
    ProdusID INT IDENTITY(1,1) PRIMARY KEY,
    NumeProdus NVARCHAR(150) NOT NULL,
    Pret DECIMAL(10,2) NOT NULL CHECK (Pret > 0),
    Stoc INT NOT NULL CHECK (Stoc >= 0),
    CategorieID INT NOT NULL,
    FurnizorID INT NOT NULL,
    FOREIGN KEY (CategorieID) REFERENCES Categorii(CategorieID),
    FOREIGN KEY (FurnizorID) REFERENCES Furnizori(FurnizorID)
);

CREATE TABLE Clienti (
    ClientID INT IDENTITY(1,1) PRIMARY KEY,
    NumeClient NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Telefon NVARCHAR(20) NOT NULL
);

CREATE TABLE Comenzi (
    ComandaID INT IDENTITY(1,1) PRIMARY KEY,
    DataComanda DATE NOT NULL DEFAULT GETDATE(),
    ClientID INT NOT NULL,
    FOREIGN KEY (ClientID) REFERENCES Clienti(ClientID)
);

CREATE TABLE DetaliiComanda (
    DetaliiID INT IDENTITY(1,1) PRIMARY KEY,
    ComandaID INT NOT NULL,
    ProdusID INT NOT NULL,
    Cantitate INT NOT NULL CHECK (Cantitate > 0),
    FOREIGN KEY (ComandaID) REFERENCES Comenzi(ComandaID),
    FOREIGN KEY (ProdusID) REFERENCES Produse(ProdusID)
);

-- INSERARE DATE
INSERT INTO Categorii (NumeCategorie) VALUES
('Hartie reciclata'),
('Caiete eco'),
('Instrumente de scris'),
('Accesorii birou eco');

INSERT INTO Furnizori (NumeFurnizor, Tara) VALUES
('EcoPaper Romania', 'Romania'),
('GreenStationery UK', 'Marea Britanie'),
('BioOffice Germany', 'Germania'),
('Natural Supplies', 'Olanda');

INSERT INTO Produse (NumeProdus, Pret, Stoc, CategorieID, FurnizorID) VALUES
('Hartie A4 reciclata 80g', 15.99, 120, 1, 1),
('Caiet dictando 80 file eco', 12.50, 200, 2, 2),
('Pix biodegradabil cu pasta albastra', 5.99, 300, 3, 3),
('Set de agrafe din bambus', 7.50, 150, 4, 4),
('Creion din hartie reciclata', 3.50, 250, 3, 2);

INSERT INTO Clienti (NumeClient, Email, Telefon) VALUES
('Andrei Popescu', 'andrei.popescu@email.com', '0712345678'),
('Maria Ionescu', 'maria.ionescu@email.com', '0722334455'),
('Stefan Georgescu', 'stefan.georgescu@email.com', '0733445566');

INSERT INTO Comenzi (DataComanda, ClientID) VALUES
('2025-03-10', 1),
('2025-03-12', 2),
('2025-03-14', 3);

INSERT INTO DetaliiComanda (ComandaID, ProdusID, Cantitate) VALUES
(1, 1, 5),
(1, 3, 10),
(2, 2, 3),
(2, 5, 7),
(3, 4, 8);

-- VERIFICARE REZULTATE
SELECT * FROM Categorii;
SELECT * FROM Furnizori;
SELECT * FROM Produse;
SELECT * FROM Clienti;
SELECT * FROM Comenzi;
SELECT * FROM DetaliiComanda;
