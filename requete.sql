--3.2 DIVERS REQUETES

--1) 
SELECT TABLESPACE_NAME, FILE_NAME, BYTES, STATUS, ONLINE_STATUS
FROM DBA_DATA_FILES
order by TABLESPACE_NAME;

--OU 

SELECT * 
FROM sys.tab;

SELECT table_name FROM all_tables 

desc all_tables;

--2) Pour lister les tablespaces de la base ainsi que leurs fichiers associés :

-- je validee !!!! 
SELECT A.tablespace_Name, A.Alloue, B.Occupe, C.Libre 
FROM (select tablespace_name, sum(bytes)/1024/1024 AS ALLOUE from dba_data_files group by tablespace_name) a, 
(select tablespace_name, Sum(bytes)/1024/1024 AS OCCUPE from dba_segments group by tablespace_name) b, 
(select tablespace_name, Sum(bytes)/1024/1024 AS LIBRE from dba_free_space group by tablespace_name) c 
WHERE C.tablespace_Name(+) = A.tablespace_Name 
AND B.Tablespace_Name(+)= C.Tablespace_Name 
ORDER BY A.TABLESPACE_NAME; 

-- permet de lister les segments et leurs extensions de chacun des segment (tables ou indexes) de votre utilisateur
select table_name 
from dba_indexes
group by table_name;

-- voir les utilisateur 

select username
from dba_users;


L'exemple suivant définit la compression des données à columnstore sur certaines partitions, 
et à archivage columnstore sur d'autres

ALTER TABLE ColumnstoreTable1   
REBUILD PARTITION = ALL WITH (  
    DATA_COMPRESSION =  COLUMNSTORE ON PARTITIONS (4,5),  
    DATA COMPRESSION = COLUMNSTORE_ARCHIVE ON PARTITIONS (1,2,3)  
) ;  

--- proposer 3 requete libres au choix de recherche d'objet dans le dictionnaire oracle

-- Afficher toute les vues users 

select *
from dict 
where table_name name LIKE '%USER_%'
order by table_name;

--(Affiche la version d'oracle)

select * 
from V$VERSION; 

-- Classement des table par ordre croissans de colonnes 

select table_name, count(*) as Nb_columns
from user_tab_columns
where table_name = 'LIVRES'
group by table_name
order by Nb_columns; 
