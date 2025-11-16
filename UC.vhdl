LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.package_components.all;

ENTITY UC IS
    PORT( OPCODE : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
          FUN : IN STD_LOGIC;
          RegDst, AluOp, AluSrc, Branch, MemWrite, MemRead, MemtoReg, RegWrite : OUT STD_LOGIC
    );
END UC;

ARCHITECTURE Behavior OF UC IS
Signal SUB : STD_LOGIC;
BEGIN
    
Branch   <= '1' WHEN OPCODE = "100" ELSE '0';  -- BEQ
MemWrite <= '1' WHEN OPCODE = "010" ELSE '0';  -- SW
MemRead  <= '1' WHEN OPCODE = "001" ELSE '0';  -- LW
MemtoReg <= '1' WHEN OPCODE = "001" ELSE '0';  -- LW
RegWrite <= '1' WHEN OPCODE = "001" OR OPCODE = "011" ELSE '0';  -- LW, ADD, SUB
RegDst   <= '1' WHEN OPCODE = "011" ELSE '0';  -- ADD/SUB
AluSrc   <= '1' WHEN OPCODE = "001" OR OPCODE = "010" ELSE '0';  -- LW, SW
AluOp <= '1' WHEN (OPCODE = "100") OR (OPCODE = "011" AND FUN = '1') ELSE '0'; -- BEQ, SUB
-- TODO: JUMP

END Behavior;