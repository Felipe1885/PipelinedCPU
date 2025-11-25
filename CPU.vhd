LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.package_components.all;

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

signal ENABLE_PC, RESET_PC, REG_WRITE_BANK, RESET_REG_BANK, ULA_OP, ULA_ZERO, ADDER_PC_CARRY_OUT, ADDER_BRANCH_CARRY_OUT, UC_BRANCH, UC_MEM_WRITE, UC_MEM_READ, UC_MEM_TO_REG, UC_REG_WRITE, UC_REG_DST, UC_ULA_SRC, UC_ULA_OP, UC_JUMP, MEMORY_WRITE, MEMORY_READ, ID_RegDst, ID_ALUsrc, ID_ALUop, ID_Branch, ID_MemRead, ID_MemWrite, ID_RegWrite, ID_MemtoReg, ID_Jump, EX_RegDst, EX_ALUsrc, EX_ALUop, EX_Branch, EX_MemRead, EX_MemWrite, EX_RegWrite, EX_MemtoReg, EX_Zero, MEM_Branch, MEM_Zero, MEM_MemRead, MEM_MemWrite, MEM_RegWrite, MEM_MemtoReg, WB_RegWrite, WB_MemtoReg, Pipeline_Flush, PCSrc : STD_LOGIC;
signal REAF_REG_1_BANK, READ_REG_2_BANK, WRITE_REG_BANK, UC_OPCODE, UC_FUNCTION, ID_Rs, ID_Rt, ID_Rd, EX_Rs, EX_Rt, EX_Rd, EX_Rdest, MEM_Rdest, WB_Rdest : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal DATA_IN_PC, DATA_OUT_PC, WRITE_DATA_REG_BANK, READ_1_REG_BANK, READ_2_REG_BANK, SRC_ULA_A, SRC_ULA_B, ULA_RESULT, SRC_ADDER_PC_A, ADDER_PC_RESULT, SRC_ADDER_BRANCH_A, SRC_ADDER_BRANCH_B, ADDER_BRANCH_RESULT, INSTRUCTION_MEMORY_ADDRESS, INSTRUCTION_MEMORY_OUT, MEMORY_ADDRESS, MEMORY_WRITE_DATA, MEMORY_READ_DATA, IF_Instruction, IF_PCplus2, ID_Instruction, ID_PCplus2, ID_ReadData1, ID_ReadData2, ID_SignExt, EX_ReadData1, EX_ReadData2, EX_SignExt, EX_PCplus2, EX_ALUout, EX_BranchAddr, EX_WriteData, MEM_BranchAddr, MEM_ALUout, MEM_WriteData, MEM_ReadData, WB_ReadData, WB_ALUout, WB_WriteData, PC_plus_2, Shifted_Ext : STD_LOGIC_VECTOR(15 DOWNTO 0);

    Stage0: PC PORT MAP (CLK, ENABLE_PC = 1, RESET_PC, DATA_IN_PC, DATA_OUT_PC);
    Stage1: RegisterBank PORT MAP(REG_WRITE_BANK, CLK, RESET_REG_BANK, REAF_REG_1_BANK, READ_REG_2_BANK,WRITE_REG_BANK, WRITE_DATA_REG_BANK, READ_1_REG_BANK, READ_2_REG_BANK);
    Stage2: ULA PORT MAP(SRC_ULA_A, SRC_ULA_B, ULA_OP, ULA_RESULT, ULA_ZERO);
    Stage3: Adder PORT MAP(SRC_ADDER_PC_A, x"0002", x"0000", ADDER_PC_RESULT, ADDER_PC_CARRY_OUT); --ADDER PRO PC
    Stage4: Adder PORT MAP(SRC_ADDER_BRANCH_A, SRC_ADDER_BRANCH_B, x"0000", ADDER_BRANCH_RESULT, ADDER_BRANCH_CARRY_OUT);
    Stage5: UC PORT MAP(UC_OPCODE, UC_FUNCTION, UC_BRANCH, UC_MEM_WRITE, UC_MEM_READ, UC_MEM_TO_REG, UC_REG_WRITE, UC_REG_DST, UC_ULA_SRC, UC_ULA_OP, UC_JUMP);
    Stage6: InstructionMemory PORT MAP(INSTRUCTION_MEMORY_ADDRESS, INSTRUCTION_MEMORY_OUT);
    Stage7: Memory PORT MAP(MEMORY_ADDRESS, MEMORY_WRITE_DATA, MEMORY_WRITE, MEMORY_READ, CLK, MEMORY_READ_DATA);
    Stage8: Reg_IF_ID PORT MAP( CLK, Pipeline_Flush, IF_Instruction, IF_PCplus2, ID_Instruction, ID_PCplus2);
    Stage9: Reg_ID_EX PORT MAP( CLK, Pipeline_Flush, ID_RegDst, ID_ALUsrc, ID_ALUop, ID_Branch, ID_MemRead, ID_MemWrite, ID_RegWrite, ID_MemtoReg, ID_ReadData1, ID_ReadData2, ID_SignExt, ID_PCplus2, ID_Rs, ID_Rt, ID_Rd, EX_RegDst, EX_ALUsrc, EX_ALUop, EX_Branch, EX_MemRead, EX_MemWrite, EX_RegWrite, EX_MemtoReg, EX_ReadData1, EX_ReadData2, EX_SignExt, EX_PCplus2, EX_Rs, EX_Rt, EX_Rd );
    Stage10: Reg_EX_MEM PORT MAP( CLK, Pipeline_Flush, EX_Branch, EX_Zero, EX_MemRead, EX_MemWrite, EX_RegWrite, EX_MemtoReg, EX_BranchAddr, EX_ALUout, EX_WriteData, EX_Rdest, MEM_Branch, MEM_Zero, MEM_MemRead, MEM_MemWrite, MEM_RegWrite, MEM_MemtoReg, MEM_BranchAddr, MEM_ALUout, MEM_WriteData, MEM_Rdest );
    Stage11: Reg_MEM_WB PORT MAP( CLK, Pipeline_Flush,MEM_RegWrite, MEM_MemtoReg,MEM_ReadData, MEM_ALUout, MEM_Rdest, WB_RegWrite, WB_MemtoReg,WB_ReadData, WB_ALUout,WB_Rdest );

    WITH -- SELECT					
        HEX7 <= "0000001" WHEN "0000",
                "1001111" WHEN "0001",
                "0010010" WHEN "0010",
                "0000110" WHEN "0011",
                "1001100" WHEN "0100",
                "0100100" WHEN "0101",
                "0100000" WHEN "0110",
                "0001111" WHEN "0111",
                "0000000" WHEN "1000",
                "0000100" WHEN "1001",
                "0001000" WHEN "1010",
                "1100000" WHEN "1011",
                "0110001" WHEN "1100",
                "1000010" WHEN "1101",
                "0110000" WHEN "1110",
                "0111000" WHEN "1111",
                "1111111" WHEN OTHERS;
	 
	 WITH -- SELECT			
        HEX6 <= "0000001" WHEN "0000",
                "1001111" WHEN "0001",
                "0010010" WHEN "0010",
                "0000110" WHEN "0011",
                "1001100" WHEN "0100",
                "0100100" WHEN "0101",
                "0100000" WHEN "0110",
                "0001111" WHEN "0111",
                "0000000" WHEN "1000",
                "0000100" WHEN "1001",
                "0001000" WHEN "1010",
                "1100000" WHEN "1011",
                "0110001" WHEN "1100",
                "1000010" WHEN "1101",
                "0110000" WHEN "1110",
                "0111000" WHEN "1111",
                "1111111" WHEN OTHERS;
	 
	 WITH -- SELECT
        HEX5 <= "0000001" WHEN "0000",
                "1001111" WHEN "0001",
                "0010010" WHEN "0010",
                "0000110" WHEN "0011",
                "1001100" WHEN "0100",
                "0100100" WHEN "0101",
                "0100000" WHEN "0110",
                "0001111" WHEN "0111",
                "0000000" WHEN "1000",
                "0000100" WHEN "1001",
                "0001000" WHEN "1010",
                "1100000" WHEN "1011",
                "0110001" WHEN "1100",
                "1000010" WHEN "1101",
                "0110000" WHEN "1110",
                "0111000" WHEN "1111",
                "1111111" WHEN OTHERS;
	 
	 WITH -- SELECT	
        HEX4 <= "0000001" WHEN "0000",
                "1001111" WHEN "0001",
                "0010010" WHEN "0010",
                "0000110" WHEN "0011",
                "1001100" WHEN "0100",
                "0100100" WHEN "0101",
                "0100000" WHEN "0110",
                "0001111" WHEN "0111",
                "0000000" WHEN "1000",
                "0000100" WHEN "1001",
                "0001000" WHEN "1010",
                "1100000" WHEN "1011",
                "0110001" WHEN "1100",
                "1000010" WHEN "1101",
                "0110000" WHEN "1110",
                "0111000" WHEN "1111",
                "1111111" WHEN OTHERS;

    WITH -- SELECT
        HEX3 <= "0000001" WHEN "0000",
                "1001111" WHEN "0001",
                "0010010" WHEN "0010",
                "0000110" WHEN "0011",
                "1001100" WHEN "0100",
                "0100100" WHEN "0101",
                "0100000" WHEN "0110",
                "0001111" WHEN "0111",
                "0000000" WHEN "1000",
                "0000100" WHEN "1001",
                "0001000" WHEN "1010",
                "1100000" WHEN "1011",
                "0110001" WHEN "1100",
                "1000010" WHEN "1101",
                "0110000" WHEN "1110",
                "0111000" WHEN "1111",
                "1111111" WHEN OTHERS;

    WITH -- SELECT		
        HEX2 <= "0000001" WHEN "0000",
                "1001111" WHEN "0001",
                "0010010" WHEN "0010",
                "0000110" WHEN "0011",
                "1001100" WHEN "0100",
                "0100100" WHEN "0101",
                "0100000" WHEN "0110",
                "0001111" WHEN "0111",
                "0000000" WHEN "1000",
                "0000100" WHEN "1001",
                "0001000" WHEN "1010",
                "1100000" WHEN "1011",
                "0110001" WHEN "1100",
                "1000010" WHEN "1101",
                "0110000" WHEN "1110",
                "0111000" WHEN "1111",
                "1111111" WHEN OTHERS;

    WITH -- SELECT			
        HEX1 <= "0000001" WHEN "0000",
                "1001111" WHEN "0001",
                "0010010" WHEN "0010",
                "0000110" WHEN "0011",
                "1001100" WHEN "0100",
                "0100100" WHEN "0101",
                "0100000" WHEN "0110",
                "0001111" WHEN "0111",
                "0000000" WHEN "1000",
                "0000100" WHEN "1001",
                "0001000" WHEN "1010",
                "1100000" WHEN "1011",
                "0110001" WHEN "1100",
                "1000010" WHEN "1101",
                "0110000" WHEN "1110",
                "0111000" WHEN "1111",
                "1111111" WHEN OTHERS;
    WITH -- SELECT						
        HEX0 <= "0000001" WHEN "0000",
                "1001111" WHEN "0001",
                "0010010" WHEN "0010",
                "0000110" WHEN "0011",
                "1001100" WHEN "0100",
                "0100100" WHEN "0101",
                "0100000" WHEN "0110",
                "0001111" WHEN "0111",
                "0000000" WHEN "1000",
                "0000100" WHEN "1001",
                "0001000" WHEN "1010",
                "1100000" WHEN "1011",
                "0110001" WHEN "1100",
                "1000010" WHEN "1101",
                "0110000" WHEN "1110",
                "0111000" WHEN "1111",
                "1111111" WHEN OTHERS;
END Behavior;