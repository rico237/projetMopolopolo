SET SERVEROUTPUT ON 

DECLARE 
	v_used_bytes NUMBER(10);
	v_Allocated_Bytes NUMBER(10);
	v_type sys.create_table_cost_columns; 
BEGIN 
	v_Type:= sys.create_table_cost_columns(
		sys.create_table_cost_colinfo('NUMBER',5),
		sys.create_table_cost_colinfo('VARCHAR2',30),
		sys.create_table_cost_colinfo('NUMBER',4),
		sys.create_table_cost_colinfo('NUMBER',10)
		);
DBMS_SPACE.CREATE_TABLE_COST('USERS',v_Type,20000, 10, v_used_Bytes,v_Allocated_Bytes);
DBMS_OUTPUT.PUT_LINE('Tableaux Livres :');
DBMS_OUTPUT.PUT_LINE('Used Bytes :' || TO_CHAR(v_used_Bytes) || 'Allocated Bytes :' || TO_CHAR(v_Allocated_Bytes)
);
END;
/		