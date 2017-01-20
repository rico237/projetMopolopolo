
-- Ajout des triggers pour auto increment les primary key

CREATE TABLE ADHERENT(
	AD# NUMBER(9) CONSTRAINT PK_ADHERENT PRIMARY KEY, 
	NOM VARCHAR2(15) NOT NULL,
	PRENOM VARCHAR2(20),
	DNAISS DATE NOT NULL, 
	ADR VARCHAR2(255) NOT NULL, 
	EMAIL VARCHAR2(50) NOT NULL CONSTRAINT UK_ADHERENT_EMAIL UNIQUE, 
	TEL NUMBER(11) NOT NULL, 
	DATE_ADHESION DATE DEFAULT CURRENT_DATE
);

DROP SEQUENCE adherent_seq;
CREATE SEQUENCE adherent_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 NOMAXVALUE;

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

DROP SEQUENCE auteur_seq;
CREATE SEQUENCE auteur_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 NOMAXVALUE;

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

DROP SEQUENCE editeur_seq;
CREATE SEQUENCE editeur_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 NOMAXVALUE;

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

DROP SEQUENCE collection_seq;
CREATE SEQUENCE collection_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 NOMAXVALUE;

CREATE OR REPLACE TRIGGER nouveauCollection
BEFORE INSERT ON COLLECTION
FOR EACH ROW

BEGIN
  SELECT collection_seq.NEXTVAL
  INTO   :new.COLL#
  FROM   dual;
END;
/


CREATE TABLE LIVRES ( 
	REFE# NUMBER(9) CONSTRAINT PK_LIVRES PRIMARY KEY , 
	IDAUTEUR NUMBER(5) CONSTRAINT FK_IDAUTEUR NOT NULL REFERENCES AUTEUR(ID#),
	IDEDITEUR NUMBER(5) CONSTRAINT FK_IDEDITEUR  NOT NULL REFERENCES EDITEUR(IDEDIT#),
	IDCOLL NUMBER(5) CONSTRAINT FK_IDCOLL REFERENCES COLLECTION(COLL#),
	TITRE VARCHAR2(50) NOT NULL, 
	DATE_ACHAT DATE DEFAULT CURRENT_DATE,
	PRIX NUMBER(3) NOT NULL
);

DROP SEQUENCE livre_seq;
CREATE SEQUENCE livre_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 NOMAXVALUE;

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
DROP SEQUENCE pret_seq;
CREATE SEQUENCE pret_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 NOMAXVALUE;

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
 	NOM_CATEGORIE VARCHAR2(50) NOT NULL
);

DROP SEQUENCE categorie_seq;
CREATE SEQUENCE categorie_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 NOMAXVALUE;

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


---------------------INSERTION DES AUTEURS-------------------------------------


INSERT INTO AUTEUR(NOM_AUTEUR, PRENOM_AUTEUR,DATE_NAISSANCE)
VALUES ('ROWLING', 'JOANNE', to_date('17-12-1980','dd-mm-yyyy'));


INSERT INTO AUTEUR(NOM_AUTEUR, PRENOM_AUTEUR,DATE_NAISSANCE)
VALUES ('TOLKIEN', 'JOHN RONALD REUEL', to_date('03-01-1892','dd-mm-yyyy'));


INSERT INTO AUTEUR(NOM_AUTEUR, PRENOM_AUTEUR,DATE_NAISSANCE)
VALUES ('VERNE', 'JULES GABRIEL', to_date('08-02-1828','dd-mm-yyyy'));


-------------------------INSERTION DES EDITEURS---------------------------------

INSERT INTO EDITEUR(NOM_EDIT,ADRESSE,VILLE, PAYS, TELEPHONE, MAIL)
VALUES ('FOLIO','5 rue Gaston-Gallimard', 'PARIS', 'FRANCE','0149544200','catalogue@gallimard.fr');


INSERT INTO EDITEUR(NOM_EDIT,ADRESSE,VILLE, PAYS, TELEPHONE, MAIL)
VALUES ('HATIER','8 rue d''Assas dans le VIe arrondissement', 'PARIS', 'FRANCE','0141236600',' infos@dunod.com');


-----------------------INSERTIONS DES COLLECTIONS-----------------------------

INSERT INTO COLLECTION(NOM_COLLECTION)
VALUES ('HARRY POTTER');


INSERT INTO COLLECTION(NOM_COLLECTION)
VALUES ('LE SEIGNEUR DES ANNEAUX');


----------------------INSERTIONS DES ADHERENT--------------------------------

INSERT INTO ADHERENT(NOM,PRENOM,DNAISS, ADR,EMAIL,TEL, DATE_ADHESION)
VALUES ('LAURET', 'CYRIL', to_date('30-05-1995','dd-mm-yyyy'), '1 AVENUE DU TALSADOUMA','LAURETCYRIL95@GMAIL.COM','0668396776',to_date('20-01-2017','dd-mm-yyyy'));


INSERT INTO ADHERENT(NOM,PRENOM,DNAISS, ADR,EMAIL,TEL, DATE_ADHESION)
VALUES ('WOLBER', 'HERRICK', to_date('01-10-1991','dd-mm-yyyy'), '1 AVENUE DU GAME','WOLBERERICK@YAHOO.FR','0785581871',to_date('20-01-2017','dd-mm-yyyy'));


----------------------INSERTIONS DES LIVRES--------------------------------


