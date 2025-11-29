LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.package_components.all;

--Entidade do Registrador MEM/WB
ENTITY Reg_MEM_WB IS
    PORT (
        Clk: IN STD_LOGIC;
        Flush: IN STD_LOGIC;

        --Inputs
        --Sinais de Controle (WB)
        RegWrite_In: IN STD_LOGIC;
        MemtoReg_In: IN STD_LOGIC;

        --Dados
        ReadData_In: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        ALUout_In: IN STD_LOGIC_VECTOR(15 DOWNTO 0);

        --Endereços
        Rdest_In: IN STD_LOGIC_VECTOR (3 DOWNTO 0);             --rt ou rd


        --Outputs
        --Sinais de Controle (WB)
        RegWrite_Out: OUT STD_LOGIC;
        MemtoReg_Out: OUT STD_LOGIC;

        --Dados
        ReadData_Out: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
        ALUout_Out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);

        --Endereços
        Rdest_Out: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)             --rt ou rd

    );
END Reg_MEM_WB;
ARCHITECTURE Behavior OF Reg_MEM_WB IS
BEGIN
    --Sinais (1 bit)
    --WB
    Reg_RegWrite: Registrador 
        GENERIC MAP (N => 1)
        PORT MAP (d_InReg(0) => RegWrite_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg(0) => RegWrite_Out);

    Reg_MemtoReg: Registrador 
        GENERIC MAP (N => 1)
        PORT MAP (d_InReg(0) => MemtoReg_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg(0) => MemtoReg_Out);
    --Dados (16 bits)
    Reg_ReadData: Registrador 
        GENERIC MAP (N => 16)
        PORT MAP (d_InReg => ReadData_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg => ReadData_Out);

    Reg_ALUout: Registrador 
        GENERIC MAP (N => 16)
        PORT MAP (d_InReg => ALUout_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg => ALUout_Out);

    --Endereços (4 bits)
    Reg_Rdest: Registrador 
        GENERIC MAP (N => 4)
        PORT MAP (d_InReg => Rdest_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg => Rdest_Out);

END Behavior;