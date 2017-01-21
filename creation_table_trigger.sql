drop tablespace DATA_TBS;
create tablespace DATA_TBS
datafile 'C:\app\Rico\oradata\orcl\DATAS\data_tbs.ora' size 1M REUSE
--datafile 'c:\app\cyril\oradata\CYRILBD\DATAS\data_tbs.ora' size 1M REUSE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
ONLINE;

DROP tablespace INDEX_TBS;
create tablespace INDEX_TBS
datafile 'C:\app\Rico\oradata\orcl\INDEXES\index_tbs.ora' size 1M REUSE
--datafile 'c:\app\cyril\oradata\CYRILBD\INDEXES\index_tbs.ora' size 1M REUSE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
ONLINE;

-- Ajout des triggers pour auto increment les primary key

CREATE TABLE ADHERENT(
	AD# NUMBER(9) CONSTRAINT PK_ADHERENT PRIMARY KEY USING INDEX TABLESPACE INDEX_TBS, 
	NOM VARCHAR2(15) NOT NULL,
	PRENOM VARCHAR2(20),
	DNAISS DATE NOT NULL, 
	ADR VARCHAR2(255) NOT NULL, 
	EMAIL VARCHAR2(50) NOT NULL CONSTRAINT UK_ADHERENT_EMAIL UNIQUE, 
	TEL VARCHAR2(10) NOT NULL, 
	DATE_ADHESION DATE DEFAULT CURRENT_DATE
)tablespace DATA_TBS;

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
	ID# NUMBER(5) CONSTRAINT PK_AUTEUR_ID# PRIMARY KEY USING INDEX TABLESPACE INDEX_TBS, 
	NOM_AUTEUR VARCHAR2(15) NOT NULL, 
	PRENOM_AUTEUR VARCHAR2(20) NOT NULL, 
	DATE_NAISSANCE DATE NOT NULL
)tablespace DATA_TBS;

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
	IDEDIT# NUMBER(5) CONSTRAINT PK_EDITEUR_ID# PRIMARY KEY USING INDEX TABLESPACE INDEX_TBS, 
	NOM_EDIT VARCHAR2(30) NOT NULL, 
	ADRESSE VARCHAR2(255) NOT NULL, 
	VILLE VARCHAR2(20) NOT NULL, 
	PAYS VARCHAR2(20) NOT NULL, 
	TELEPHONE VARCHAR2(10) NOT NULL, 
	MAIL VARCHAR2(50) NOT NULL CONSTRAINT UK_EDITEUR_MAIL UNIQUE
)tablespace DATA_TBS;

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
	COLL# NUMBER(5) CONSTRAINT PK_COLLECTION PRIMARY KEY USING INDEX TABLESPACE INDEX_TBS, 
	NOM_COLLECTION VARCHAR2(50)
)tablespace DATA_TBS;

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
	REFE# NUMBER(9) CONSTRAINT PK_LIVRES PRIMARY KEY USING INDEX TABLESPACE INDEX_TBS , 
	IDAUTEUR NUMBER(5) CONSTRAINT FK_IDAUTEUR NOT NULL REFERENCES AUTEUR(ID#),
	IDEDITEUR NUMBER(5) CONSTRAINT FK_IDEDITEUR  NOT NULL REFERENCES EDITEUR(IDEDIT#),
	IDCOLL NUMBER(5) CONSTRAINT FK_IDCOLL REFERENCES COLLECTION(COLL#),
	TITRE VARCHAR2(200) NOT NULL, 
	DATE_ACHAT DATE DEFAULT CURRENT_DATE,
	PRIX NUMBER(3) NOT NULL
)tablespace DATA_TBS;

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
 	PRET# NUMBER(5) CONSTRAINT PK_PRET PRIMARY KEY USING INDEX TABLESPACE INDEX_TBS, 
 	ADH NUMBER(9) CONSTRAINT FK_ADH NOT NULL REFERENCES ADHERENT(AD#),
 	REF_LIVRES NUMBER(9) CONSTRAINT FK_REF_LIVRES NOT NULL REFERENCES LIVRES(REFE#),
 	DATE_PRET DATE DEFAULT CURRENT_DATE, 
 	DATE_RETOUR_PRET DATE DEFAULT CURRENT_DATE, 
 	DATE_REEL_RETOUR DATE DEFAULT CURRENT_DATE
)tablespace DATA_TBS;
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
 	CAT# NUMBER(5) CONSTRAINT PK_CATEGORIE_CAT# PRIMARY KEY USING INDEX TABLESPACE INDEX_TBS, 
 	CAT_LIVRES NUMBER(9) CONSTRAINT FK_CAT_LIVRES NOT NULL REFERENCES LIVRES(REFE#),
 	NOM_CATEGORIE VARCHAR2(50) NOT NULL
)tablespace DATA_TBS;

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


-- INSERT INTO AUTEUR(NOM_AUTEUR, PRENOM_AUTEUR,DATE_NAISSANCE)
-- VALUES ('ROWLING', 'JOANNE', to_date('17-12-1980','dd-mm-yyyy'));


-- INSERT INTO AUTEUR(NOM_AUTEUR, PRENOM_AUTEUR,DATE_NAISSANCE)
-- VALUES ('TOLKIEN', 'JOHN RONALD REUEL', to_date('03-01-1892','dd-mm-yyyy'));


-- INSERT INTO AUTEUR(NOM_AUTEUR, PRENOM_AUTEUR,DATE_NAISSANCE)
-- VALUES ('VERNE', 'JULES GABRIEL', to_date('08-02-1828','dd-mm-yyyy'));

-- INSERT INTO AUTEUR(NOM_AUTEUR, PRENOM_AUTEUR,DATE_NAISSANCE)
-- VALUES ('RAFFY', 'SERGE', to_date('05-04-1953','dd-mm-yyyy'));


-- INSERT INTO AUTEUR(NOM_AUTEUR, PRENOM_AUTEUR,DATE_NAISSANCE)
-- VALUES ('CHRISTIE', 'AGATHA', to_date('15-09-1890','dd-mm-yyyy'));

-- INSERT INTO AUTEUR(NOM_AUTEUR, PRENOM_AUTEUR,DATE_NAISSANCE)
-- VALUES ('LEVY', 'MARC', to_date('16-10-1961','dd-mm-yyyy'));



-- -------------------------INSERTION DES EDITEURS---------------------------------

-- INSERT INTO EDITEUR(NOM_EDIT,ADRESSE,VILLE, PAYS, TELEPHONE, MAIL)
-- VALUES ('FOLIO','5 rue Gaston-Gallimard', 'PARIS', 'FRANCE','0149544200','catalogue@gallimard.fr');


-- INSERT INTO EDITEUR(NOM_EDIT,ADRESSE,VILLE, PAYS, TELEPHONE, MAIL)
-- VALUES ('HATIER','8 rue d''Assas dans le VIe arrondissement', 'PARIS', 'FRANCE','0141236600',' infos@dunod.com');

-- INSERT INTO EDITEUR(NOM_EDIT,ADRESSE,VILLE, PAYS, TELEPHONE, MAIL)
-- VALUES ('FAYARD','13 Rue du Montparnasse', 'PARIS', 'FRANCE','0145498200','edition@fayer.fr');

-- INSERT INTO EDITEUR(NOM_EDIT,ADRESSE,VILLE, PAYS, TELEPHONE, MAIL)
-- VALUES ('LIVRE DE POCHE','21 RUE DU MONTPARNASSE', 'PARIS', 'FRANCE','0123456789','contactldp@livredepoche.com');

-- -----------------------INSERTIONS DES COLLECTIONS-----------------------------

-- INSERT INTO COLLECTION(NOM_COLLECTION)
-- VALUES ('HARRY POTTER');


-- INSERT INTO COLLECTION(NOM_COLLECTION)
-- VALUES ('LE SEIGNEUR DES ANNEAUX');


-- ----------------------INSERTIONS DES ADHERENT--------------------------------

-- INSERT INTO ADHERENT(NOM,PRENOM,DNAISS, ADR,EMAIL,TEL, DATE_ADHESION)
-- VALUES ('LAURET', 'CYRIL', to_date('30-05-1995','dd-mm-yyyy'), '1 AVENUE DU TALSADOUMA','LAURETCYRIL95@GMAIL.COM','0668396776',to_date('20-01-2017','dd-mm-yyyy'));

-- INSERT INTO ADHERENT(NOM,PRENOM,DNAISS, ADR,EMAIL,TEL, DATE_ADHESION)
-- VALUES ('WOLBER', 'HERRICK', to_date('01-10-1991','dd-mm-yyyy'), '1 AVENUE DU GAME','WOLBERERICK@YAHOO.FR','0785581871',to_date('20-01-2017','dd-mm-yyyy'));

-- INSERT INTO ADHERENT(NOM,PRENOM,DNAISS, ADR,EMAIL,TEL, DATE_ADHESION)
-- VALUES ('DWAYNE', 'JOHNSON', to_date('02-05-1972','dd-mm-yyyy'), '3 AVENUE HOLLYWOOD','DWAYNEJ@GMAIL.COM','0683902746',to_date('20-01-2017','dd-mm-yyyy'));

-- INSERT INTO ADHERENT(NOM,PRENOM,DNAISS, ADR,EMAIL,TEL, DATE_ADHESION)
-- VALUES ('ALEXANDRA', 'DADDARIO', to_date('16-03-1986','dd-mm-yyyy'), '69 AVENUE FRANKLIN ROOSEVELT','ALEXANDRADADD@OUTLOOK.FR','0767874532',to_date('20-01-2017','dd-mm-yyyy'));

-- INSERT INTO ADHERENT(NOM,PRENOM,DNAISS, ADR,EMAIL,TEL, DATE_ADHESION)
-- VALUES ('GRACE', 'BOUKOU', to_date('03-04-1991','dd-mm-yyyy'), '6 RUE DE ANTIBES','BK@GMAIL.COM','0689093412',to_date('20-01-2017','dd-mm-yyyy'));

-- ----------------------INSERTIONS DES LIVRES--------------------------------


-- INSERT INTO LIVRES(IDAUTEUR,IDEDITEUR,IDCOLL,TITRE,DATE_ACHAT,PRIX)
-- VALUES (1,1,1,'HARRY POTTER A L''ECOLE DES SORCIERS',to_date('20-01-2017','dd-mm-yyyy'),15);

-- INSERT INTO LIVRES(IDAUTEUR,IDEDITEUR,IDCOLL,TITRE,DATE_ACHAT,PRIX)
-- VALUES (1,1,1,'HARRY POTTER ET LA CHAMBRE DES SECRETS',to_date('20-01-2017','dd-mm-yyyy'),15);

-- INSERT INTO LIVRES(IDAUTEUR,IDEDITEUR,IDCOLL,TITRE,DATE_ACHAT,PRIX)
-- VALUES (1,1,1,'HARRY POTTER ET LE PRISONNIER D''ASKABAN',to_date('20-01-2017','dd-mm-yyyy'),20);

-- INSERT INTO LIVRES(IDAUTEUR,IDEDITEUR,IDCOLL,TITRE,DATE_ACHAT,PRIX)
-- VALUES (1,1,1,'HARRY POTTER ET LA COUPE DE FEU',to_date('20-01-2017','dd-mm-yyyy'),20);

-- INSERT INTO LIVRES(IDAUTEUR,IDEDITEUR,IDCOLL,TITRE,DATE_ACHAT,PRIX)
-- VALUES (1,1,1,'HARRY POTTER ET L''ORDRE DU PHOENIX',to_date('20-01-2017','dd-mm-yyyy'),25);

-- INSERT INTO LIVRES(IDAUTEUR,IDEDITEUR,IDCOLL,TITRE,DATE_ACHAT,PRIX)
-- VALUES (1,1,1,'HARRY POTTER ET LE PRINCE DE SANG MELEE',to_date('20-01-2017','dd-mm-yyyy'),25);

-- INSERT INTO LIVRES(IDAUTEUR,IDEDITEUR,IDCOLL,TITRE,DATE_ACHAT,PRIX)
-- VALUES (1,1,1,'HARRY POTTER ET LES RELIQUES DE LA MORT',to_date('20-01-2017','dd-mm-yyyy'),25);


-- INSERT INTO LIVRES(IDAUTEUR,IDEDITEUR,IDCOLL,TITRE,DATE_ACHAT,PRIX)
-- VALUES (2,1,2,'LE SEIGNEUR DES ANNEAUX -  LA COMMUNAUTE DE L''ANNEAUX',to_date('20-01-2017','dd-mm-yyyy'),25);

-- INSERT INTO LIVRES(IDAUTEUR,IDEDITEUR,IDCOLL,TITRE,DATE_ACHAT,PRIX)
-- VALUES (2,1,2,'LE SEIGNEUR DES ANNEAUX -  LES DEUX TOURS',to_date('20-01-2017','dd-mm-yyyy'),35);

-- INSERT INTO LIVRES(IDAUTEUR,IDEDITEUR,IDCOLL,TITRE,DATE_ACHAT,PRIX)
-- VALUES (2,1,2,'LE SEIGNEUR DES ANNEAUX -  LE RETOUR DU ROI ',to_date('20-01-2017','dd-mm-yyyy'),35);

-- INSERT INTO LIVRES(IDAUTEUR,IDEDITEUR,TITRE,DATE_ACHAT,PRIX)
-- VALUES (4,3,'FRANCOIS HOLLLANDE - ITINERAIRE SECRETS',to_date('20-01-2017','dd-mm-yyyy'),5);


