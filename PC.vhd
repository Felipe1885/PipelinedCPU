LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.package_components.all;

ENTITY PC IS
    PORT (
        Clk: IN STD_LOGIC;
        Reset: IN STD_LOGIC;
        --PCwrite: IN STD_LOGIC; -- colocar se for fazer tratamento de hazard de controle
        PC_In: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        PC_Out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END PC;
ARCHITECTURE Behavior OF PC IS
BEGIN
    PC_inst: Registrador 
        GENERIC MAP (N => 16)
        PORT MAP (d_InReg => PC_In, En_Reg => '1', Clk => Clk, Reset => Reset, d_OutReg => PC_Out);
END Behavior;