connect /as SYSDBA
ALTER USER CYRIL IDENTIFIED BY Diegosuarez2009 ACCOUNT UNLOCK; 

CREATE OR REPLACE DIRECTORY DATA_PUMP AS 'C:\app\cyril\oradata\CYRILBD\STOCKDUMP';
GRANT READ, WRITE ON DIRECTORY DATA_PUMP TO CYRIL;

-- ouvrir dans un autre terminal
expdp system/Diegosuarez2009@CYRILBD full=Y directory= DATA_PUMP dumpfile=DB11G.dmp logfile=expdpDB11G.log
impdp system/Diegosuarez2009@CYRILBD full=Y directory=DATA_PUMP dumpfile=DB11G.dmp logfile=impdpDB11G.log 

