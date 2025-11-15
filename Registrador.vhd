LIBRARY ieee;
USE ieee.std_logic_1164.all ;
USE work.package_components.all;

--Entidade do registrador
ENTITY Registrador IS
	GENERIC (
		N: INTEGER := 16	-- Tamanho máximo do registrador
	);

	PORT ( d_InReg : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
            En_Reg, Clk : IN STD_LOGIC;
			Reset: IN STD_LOGIC;
            d_OutReg : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
        );
END Registrador;

ARCHITECTURE Behavior OF Registrador IS
	BEGIN
	PROCESS ( CLK, Reset )
		BEGIN
		IF Reset = '1' THEN
			d_OutReg <= (others => '0');
		ELSIF rising_edge(Clk) AND En_Reg = '1' THEN
			d_OutReg <= d_InReg;
		END IF;
	END PROCESS;
END Behavior;