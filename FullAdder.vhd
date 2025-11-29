LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE work.package_components.all;

--Entidade do Full Adder
ENTITY FullAdder IS
	PORT (A, B: IN STD_LOGIC;
		S: OUT STD_LOGIC;
		CIN: IN STD_LOGIC;
		COUT: OUT STD_LOGIC
	);
END FullAdder;

ARCHITECTURE LogicFunc OF FullAdder IS
	SIGNAL C1, C2, S1: std_logic;

	BEGIN												
		S <= ((A XOR B) XOR CIN);
		COUT <= (((A XOR B) AND CIN) OR (A AND B));
END LogicFunc ;
