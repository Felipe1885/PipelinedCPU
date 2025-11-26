LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Package para os componentes do projeto
PACKAGE package_components IS

    -- Componente do Full Adder
    COMPONENT FullAdder IS
        PORT (A, B: IN STD_LOGIC;
              S: OUT STD_LOGIC;
              CIN: IN STD_LOGIC;
              COUT: OUT STD_LOGIC
        );
    END COMPONENT;


    -- Componente do Adder
    COMPONENT Adder IS
        PORT (A, B: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
              Cin : IN STD_LOGIC;
              S: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
              Cout: OUT STD_LOGIC
        );
    END COMPONENT;


    -- Componente da ULA
    COMPONENT ULA IS
        PORT ( A, B: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
               ALU_Op: IN STD_LOGIC;
               Result: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
               Zero: OUT STD_LOGIC;
            );
    END COMPONENT;


    -- Componente do Comparador
    COMPONENT Comparator IS
        PORT ( A, B: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
               Equal: OUT STD_LOGIC
            );
    END COMPONENT;


    -- Componente da UC
    COMPONENT UC IS
        PORT( OpCode: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
              Funct: IN STD_LOGIC;
              Branch, MemWrite, MemRead, MemtoReg, RegWrite, RegDst, ALUsrc, ALUop, Jump: OUT STD_LOGIC
        );
    END COMPONENT;


    -- Componente do PC
    COMPONENT PC IS
        PORT (
            Clk: IN STD_LOGIC;
            Reset: IN STD_LOGIC;
            --PCwrite: IN STD_LOGIC; -- colocar se for fazer tratamento de hazard de controle
            PC_In: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            PC_Out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    
    -- Componente do Registrador
    COMPONENT Registrador IS
        GENERIC (
            N: INTEGER := 16
        );
        PORT ( d_InReg : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
               En_Reg, Clk : IN STD_LOGIC;
               Reset: IN STD_LOGIC;
               d_OutReg : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
            );
    END COMPONENT;


    -- Componente do Banco de Registradores
    COMPONENT RegisterBank IS
        PORT ( 
            RegWrite: IN  STD_LOGIC;
            Clk: IN  STD_LOGIC;
            Reset: IN  STD_LOGIC;
            ReadReg1: IN  STD_LOGIC_VECTOR(3 DOWNTO 0);     -- rs
            ReadReg2: IN  STD_LOGIC_VECTOR(3 DOWNTO 0);     -- rt
            WriteReg: IN  STD_LOGIC_VECTOR(3 DOWNTO 0);     -- rd
            WriteData: IN  STD_LOGIC_VECTOR(15 DOWNTO 0);   -- dado que vai ser escrito no registrador
            ReadData1: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);   -- dado lido do registrador rs
            ReadData2: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)    -- dado lido do registrador rt
        );
    END COMPONENT;


    -- Componente do Registrador IF/ID
    COMPONENT Reg_IF_ID IS
        PORT (
            Clk: IN STD_LOGIC;
            Flush: IN STD_LOGIC;

            --Inputs
            Instruction_In: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            PCplus2_In: IN STD_LOGIC_VECTOR(15 DOWNTO 0);

            --Outputs
            Instruction_Out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
            PCplus2_Out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        );
    END COMPONENT;


    -- Componente do Registrador ID/EX
    COMPONENT Reg_ID_EX IS
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
            Rs_In: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Rt_In: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Rd_In: IN STD_LOGIC_VECTOR(3 DOWNTO 0);


            -- Outputs
            --Sinais de Controle (EX)
            RegDst_Out: IN STD_LOGIC;
            ALUsrc_Out: IN STD_LOGIC;
            ALUop_Out: IN STD_LOGIC;
        
            --Sinais de Controle (MEM)
            Branch_Out: IN STD_LOGIC;
            MemRead_Out: IN STD_LOGIC;
            MemWrite_Out: IN STD_LOGIC;

            --Sinais de Controle (WB)
            RegWrite_Out: IN STD_LOGIC;
            MemtoReg_Out: IN STD_LOGIC;

            --Dados
            ReadData1_Out: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            ReadData2_Out: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            SignExt_Out: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            PCplus2_Out: IN STD_LOGIC_VECTOR(15 DOWNTO 0);

            --Endereços
            Rs_Out: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Rt_Out: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Rd_Out: IN STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;


    -- Componente do Registrador EX/MEM
    COMPONENT Reg_EX_MEM IS
        PORT (
            Clk: IN STD_LOGIC;
            Flush: IN STD_LOGIC;

            --Inputs
            --Sinais de Controle (MEM)
            Branch_In: IN STD_LOGIC;
            Zero_In: IN STD_LOGIC;
            MemRead_In: IN STD_LOGIC;
            MemWrite_In: IN STD_LOGIC;

            --Sinais de Controle (WB)
            RegWrite_In: IN STD_LOGIC;
            MemtoReg_In: IN STD_LOGIC;

            --Dados
            BranchAddr_In: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            ALUout_In: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            WriteData_In: IN STD_LOGIC_VECTOR(15 DOWNTO 0);

            --Endereços
            Rdest_In: IN STD_LOGIC_VECTOR(3 DOWNTO 0);             --rt ou rd


            --Outputs
            --Sinais de Controle (MEM)
            Branch_Out: OUT STD_LOGIC;
            Zero_Out: OUT STD_LOGIC;
            MemRead_Out: OUT STD_LOGIC;
            MemWrite_Out: OUT STD_LOGIC;

            --Sinais de Controle (WB)
            RegWrite_Out: OUT STD_LOGIC;
            MemtoReg_Out: OUT STD_LOGIC;

            --Dados
            BranchAddr_Out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            ALUout_Out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            WriteData_Out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);

            --Endereços
            Rdest_Out: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)             --rt ou rd
        );
    END COMPONENT;


    -- Componente do Registrador MEM/WB
    COMPONENT Reg_MEM_WB IS
        PORT (
            Clk: IN STD_LOGIC;
            Flush: IN STD_LOGIC;

            --Inputs
            --Sinais de Controle (WB)
            RegWrite_in: IN STD_LOGIC;
            MemtoReg_in: IN STD_LOGIC;

            --Dados
            ReadData_In: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            ALUout_In: IN STD_LOGIC_VECTOR(15 DOWNTO 0);

            --Endereços
            Rdest_In: IN STD_LOGIC_VECTOR (3 DOWNTO 0);             --rt ou rd


            --Outputs
            --Sinais de Controle (WB)
            RegWrite_out: OUT STD_LOGIC;
            MemtoReg_out: OUT STD_LOGIC;

            --Dados
            ReadData_Out: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            ALUout_Out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);

            --Endereços
            Rdest_Out: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);             --rt ou rd
        );
    END COMPONENT;


    -- Componente da Memória de Dados
    COMPONENT DataMemory IS
        PORT ( Address, WriteData: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            MemWrite, MemRead, CLK: IN STD_LOGIC;
            ReadData: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
            );
    END COMPONENT;  


    -- Componente da Memória de Instruções
    COMPONENT InstructionMemory IS
        PORT ( Address: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
               Instruction: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
            );
    END COMPONENT;


    -- Componente do Extensor de Sinal
    COMPONENT SignExt IS
        PORT ( DataIn: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
               DataOut: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
            );
    END COMPONENT;

END PACKAGE package_components;