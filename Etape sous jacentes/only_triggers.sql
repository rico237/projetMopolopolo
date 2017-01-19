-- Ajout des triggers pour auto increment les primary key

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

CREATE SEQUENCE collection_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 NOMAXVALUE;

CREATE OR REPLACE TRIGGER nouveauCollection
BEFORE INSERT ON COLLECTION
FOR EACH ROW

BEGIN
  SELECT collection_seq.NEXTVAL
  INTO   :new.RES#
  FROM   dual;
END;
/

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
