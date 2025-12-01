LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.package_components.all;

-- Entidade da CPU Pipelined de 16 bits
ENTITY CPU IS
    PORT (  SW: in STD_LOGIC_VECTOR(17 DOWNTO 0);
            KEY: in STD_LOGIC_VECTOR(3 DOWNTO 0);
            LEDR: out STD_LOGIC_VECTOR(17 DOWNTO 0);
            LEDG: out STD_LOGIC_VECTOR(7 DOWNTO 0);
            CLOCK_50: IN STD_LOGIC;
            HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: OUT STD_LOGIC_VECTOR(0 TO 6)
        );
END CPU;

ARCHITECTURE Behavior OF CPU IS
    -- Sinais globais
        signal Clk, Reset: STD_LOGIC;


    -- Sinais internos (IF)
        -- Dados
        signal PC_In, PC_Out, PCplus2, Instruction_IF: STD_LOGIC_VECTOR(15 DOWNTO 0);


    -- Sinais internos (ID)
        -- Dados
        signal PCplus2_ID, Instruction_ID, ReadData1_ID, ReadData2_ID, SignExt_ID: STD_LOGIC_VECTOR(15 DOWNTO 0);
        -- Controle
        signal Branch_ID, MemWrite_ID, MemRead_ID, MemtoReg_ID, RegWrite_ID, RegDst_ID, ALUsrc_ID, ALUop_ID, Jump_ID: STD_LOGIC;
        -- Endereços


    -- Sinais internos (EX)
        -- Dados
        signal PCplus2_EX, ReadData1_EX, ReadData2_EX, SignExt_EX, ALUout_EX, Mux_Forwarding_A, Mux_ULA_B, MUX_Forwarding_B, BranchAddr_EX: STD_LOGIC_VECTOR(15 DOWNTO 0);
        -- Controle
        signal RegDst_EX, ALUsrc_EX, ALUop_EX, Branch_EX, MemRead_EX, MemWrite_EX, RegWrite_EX, MemtoReg_EX, Zero_EX: STD_LOGIC;
        -- Endereços
        signal Rdest_EX: STD_LOGIC_VECTOR(3 DOWNTO 0);

        
        -- Sinais internos (MEM)
        -- Dados
        signal WriteData_MEM, BranchAddr_MEM, ALUout_MEM, ReadData_MEM: STD_LOGIC_VECTOR(15 DOWNTO 0);
        -- Controle
        signal Branch_MEM, Zero_MEM, MemRead_MEM, MemWrite_MEM, RegWrite_MEM, MemtoReg_MEM: STD_LOGIC;
        -- Endereços
        signal Rdest_MEM, Rs_EX, Rt_EX, Rd_EX: STD_LOGIC_VECTOR(3 DOWNTO 0);
        
        
        -- Sinais internos (WB)
        -- Dados
        signal WriteData_WB, ReadData_WB, ALUout_WB, Data_WB: STD_LOGIC_VECTOR(15 DOWNTO 0);
        -- Controle
        signal RegWrite_WB, MemtoReg_WB: STD_LOGIC;
        -- Endereços
        signal Rdest_WB: STD_LOGIC_VECTOR(3 DOWNTO 0);
        
        --Sinais extras
        signal PCsrc: STD_LOGIC;
        signal JMP_Address: STD_LOGIC_VECTOR(15 DOWNTO 0);
        signal PC_MUX: STD_LOGIC_VECTOR(1 DOWNTO 0);
        signal Jump_Target: STD_LOGIC_VECTOR(12 downto 0);
        signal ForwardA, ForwardB: STD_LOGIC_VECTOR(1 DOWNTO 0);

        -- Sinais dos Displays de 7 Segmentos
        signal Disp0, Disp1, Disp2, Disp3, Disp4, Disp5, Disp6, Disp7: STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
		  
    PC_inst: PC 
        PORT MAP (
		Clk => Clk,
                Reset => Reset,
                PC_In => PC_In,
                PC_Out => PC_Out
        );
    
    InstructionMemory_inst: InstructionMemory
        PORT MAP (
                Address => PC_Out,
                Instruction => Instruction_IF
        );
    
    Adder_PC_inst: Adder 
        PORT MAP (
                A => PC_Out,
                B => "0000000000000010",
                Cin => '0',
                S => PCplus2,
                Cout => OPEN
        );
    
    Reg_IF_ID_inst: Reg_IF_ID 
        PORT MAP(
                Clk => Clk,
                Flush => Reset,
                --WriteEn => '1',
                Instruction_In => Instruction_IF,
                PCplus2_In => PCplus2,
                Instruction_Out => Instruction_ID,
                PCplus2_Out => PCplus2_ID
        );
    
    RegisterBank_inst: RegisterBank 
        PORT MAP(
                RegWrite => RegWrite_WB,
                Clk => Clk,
                Reset => Reset,
                ReadReg1 => Instruction_ID(12 DOWNTO 9),  -- rs
                ReadReg2 => Instruction_ID(8 DOWNTO 5),   -- rt
                WriteReg => Rdest_WB,
                WriteData => Data_WB,
                ReadData1 => ReadData1_ID,
                ReadData2 => ReadData2_ID
        );
    
    UC_inst: UC 
        PORT MAP(
                OpCode => Instruction_ID(15 DOWNTO 13),
                Funct => Instruction_ID(0),
                Branch => Branch_ID,
                MemWrite => MemWrite_ID,
                MemRead => MemRead_ID,
                MemToReg => MemToReg_ID,
                RegWrite => RegWrite_ID,
                RegDst => RegDst_ID,
                ALUsrc => ALUsrc_ID,
                ALUop => ALUop_ID,
                Jump => Jump_ID
        );

    SignExtend_inst: SignExt
        PORT MAP (
                DataIn => Instruction_ID(4 DOWNTO 0),
                DataOut => SignExt_ID
        );

        
    Reg_ID_EX_inst: Reg_ID_EX 
        PORT MAP (
                -- Inputs
                Clk => Clk,
                Flush => Reset,
                RegDst_In => RegDst_ID,
                ALUsrc_In => ALUsrc_ID,
                ALUop_In => ALUop_ID,
                Branch_In => Branch_ID,
                MemRead_In => MemRead_ID,
                MemWrite_In => MemWrite_ID,
                RegWrite_In => RegWrite_ID,
                MemtoReg_In => MemtoReg_ID,
                ReadData1_In => ReadData1_ID,
                ReadData2_In => ReadData2_ID,
                SignExt_In => SignExt_ID,
                PCplus2_In => PCplus2_ID,
                Rs_In => Instruction_ID(12 DOWNTO 9),
                Rt_In => Instruction_ID(8 DOWNTO 5),
                Rd_In => Instruction_ID(4 DOWNTO 1),

                -- Outputs
                RegDst_Out => RegDst_EX,
                ALUsrc_Out => ALUsrc_EX,
                ALUop_Out => ALUop_EX,
                Branch_Out => Branch_EX,
                MemRead_Out => MemRead_EX,
                MemWrite_Out => MemWrite_EX,
                RegWrite_Out => RegWrite_EX,
                MemtoReg_Out => MemtoReg_EX,
                ReadData1_Out => ReadData1_EX,
                ReadData2_Out => ReadData2_EX,
                SignExt_Out => SignExt_EX,
                PCplus2_Out => PCplus2_EX,
                Rs_Out => Rs_EX,
                Rt_Out => Rt_EX,
                Rd_Out => Rd_EX 
        );

    ForwardingUnit_inst: ForwardingUnit
        PORT MAP (
                Rs_EX => Rs_EX,
                Rt_EX => Rt_EX,
                Rdest_MEM => Rdest_MEM,
                Rdest_WB => Rdest_WB,
                RegWrite_MEM => RegWrite_MEM,
                RegWrite_WB => RegWrite_WB,
                ForwardA => ForwardA,
                ForwardB => ForwardB
        );

    ULA_inst: ULA 
        PORT MAP (
                A => Mux_Forwarding_A,
                B => Mux_ULA_B,
                ALU_Op => ALUop_EX,
                Result => ALUout_EX,
                Zero => Zero_EX
        );
        
    Adder_Branch_inst: Adder 
        PORT MAP (
                A => PCplus2_EX,
                B => SignExt_EX(14 DOWNTO 0) & "0",
                Cin => '0',
                S => BranchAddr_EX,
                Cout => OPEN
        );       
                
    Reg_EX_MEM_inst: Reg_EX_MEM
        PORT MAP(
                -- Inputs
                Clk => Clk,
                Flush => Reset,
                Branch_In => Branch_EX,
                Zero_In => Zero_EX,
                MemRead_In => MemRead_EX,
                MemWrite_In => MemWrite_EX,
                RegWrite_In => RegWrite_EX,
                MemtoReg_In => MemtoReg_EX,
                BranchAddr_In => BranchAddr_EX,
                ALUout_In => ALUout_EX,
                WriteData_In => ReadData2_EX,
                Rdest_In => Rdest_EX,
                
                -- Outputs
                Branch_Out => Branch_MEM,
                Zero_Out => Zero_MEM,
                MemRead_Out => MemRead_MEM,
                MemWrite_Out => MemWrite_MEM,
                RegWrite_Out => RegWrite_MEM,
                MemtoReg_Out => MemtoReg_MEM,
                BranchAddr_Out => BranchAddr_MEM,
                ALUout_Out => ALUout_MEM,
                WriteData_Out => WriteData_MEM,
                Rdest_Out => Rdest_MEM
        );
                
    DataMemory_inst: DataMemory 
        PORT MAP (
                Address => ALUout_MEM,
                WriteData => WriteData_MEM,
                MemWrite => MemWrite_MEM,
                MemRead => MemRead_MEM,
                Clk => Clk,
                ReadData => ReadData_MEM
            );

    Reg_MEM_WB_inst: Reg_MEM_WB
        PORT MAP(
                -- Inputs
                Clk => Clk,
                Flush => Reset,
                RegWrite_In => RegWrite_MEM,
                MemtoReg_In => MemtoReg_MEM,
                ReadData_In => ReadData_MEM,
                ALUout_In => ALUout_MEM,
                Rdest_In => Rdest_MEM,

                -- Outputs
                RegWrite_Out => RegWrite_WB,
                MemtoReg_Out => MemtoReg_WB,
                ReadData_Out => ReadData_WB,
                ALUout_Out => ALUout_WB,
                Rdest_Out => Rdest_WB
        );


