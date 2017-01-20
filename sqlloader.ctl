LOAD DATA INFILE 'c:\app\cyril\oradata\CYRILBD\DATA\data.csv'
TRUNCATE
INTO TABLE AUTEUR WHEN tab = 'AUTEUR'
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY "'"
( tab FILLER char(6),
	nom CHAR,
	prenom CHAR,
	date_NAISS DATE)
INTO TABLE EDITEUR WHEN tab = 'EDITEUR'
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY "'"
( tab FILLER POSITION(1),
	NOM_EDIT CHAR,
	ADRESSE CHAR,
	VILLE CHAR,
	PAYS CHAR, 
	TELEPHONE CHAR, 
	MAIL CHAR)
INTO TABLE COLLECTION WHEN tab = 'COLLECTION'
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY "'"
( tab FILLER POSITION(1), 
	NOM_COLLECTION CHAR)
INTO TABLE ADHERENT WHEN tab = 'ADHERENT'
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY "'"
( tab FILLER POSITION(1),
	NOM CHAR,
	PRENOM CHAR,
	DNAISS DATE, 
	ADR CHAR,
	EMAIL CHAR,
	TEL CHAR, 
	DATE_ADHESION DATE)