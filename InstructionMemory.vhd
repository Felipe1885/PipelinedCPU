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
SIGNAL Mem : MemArray := (        -- Endereço 0x0000 (0): NOP (0000 0000 0000 0000)
        0  => b"00000000",
        1  => b"00000000",

        -- Endereço 0x0002 (2): LW $r1, 5($r0) (0010 0000 0001 0101)
        2  => b"00100000",   -- Byte Alto (MSB)
        3  => b"00010101",   -- Byte Baixo (LSB)

        -- Endereço 0x0004 (4): LW $r2, 10($r0) (0010 0000 0010 1010)
        4  => b"00100000",
        5  => b"00101010",

        -- Endereço 0x0006 (6): ADD $r3, $r1, $r2 (0110 0001 0010 0011)
        6  => b"01100001",
        7  => b"00100011",

        -- Endereço 0x0008 (8): SUB $r4, $r3, $r1 (0110 0011 0001 0100)
        8  => b"01100011",
        9  => b"00010100",

        -- Endereço 0x000A (10): BEQ $r4, $r2, 1 (1000 0010 0100 0001)
        10 => b"10000010",   -- Byte Alto (Inclui OpCode, Rs, Rt)
        11 => b"01000001",   -- Byte Baixo (Inclui Offset=1)

        -- Endereço 0x000C (12): ADD $r1, $r1, $r1 (Instrução que deve ser pulada)
        12 => b"01100001",
        13 => b"00010001",

        -- Endereço 0x000E (14): JMP 0 (1010 0000 0000 0000)
        14 => b"10100000",   -- Byte Alto (Inclui OpCode JMP)
        15 => b"00000000",   -- Byte Baixo (Inclui Addr 13 bits)

        OTHERS => b"00000000"
    );
    
SIGNAL IntegerAddrs : integer;

	BEGIN

    IntegerAddrs <= to_integer(unsigned(Address));

    Instruction(15 DOWNTO 8) <= Mem(IntegerAddrs);
    Instruction(7 DOWNTO 0) <= Mem(IntegerAddrs + 1);

END Behavior;