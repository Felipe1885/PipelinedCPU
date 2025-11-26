LIBRARY ieee;
USE ieee.std_logic_1164.all ;
use IEEE.NUMERIC_STD.ALL;
USE work.package_components.all;

--Entidade da Memoriua
ENTITY DataMemory IS
	PORT ( Address, WriteData : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
           MemWrite, MemRead, CLK : IN STD_LOGIC;
           ReadData : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
END DataMemory;

ARCHITECTURE Behavior OF DataMemory IS

TYPE MemArray IS ARRAY (512 DOWNTO 0) OF STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL Mem : MemArray;
SIGNAL IntegerAddrs : integer;

	BEGIN

    IntegerAddrs <= to_integer(unsigned(Address));

	PROCESS (CLK)
    BEGIN
        IF rising_edge(CLK) THEN
            IF MemWrite = '1' THEN
                Mem(IntegerAddrs) <= WriteData(15 DOWNTO 8);
                Mem(IntegerAddrs + 1) <= WriteData(7 DOWNTO 0);
            END IF;
        END IF;
	END PROCESS;

    
    ReadData(15 DOWNTO 8) <= Mem(IntegerAddrs) WHEN MemRead = '1' ELSE (OTHERS => '0');
    ReadData(7 DOWNTO 0) <= Mem(IntegerAddrs + 1) WHEN MemRead = '1' ELSE (OTHERS => '0');

END Behavior;