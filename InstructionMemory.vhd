LIBRARY ieee;
USE ieee.std_logic_1164.all ;
use IEEE.NUMERIC_STD.ALL;
USE work.package_components.all;

--Entidade da Memória
ENTITY InstructionMemory IS
--Entidade da Memória
ENTITY InstructionMemory IS
	PORT ( Address : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
           Instruction : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END InstructionMemory;
    );
END InstructionMemory;

ARCHITECTURE Behavior OF InstructionMemory IS
ARCHITECTURE Behavior OF InstructionMemory IS

TYPE MemArray IS ARRAY (65535 DOWNTO 0) OF STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL Mem : MemArray := (        

        -- Endereço 0x0000 (0): LW $r1, 2($r0) 
        -- Endereço 0x0000 (0): LW $r1, 2($r0) 
        0 => b"00100000",  
        1 => b"00100010",   

        -- 3 NOPs do load
        2 => b"00000000", 
        3 => b"00000000", 
        -- 3 NOPs do load
        2 => b"00000000", 
        3 => b"00000000", 
        --NOP
        4 => b"00000000", 
        5 => b"00000000", 
        --NOP
        6 => b"00000000", 
        7 => b"00000000",
        7 => b"00000000",


        -- ADD $r2, $r1, $r1 
        8  => b"01100010",
        9  => b"00100100",
        
        --3 NOPs do add
        10 => b"00000000", 
        11 => b"00000000", 
        --NOP
        12 => b"00000000", 
        13 => b"00000000", 
        --NOP
        14 => b"00000000", 
        15 => b"00000000", 


        -- SUB $r3, $r2, $r1
        16  => b"01100100",
        17  => b"00100111",

        --3 NOPs do sub
        --3 NOPs do sub
        18 => b"00000000", 
        19 => b"00000000", 
        --NOP
        20 => b"00000000", 
        21 => b"00000000", 
        --NOP
        20 => b"00000000", 
        21 => b"00000000", 
        --NOP
        22 => b"00000000", 
        23 => b"00000000",
        23 => b"00000000",


        -- BEQ $r3, $r2, 4
        24 => b"10000100",
        25 => b"01100100",   -- Offset = 4

        -- 3 NOPs do branch
        26 => b"00000000", 
        27 => b"00000000", 
        -- NOP
        28 => b"00000000", 
        29 => b"00000000", 
        -- NOP
        -- NOP
        28 => b"00000000", 
        29 => b"00000000", 
        -- NOP
        30 => b"00000000", 
        31 => b"00000000", 


        -- ADD $r2, $r1, $r1 
        32  => b"01100010",
        33  => b"00100100",


        -- SW $r3, 10($r0)
        34 => b"01000000",
        35 => b"01101010",


        -- JMP 0
        36 => b"10100000",
        37 => b"00000000",   -- Addr 13 bits

        OTHERS => b"00000000"
    );
    
SIGNAL IntegerAddrs : integer;

BEGIN
BEGIN

    IntegerAddrs <= to_integer(unsigned(Address));

    Instruction(15 DOWNTO 8) <= Mem(IntegerAddrs);
    Instruction(7 DOWNTO 0) <= Mem(IntegerAddrs + 1);

END Behavior;