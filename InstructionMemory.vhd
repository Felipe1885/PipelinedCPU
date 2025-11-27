LIBRARY ieee;
USE ieee.std_logic_1164.all ;
use IEEE.NUMERIC_STD.ALL;
USE work.package_components.all;

--Entidade da Memória
ENTITY InstructionMemory IS
	PORT ( Address : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
           Instruction : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END InstructionMemory;

ARCHITECTURE Behavior OF InstructionMemory IS

TYPE MemArray IS ARRAY (512 DOWNTO 0) OF STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL Mem : MemArray := (        

        -- Endereço 0x0000 (0): LW $r1, 2($r4) 
        0 => b"00101000",  
        1 => b"00100010",   

        -- 3 NOPs do load
        2 => b"00000000", 
        3 => b"00000000", 
        --NOP
        4 => b"00000000", 
        5 => b"00000000", 
        --NOP
        6 => b"00000000", 
        7 => b"00000000",


        -- ADD $r2, $r1, $r1 
        8  => b"01100010",
        9  => b"00100100",
        
        --3 NOPs do add
        --10 => b"00000000", 
        --11 => b"00000000", 
        --NOP
        --12 => b"00000000", 
        --13 => b"00000000", 
        --NOP
        --14 => b"00000000", 
        --15 => b"00000000", 


        -- SUB $r3, $r2, $r1
        10  => b"01100100",
        11  => b"00100111",

        --3 NOPs do sub
        --18 => b"00000000", 
        --19 => b"00000000", 
        --NOP
        --20 => b"00000000", 
        --21 => b"00000000", 
        --NOP
        --22 => b"00000000", 
        --23 => b"00000000",


        -- BEQ $r3, $r1, 4
        12 => b"10000010",
        13 => b"01100100",   -- Offset = 4

        -- 3 NOPs do branch
        14 => b"00000000", 
        15 => b"00000000", 
        -- NOP
        16 => b"00000000", 
        17 => b"00000000", 
        -- NOP
        18 => b"00000000", 
        19 => b"00000000", 


        -- ADD $r2, $r1, $r1 
        20  => b"01100010",
        21  => b"00100100",


        -- SW $r3, 10($r0)
        22 => b"01000000",
        23 => b"01101010",

        -- 2 NOPs do store
        -- NOP
        24 => b"00000000", 
        25 => b"00000000", 
        -- NOP
        26 => b"00000000", 
        27 => b"00000000",         


        -- LW $r3, 10($r0)
        28 => b"00100000",
        29 => b"01101010",


        -- JMP 0
        30 => b"10100000",
        31 => b"00000000",   -- Addr 13 bits

        OTHERS => b"00000000"
    );
    
SIGNAL IntegerAddrs : integer;

BEGIN

    IntegerAddrs <= to_integer(unsigned(Address));

    Instruction(15 DOWNTO 8) <= Mem(IntegerAddrs);
    Instruction(7 DOWNTO 0) <= Mem(IntegerAddrs + 1);

END Behavior;