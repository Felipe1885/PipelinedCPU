LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.package_components.all;

ENTITY Reg_EX_MEM IS
    PORT (
        Clk: IN STD_LOGIC;
        Flush: IN STD_LOGIC;

        --Inputs
        --Sinais de Controle (MEM)
        MemRead_In: IN STD_LOGIC;
        MemWrite_In: IN STD_LOGIC;

        --Sinais de Controle (WB)
        RegWrite_In: IN STD_LOGIC;
        MemtoReg_In: IN STD_LOGIC;

        --Dados
        ALUout_In: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        WriteData_In: IN STD_LOGIC_VECTOR(15 DOWNTO 0);

        --Endereços
        Rdest_In: IN STD_LOGIC_VECTOR(3 DOWNTO 0);             --rt ou rd


        --Outputs
        --Sinais de Controle (MEM)
        MemRead_Out: OUT STD_LOGIC;
        MemWrite_Out: OUT STD_LOGIC;

        --Sinais de Controle (WB)
        RegWrite_Out: OUT STD_LOGIC;
        MemtoReg_Out: OUT STD_LOGIC;

        --Dados
        ALUout_Out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        WriteData_Out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);

        --Endereços
        Rdest_Out: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)             --rt ou rd
    );
END Reg_EX_MEM;

ARCHITECTURE Behavior OF Reg_EX_MEM IS
BEGIN
    --Sinais (1 bit)
    --MEM
    Reg_MemRead: Registrador 
        GENERIC MAP (N => 1)
        PORT MAP (d_InReg(0) => MemRead_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg(0) => MemRead_Out);

    Reg_MemWrite: Registrador 
        GENERIC MAP (N => 1)
        PORT MAP (d_InReg(0) => MemWrite_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg(0) => MemWrite_Out);

    --WB
    Reg_RegWrite: Registrador 
        GENERIC MAP (N => 1)
        PORT MAP (d_InReg(0) => RegWrite_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg(0) => RegWrite_Out);

    Reg_MemtoReg: Registrador 
        GENERIC MAP (N => 1)
        PORT MAP (d_InReg(0) => MemtoReg_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg(0) => MemtoReg_Out);

    --Dados (16 bits)
    Reg_ALUout: Registrador 
        GENERIC MAP (N => 16)
        PORT MAP (d_InReg => ALUout_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg => ALUout_Out);

    Reg_WriteData: Registrador 
        GENERIC MAP (N => 16)
        PORT MAP (d_InReg => WriteData_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg => WriteData_Out);

    --Endereços (4 bits)
    Reg_Rdest: Registrador 
        GENERIC MAP (N => 4)
        PORT MAP (d_InReg => Rdest_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg => Rdest_Out);

END Behavior;