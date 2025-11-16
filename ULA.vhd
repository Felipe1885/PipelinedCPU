LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.package_components.all;

-- Entidade da ULA de 16 bits
ENTITY ULA IS
    PORT ( A, B: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
           ALU_Op: IN STD_LOGIC;
           Result: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
           Zero: OUT STD_LOGIC;
           --Overflow: OUT STD_LOGIC 
        );
END ULA;

ARCHITECTURE Behavior OF ULA IS

    SIGNAL s_B_inverted: STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL s_B_mux: STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL s_cin: STD_LOGIC;
    SIGNAL s_resultAdder: STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL s_cout: STD_LOGIC;

BEGIN
    
    s_B_inverted <= NOT B;
    s_cin <= ALU_Op;

    -- Define qual valor de B será usado no somador (0 para soma, 1 para subtração)
    s_B_mux <= B WHEN ALU_Op = '0' ELSE s_B_inverted;

    inst_Adder: Adder PORT MAP (A => A, B => s_B_mux, Cin => s_cin, S => s_resultAdder, Cout => s_cout);

    Result <= s_resultAdder;

    -- Define os sinais de Zero e Overflow
    Zero <= '1' WHEN s_resultAdder = "0000000000000000" ELSE '0';
    --Overflow <= (A(15) XNOR s_B_mux(15)) AND (s_resultAdder(15) XOR A(15));

END Behavior;