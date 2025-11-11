LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Package para os componentes do projeto
PACKAGE COMPONENTS IS

    -- Componente do Full Adder
    COMPONENT FA IS
        PORT (X, Y: IN STD_LOGIC;
            S: OUT STD_LOGIC;
            CIN: IN STD_LOGIC;
            COUT: OUT STD_LOGIC);
    END COMPONENT;

    -- Componente do Adder
    COMPONENT Adder IS
        PORT ( Cin : IN STD_LOGIC;
            X, Y : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            Cout : OUT STD_LOGIC );
    END COMPONENT;

    -- Componente do Registrador
    COMPONENT REG IS
        PORT ( DATA : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
                EN, Clk : IN STD_LOGIC;
                RESET: IN STD_LOGIC;
                DOUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;

    --Componente do Banco de Registradores
    COMPONENT RegBank IS 
        PORT ( RegWrite : IN STD_LOGIC;
            RR1, RR2, WD, WR : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            RD1, RD2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;

    --Componente do Comparador
    COMPONENT CMP
        PORT ( X: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            Y: IN STD_LOGIC_VECTOR (15 DOWNTO 0); 
            EQ: OUT STD_LOGIC;
            G: OUT STD_LOGIC;
            L: OUT STD_LOGIC);
    END COMPONENT;

    -- Componente da ULA
    COMPONENT ULA IS
        PORT ( OPCODE: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
            X: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            Y: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            RESULT: BUFFER STD_LOGIC_VECTOR (15 DOWNTO 0);
            ZERO: OUT STD_LOGIC;
            OVERFLOW: OUT STD_LOGIC;
            COUT: OUT STD_LOGIC);
    END COMPONENT;

END PACKAGE COMPONENTS;