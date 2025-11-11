LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

--Entidade do full adder
ENTITY FA IS
	PORT (X, Y: IN STD_LOGIC;
		S: OUT STD_LOGIC;
		CIN: IN STD_LOGIC;
		COUT: OUT STD_LOGIC);
END FA;

ARCHITECTURE LogicFunc OF FA IS
	SIGNAL C1, C2, S1: std_logic;

	BEGIN												
		S <= ((X XOR Y) XOR CIN);
		COUT <= (((X XOR Y) AND CIN) OR (X AND Y));
END LogicFunc ;
