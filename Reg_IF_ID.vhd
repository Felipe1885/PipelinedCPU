LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.package_components.all;

ENTITY Reg_IF_ID IS
    PORT (
        Clk: IN STD_LOGIC;
        Flush: IN STD_LOGIC;    --IF.Flush
        WriteEn: IN STD_LOGIC;   --IF/IDWrite

        -- Inputs
        Instruction_In: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        PCplus4_In: IN STD_LOGIC_VECTOR(15 DOWNTO 0);   

        -- Outputs
        Instruction_Out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        PCplus4_Out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)    
    );
END Reg_IF_ID;

ARCHITECTURE Behavior OF Reg_IF_ID IS
BEGIN

    Reg_Instruction: Registrador GENERIC MAP (N => 16) PORT MAP (d_InReg => Instruction_In, En_Reg => WriteEn, Clk => Clk, Reset => Flush, d_OutReg => Instruction_Out);
    Reg_PCplus4: Registrador GENERIC MAP (N => 16) PORT MAP (d_InReg => PCplus4_In, En_Reg => WriteEn, Clk => Clk, Reset => Flush, d_OutReg => PCplus4_Out);

END Behavior;