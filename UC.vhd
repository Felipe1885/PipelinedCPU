LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.package_components.all;

-- Entidade da Unidade de Controle
ENTITY UC IS
    PORT( OpCode: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
          Funct: IN STD_LOGIC;
          Branch, MemWrite, MemRead, MemtoReg, RegWrite, RegDst, ALUsrc, ALUop, Jump: OUT STD_LOGIC
    );
END UC;

ARCHITECTURE Behavior OF UC IS
BEGIN
    
    Branch   <= '1' WHEN OpCode = "100" ELSE '0';  -- BEQ
    MemWrite <= '1' WHEN OpCode = "010" ELSE '0';  -- SW
    MemRead  <= '1' WHEN OpCode = "001" ELSE '0';  -- LW
    MemtoReg <= '1' WHEN OpCode = "001" ELSE '0';  -- LW
    RegWrite <= '1' WHEN OpCode = "001" OR OpCode = "011" ELSE '0';  -- LW, ADD, SUB
    RegDst   <= '1' WHEN OpCode = "011" ELSE '0';  -- ADD/SUB
    ALUsrc   <= '1' WHEN OpCode = "001" OR OpCode = "010" ELSE '0';  -- LW, SW
    ALUop <= '1' WHEN (OpCode = "100") OR (OpCode = "011" AND Funct = '1') ELSE '0'; -- BEQ, SUB
    Jump <= '1' WHEN (OpCode = "101") ELSE '0'; -- JUMP

END Behavior;
