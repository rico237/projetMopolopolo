-- change le repertoire par défaut des backup
CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT '%ORACLE_BASE%\oradata\orcl\backup\full_%u_%s_%p';
-- arret de la base de donne
SHUTDOWN IMMEDIATE;
-- mise en étape MOUNT
STARTUP MOUNT;
-- Données
BACKUP DATABASE;
-- Tablespace n'exedant pas les 10Mo
BACKUP DEVICE TYPE sbt MAXSETSIZE = 10M TABLESPACE DATA_TBS, INDEX_TBS;
-- Les Archives
BACKUP ARCHIVELOG ALL NOT BACKED UP SINCE TIME 'SYSDATE-1';
-- paramètres serveur
BACKUP SPFILE;
-- Les fichiers de controles ()
BACKUP CURRENT CONTROLFILE;
--Lancement de la BDD
ALTER TABLE OPEN;