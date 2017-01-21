create tablespace DATA_TBS
datafile 'c:\app\cyril\oradata\CYRILBD\DATAS\data_tbs.ora' size 1M REUSE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
ONLINE;
-- default storage
-- (initial 32 k next 32 k
-- 	minextents 2 maxextents unlimited
-- 	pctincrease 1);

create tablespace INDEX_TBS
datafile 'c:\app\cyril\oradata\CYRILBD\INDEXES\index_tbs.ora' size 1M REUSE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
ONLINE;
-- default storage
-- (initial 32 k next 32 k
-- 	minextents 2 maxextents unlimited
-- 	pctincrease 1);
