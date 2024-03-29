CREATE TABLE RegKorisnik(

    ime varchar(30),
    prezime varchar(30),
    kime varchar(50) PRIMARY KEY,
    lozinka varchar(20),
    email varchar(30),
    adresa varchar(50) NULL

);

CREATE TABLE Prijatelstvo (

    kime1 varchar(50),
    kime2 varchar(50),
    datum date,
    PRIMARY KEY(kime1, kime2, datum),
    FOREIGN KEY (kime1) REFERENCES RegKorisnik(kime) ON DELETE CASCADE,
    FOREIGN KEY (kime2) REFERENCES RegKorisnik(kime) ON DELETE CASCADE   

);

CREATE TABLE Kniga (

    ISBN char(13) PRIMARY KEY,
    naslov varchar(50),
    avtor varchar(30) NOT NULL

);

CREATE TABLE Primerok (

    ISBN char(13) PRIMARY KEY,
    broj integer,
    datun date,
    pecatnica varchar(30),
    FOREIGN KEY (ISBN) REFERENCES Kniga(ISBN)


);

CREATE TABLE Original (

    ISBN char(13) PRIMARY KEY,
    cena float check ((cena > 0) OR (cena is NULL)),
    FOREIGN KEY (ISBN) REFERENCES Primerok(ISBN) ON DELETE CASCADE

);

CREATE TABLE Koristen (

    ISBN char(13) PRIMARY KEY,
    cena float check ((cena > 0) OR (cena is NULL)),
    nivoZacuvanost float,
    FOREIGN KEY (ISBN) REFERENCES Primerok(ISBN) ON DELETE SET NULL

);

CREATE TABLE Kosnicka (

    kime varchar(50), 
    ISBN char(13), 
    vreme time,
    datum date,
    FOREIGN KEY (kime) REFERENCES RegKorisnik(kime) ON DELETE CASCADE,
    FOREIGN KEY (ISBN) REFERENCES Primerok(ISBN)

);