-- Clock e Reset
    Reset <= NOT KEY(3);
    inst_Debouncer: Debouncing_Button_VHDL PORT MAP (NOT KEY(0), CLOCK_50, Clk);

-- Sinais para os MUXes
    Jump_Target <= Instruction_ID(12 downto 0);
    JMP_Address <= PCplus2_ID(15 downto 13) & Jump_Target;
    PCsrc <= (Branch_MEM)AND(Zero_MEM);
    PC_MUX <= Jump_ID & PCsrc;

-- MUXes
    WITH PC_MUX SELECT
        PC_In <= BranchAddr_MEM WHEN "01",
        JMP_Address WHEN "10",
	    PCplus2 WHEN OTHERS;

    WITH RegDst_EX SELECT
        Rdest_EX <= Rt_EX WHEN '0',
	    Rd_EX WHEN OTHERS;

    WITH ALUsrc_EX SELECT
        Mux_ULA_B <= MUX_Forwarding_B WHEN '0',
	    SignExt_EX WHEN OTHERS;

    WITH MemtoReg_WB SELECT
        Data_WB <= ReadData_WB WHEN '1',
	    ALUout_WB WHEN OTHERS;

    WITH ForwardA SELECT
        MUX_Forwarding_A <= ALUout_MEM WHEN "10",
        Data_WB WHEN "01",
        ReadData1_EX WHEN OTHERS;

    WITH ForwardB SELECT
        MUX_Forwarding_B <= ALUout_MEM WHEN "10",
        Data_WB WHEN "01",
        ReadData2_EX WHEN OTHERS;

    Disp7 <= MUX_Forwarding_A(3 DOWNTO 0);
    Disp6 <= Mux_ULA_B(3 DOWNTO 0);
    Disp5 <= ALUout_MEM(3 DOWNTO 0);
    Disp4 <= WriteData_MEM(3 DOWNTO 0);
    Disp3 <= ReadData_MEM(3 DOWNTO 0);
    Disp2 <= Data_WB(3 DOWNTO 0);
    Disp1 <= Rdest_WB;
	 Disp0 <= '0' & Instruction_ID(15 DOWNTO 13);

