
-- Ajout des triggers pour auto increment les primary key

CREATE TABLE ADHERENT(
	AD# NUMBER(9) CONSTRAINT PK_ADHERENT PRIMARY KEY, 
	NOM VARCHAR2(15) NOT NULL,
	PRENOM VARCHAR2(20),
	DNAISS DATE NOT NULL, 
	ADR VARCHAR2(255) NOT NULL, 
	EMAIL VARCHAR2(50) NOT NULL CONSTRAINT UK_ADHERENT_EMAIL UNIQUE, 
	TEL NUMBER(10) NOT NULL, 
	DATE_ADHESION DATE DEFAULT CURRENT_DATE
);

CREATE SEQUENCE adherent_seq START WITH 1;

CREATE OR REPLACE TRIGGER nouveauAdherent 
BEFORE INSERT ON ADHERENT
FOR EACH ROW

BEGIN
  SELECT adherent_seq.NEXTVAL
  INTO   :new.AD#
  FROM   dual;
END;
/


CREATE TABLE AUTEUR(
	ID# NUMBER(5) CONSTRAINT PK_AUTEUR_ID# PRIMARY KEY, 
	NOM_AUTEUR VARCHAR2(15) NOT NULL, 
	PRENOM_AUTEUR VARCHAR2(20) NOT NULL, 
	DATE_NAISSANCE DATE NOT NULL
);

CREATE SEQUENCE auteur_seq START WITH 1;

CREATE OR REPLACE TRIGGER nouveauAuteur 
BEFORE INSERT ON AUTEUR
FOR EACH ROW

BEGIN
  SELECT auteur_seq.NEXTVAL
  INTO   :new.ID#
  FROM   dual;
END;
/

CREATE TABLE EDITEUR( 
	IDEDIT# NUMBER(5) CONSTRAINT PK_EDITEUR_ID# PRIMARY KEY, 
	NOM_EDIT VARCHAR2(15) NOT NULL, 
	ADRESSE VARCHAR2(255) NOT NULL, 
	VILLE VARCHAR2(20) NOT NULL, 
	PAYS VARCHAR2(20) NOT NULL, 
	TELEPHONE NUMBER(10) NOT NULL, 
	MAIL VARCHAR2(50) NOT NULL CONSTRAINT UK_EDITEUR_MAIL UNIQUE
);
CREATE SEQUENCE editeur_seq START WITH 1;

CREATE OR REPLACE TRIGGER nouveauEditeur
BEFORE INSERT ON EDITEUR
FOR EACH ROW

BEGIN
  SELECT editeur_seq.NEXTVAL
  INTO   :new.IDEDIT#
  FROM   dual;
END;
/

-- 7 TOME DE HARRY POTTER, LE SEIGNEUR DES ANNEAUX 
CREATE TABLE COLLECTION(
	COLL# NUMBER(5) CONSTRAINT PK_COLLECTION PRIMARY KEY, 
	NOM_COLLECTION VARCHAR2(50)
);

CREATE SEQUENCE collection_seq START WITH 1;

CREATE OR REPLACE TRIGGER nouveauCollection
BEFORE INSERT ON COLLECTION
FOR EACH ROW

BEGIN
  SELECT collection_seq.NEXTVAL
  INTO   :new.RES#
  FROM   dual;
END;
/

--AT# NUMBER(4) constraint fk_at not null references auteur(at#),
CREATE TABLE LIVRES ( 
	REFE# NUMBER(9) CONSTRAINT PK_LIVRES PRIMARY KEY , 
	IDAUTEUR NUMBER(5) CONSTRAINT FK_IDAUTEUR NOT NULL REFERENCES AUTEUR(ID#),
	IDEDITEUR NUMBER(5) CONSTRAINT FK_IDEDITEUR  NOT NULL REFERENCES EDITEUR(IDEDIT#),
	IDCOLL NUMBER(5) CONSTRAINT FK_IDCOLL REFERENCES COLLECTION(COLL#),
	TITRE VARCHAR2(50) NOT NULL, 
	DATE_ACHAT DATE DEFAULT CURRENT_DATE,
	PRIX NUMBER(3) NOT NULL
);

CREATE SEQUENCE livre_seq START WITH 1;

CREATE OR REPLACE TRIGGER nouveauLivre 
BEFORE INSERT ON LIVRES 
FOR EACH ROW

BEGIN
  SELECT livre_seq.NEXTVAL
  INTO   :new.REFE#
  FROM   dual;
END;
/

 CREATE TABLE PRET( 
 	PRET# NUMBER(5) CONSTRAINT PK_PRET PRIMARY KEY, 
 	ADH NUMBER(9) CONSTRAINT FK_ADH NOT NULL REFERENCES ADHERENT(AD#),
 	REF_LIVRES NUMBER(9) CONSTRAINT FK_REF_LIVRES NOT NULL REFERENCES LIVRES(REFE#),
 	DATE_PRET DATE DEFAULT CURRENT_DATE, 
 	DATE_RETOUR_PRET DATE DEFAULT CURRENT_DATE, 
 	DATE_REEL_RETOUR DATE DEFAULT CURRENT_DATE
 );
CREATE SEQUENCE pret_seq START WITH 1;

CREATE OR REPLACE TRIGGER nouveauPret
BEFORE INSERT ON PRET
FOR EACH ROW

BEGIN
  SELECT pret_seq.NEXTVAL
  INTO   :new.PRET#
  FROM   dual;
END;
/


CREATE TABLE CATEGORIE(
 	CAT# NUMBER(5) CONSTRAINT PK_CATEGORIE_CAT# PRIMARY KEY, 
 	CAT_LIVRES NUMBER(9) CONSTRAINT FK_CAT_LIVRES NOT NULL REFERENCES LIVRES(REFE#),
 	NOM_CATEGORIE VARCHAR2(50) NOT NULL, 
);

CREATE SEQUENCE categorie_seq START WITH 1;

CREATE OR REPLACE TRIGGER nouveauCategorie
BEFORE INSERT ON CATEGORIE
FOR EACH ROW

BEGIN
  SELECT categorie_seq.NEXTVAL
  INTO   :new.CAT#
  FROM   dual;
END;
/


-- CREER UNE TABLE PENALITE ? EN PL/SQL? 


---------------------INSERTION DES VALEURS DANS LES TABLES---------------------














O