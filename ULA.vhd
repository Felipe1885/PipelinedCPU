LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.COMPONENTS.all;
ENTITY ULA IS
PORT (
       OPCODE: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
       X: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
       Y: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
       RESULT: BUFFER STD_LOGIC_VECTOR (15 DOWNTO 0);
       ZERO: OUT STD_LOGIC;
       OVERFLOW: OUT STD_LOGIC;
       COUT: OUT STD_LOGIC);
END ULA;

ARCHITECTURE Structure OF ULA IS

SIGNAL ADD, SUB: STD_LOGIC_VECTOR(16 DOWNTO 0);
SIGNAL  CO, CO2, ZR, OV: STD_LOGIC;

BEGIN

ST1: Adder PORT MAP ('0', X, Y, ADD, CO);
ST2: Adder PORT MAP ('1', X, Y, SUB, CO2);  

ZR <= '1' when RESULT = "0000000000000000" else '0';

OV <= ((X(3) and Y(3) and not E(3)) or (not X(3) and not Y(3) and E(3))) when OPCODE = "01" else
      ((X(3) and Y(3) and not F(3)) or (not X(3) and not Y(3) and F(3))) when OPCODE = "10" else	
      '0';

WITH OPCODE SELECT
ZERO <= '0' WHEN "00",
         ZR WHEN OTHERS;

WITH OPCODE SELECT
OVERFLOW <= '0' WHEN "00",
            OV WHEN OTHERS;

WITH OPCODE SELECT
COUT <= CO WHEN "01",
		  CO2 WHEN "10",
		  '0' WHEN OTHERS;

WITH OPCODE SELECT
RESULT <= ADD WHEN "01",
          SUB WHEN "10",
          "0000" WHEN OTHERS;

END Structure;