-- PORT MAP dos displays 7 segmentos
    Display_OPcode: Display7segs PORT MAP(num => Disp0, seg => HEX0);
    Display_MuxForwarding_A: Display7segs PORT MAP(num => Disp7, seg => HEX7);
    Display_MuxULA_B: Display7segs PORT MAP(num => Disp6, seg => HEX6);
    Display_ALUout: Display7segs PORT MAP(num => Disp5, seg => HEX5);
	Display_WriteData_MEM: Display7segs PORT MAP(num => Disp4, seg => HEX4);
    Display_ReadDataMem: Display7segs PORT MAP(num => Disp3, seg => HEX3);
    Display_DataWB: Display7segs PORT MAP(num => Disp2, seg => HEX2);
    Display_RdestWB: Display7segs PORT MAP(num => Disp1, seg => HEX1);


-- LEDS Vermelhos
    LEDR(17 DOWNTO 10) <= PC_Out(7 DOWNTO 0);
    LEDR(9) <= '0';
    LEDR(8) <= ALUop_ID;
    LEDR(7) <= ALUsrc_ID;
    LEDR(6) <= RegDst_ID;
    LEDR(5) <= RegWrite_ID;
    LEDR(4) <= MemtoReg_ID;
    LEDR(3) <= MemRead_ID;
    LEDR(2) <= MemWrite_ID;
    LEDR(1) <= Branch_ID;
    LEDR(0) <= Jump_ID;

-- LEDS Verdes
    LEDG(0) <= PCsrc;
    LEDG(2) <= Instruction_ID(0) WHEN (Instruction_ID(15 DOWNTO 13) = "011") ELSE '0';
    LEDG(4) <= '1' WHEN (ForwardA /= "00" OR ForwardB /= "00") ELSE '0';
END Behavior;
