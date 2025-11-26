LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.package_components.all;

--Entidade do Registrador ID/EX
ENTITY Reg_ID_EX IS
    PORT (
        Clk: IN STD_LOGIC;
        Flush: IN STD_LOGIC;
        
        -- Inputs
        --Sinais de Controle (EX)
        RegDst_In: IN STD_LOGIC;
        ALUsrc_In: IN STD_LOGIC;
        ALUop_In: IN STD_LOGIC;
        
        --Sinais de Controle (MEM)
        Branch_In: IN STD_LOGIC;
        MemRead_In: IN STD_LOGIC;
        MemWrite_In: IN STD_LOGIC;

        --Sinais de Controle (WB)
        RegWrite_In: IN STD_LOGIC;
        MemtoReg_In: IN STD_LOGIC;


        -- Dados
        ReadData1_In: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        ReadData2_In: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        SignExt_In: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        PCplus2_In: IN STD_LOGIC_VECTOR(15 DOWNTO 0);

        --Endereços
        --Rs_In: IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- só para forwarding
        Rt_In: IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- só para forwarding
        Rd_In: IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- só para forwarding


        -- Outputs
        --Sinais de Controle (EX)
        RegDst_Out: OUT STD_LOGIC;
        ALUsrc_Out: OUT STD_LOGIC;
        ALUop_Out: OUT STD_LOGIC;
        
        --Sinais de Controle (MEM)
        Branch_Out: OUT STD_LOGIC;
        MemRead_Out: OUT STD_LOGIC;
        MemWrite_Out: OUT STD_LOGIC;

        --Sinais de Controle (WB)
        RegWrite_Out: OUT STD_LOGIC;
        MemtoReg_Out: OUT STD_LOGIC;
        --Dados
        ReadData1_Out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        ReadData2_Out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        SignExt_Out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        PCplus2_Out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);

        --Endereços
        --Rs_Out: IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- só para forwarding
        Rt_Out: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- só para forwarding
        Rd_Out: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)  -- só para forwarding
    );
END Reg_ID_EX;

ARCHITECTURE Behavior OF Reg_ID_EX IS
BEGIN
    --Sinais (1 bit)
    --EX
    Reg_RegDst: Registrador 
        GENERIC MAP (N => 1)
        PORT MAP (d_InReg(0) => RegDst_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg(0) => RegDst_Out);

    Reg_ALUSrc: Registrador 
        GENERIC MAP (N => 1)
        PORT MAP (d_InReg(0) => ALUsrc_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg(0) => ALUsrc_Out);
    
    Reg_ALUop: Registrador 
        GENERIC MAP (N => 1)
        PORT MAP (d_InReg(0) => ALUop_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg(0) => ALUop_Out);
    
    --MEM
    Reg_Branch: Registrador 
        GENERIC MAP (N => 1)
        PORT MAP (d_InReg(0) => Branch_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg(0) => Branch_Out);

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
    Reg_ReadData1: Registrador 
        GENERIC MAP (N => 16)
        PORT MAP (d_InReg => ReadData1_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg => ReadData1_Out);

    Reg_ReadData2: Registrador 
        GENERIC MAP (N => 16)
        PORT MAP (d_InReg => ReadData2_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg => ReadData2_Out);

    Reg_SignExt: Registrador 
        GENERIC MAP (N => 16)
        PORT MAP (d_InReg => SignExt_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg => SignExt_Out);
    
    Reg_PCplus2: Registrador 
        GENERIC MAP (N => 16)
        PORT MAP (d_InReg => PCplus2_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg => PCplus2_Out);


    --Endereços (4 bits)
    --Reg_Rs: Registrador 
    --    GENERIC MAP (N => 4)
    --    PORT MAP (d_InReg => Rs_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg => Rs_Out);

    Reg_Rt: Registrador 
        GENERIC MAP (N => 4)
        PORT MAP (d_InReg => Rt_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg => Rt_Out);

    Reg_Rd: Registrador 
        GENERIC MAP (N => 4)
        PORT MAP (d_InReg => Rd_In, En_Reg => '1', Clk => Clk, Reset => Flush, d_OutReg => Rd_Out);

END Behavior;