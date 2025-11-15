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

    -- Componente da ULA
    COMPONENT ULA IS
        PORT ( A, B: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
               ALU_function: IN STD_LOGIC;
               Result: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
               Zero: OUT STD_LOGIC;
               Overflow: OUT STD_LOGIC
            );
    END COMPONENT;

    -- Componente do Comparador
    COMPONENT Comparator IS
        PORT ( A, B: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
               Equal: OUT STD_LOGIC
            );
    END COMPONENT;

END PACKAGE package_components;