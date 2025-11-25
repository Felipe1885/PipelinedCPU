LIBRARY ieee;
USE ieee.std_logic_1164.all ;
use IEEE.NUMERIC_STD.ALL;
USE work.package_components.all;

--Entidade da Memoriua
ENTITY Memory IS
	PORT ( Address : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
           Instruction : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
END Memory;

ARCHITECTURE Behavior OF Memory IS

TYPE MemArray IS ARRAY (65535 DOWNTO 0) OF STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL Mem : MemArray := (        

        -- Endereço 0x0000 (0): LW $r1, 5($r0) 
        0 => b"00100000",  
        1 => b"00010101",   

        -- LW $r2, 10($r0)
        2  => b"00100000",
        3  => b"00101010",

        --NOP
        4 => b"00000000", 
        5 => b"00000000", 

        --NOP
        6 => b"00000000", 
        7 => b"00000000", 

        -- ADD $r3, $r1, $r2 
        8  => b"01100001",
        9  => b"00100011",

        --NOP
        10 => b"00000000", 
        11 => b"00000000", 

        --NOP
        12 => b"00000000", 
        13 => b"00000000", 

        -- SUB $r4, $r3, $r1
        14  => b"01100011",
        15  => b"00010100",

        --NOP
        16 => b"00000000", 
        17 => b"00000000", 

        --NOP
        18 => b"00000000", 
        19 => b"00000000", 

        -- BEQ $r4, $r2, 1
        20 => b"10000010",
        21 => b"01000001",   -- Offset = 1

        --NOP
        22 => b"00000000", 
        23 => b"00000000", 

        --NOP
        24 => b"00000000", 
        25 => b"00000000", 
    
        --NOP
        26 => b"00000000", 
        27 => b"00000000", 

        -- ADD $r1, $r1, $r1
        28 => b"01100001",
        29 => b"00010001",

        --NOP
        30 => b"00000000", 
        31 => b"00000000", 
    
        --NOP
        32 => b"00000000", 
        33 => b"00000000",

        -- JMP 0
        34 => b"10100000",
        35 => b"00000000",   -- Addr 13 bits

        OTHERS => b"00000000"
    );
    
SIGNAL IntegerAddrs : integer;

	BEGIN

    IntegerAddrs <= to_integer(unsigned(Address));

    Instruction(15 DOWNTO 8) <= Mem(IntegerAddrs);
    Instruction(7 DOWNTO 0) <= Mem(IntegerAddrs + 1);

END Behavior;