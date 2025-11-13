LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.package_components.all;

-- Entidade do comparador de 16 bits
ENTITY Comparator IS
    PORT ( A, B: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            Equal: OUT STD_LOGIC
        );
END Comparator;

ARCHITECTURE Behavior OF Comparator IS
    BEGIN
        Equal <= '1' WHEN A = B ELSE '0';

END Behavior;