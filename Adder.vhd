LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.package_components.all;

--Entidade do somador de 4 bits
ENTITY Adder IS
	PORT (A, B: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		Cin : IN STD_LOGIC;
		S: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		Cout: OUT STD_LOGIC
	);
END Adder;

ARCHITECTURE Structure OF Adder  IS

	SIGNAL c : STD_LOGIC_VECTOR(16 DOWNTO 0);

	--Port Map para o Ripple Carry
	BEGIN
		c(0) <= Cin;

		Gen_ADDER: FOR i IN 0 TO 15 GENERATE
			stage_i: FullAdder PORT MAP (
				A => A(i),
				B => B(i),
				S => S(i),
				CIN => c(i),
				COUT => c(i+1)
			);
		END GENERATE;

		Cout <= c(16);

END Structure;