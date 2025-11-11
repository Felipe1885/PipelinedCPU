LIBRARY ieee;
USE ieee.std_logic_1164.all ;

--Entidade do registrador
ENTITY REG IS
	PORT ( DATA : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            EN, Clk : IN STD_LOGIC;
            DOUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END REG ;
ARCHITECTURE Behavior OF REG IS
	BEGIN
	PROCESS ( CLK, RESET )
		BEGIN
		IF rising_edge(CLK) AND EN = '1' THEN
			DATAOUT <= DATA;
		END IF;
	END PROCESS;
END Behavior;