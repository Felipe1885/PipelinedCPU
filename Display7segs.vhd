LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Entidade do display de 7 segmentos
ENTITY Display7segs IS
    PORT (
        num : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        seg : OUT STD_LOGIC_VECTOR(0 TO 6)
    );
END Display7segs;

ARCHITECTURE Behavior OF Display7segs IS
BEGIN
    PROCESS(num)
    BEGIN
        CASE num IS
            WHEN "0000" => seg <= "0000001"; -- 0
            WHEN "0001" => seg <= "1001111"; -- 1
            WHEN "0010" => seg <= "0010010"; -- 2
            WHEN "0011" => seg <= "0000110"; -- 3
            WHEN "0100" => seg <= "1001100"; -- 4
            WHEN "0101" => seg <= "0100100"; -- 5
            WHEN "0110" => seg <= "0100000"; -- 6
            WHEN "0111" => seg <= "0001111"; -- 7
            WHEN "1000" => seg <= "0000000"; -- 8
            WHEN "1001" => seg <= "0000100"; -- 9
            WHEN "1010" => seg <= "0001000"; -- A
            WHEN "1011" => seg <= "1100000"; -- b
            WHEN "1100" => seg <= "0110001"; -- C
            WHEN "1101" => seg <= "1000010"; -- d
            WHEN "1110" => seg <= "0110000"; -- E
            WHEN "1111" => seg <= "0111000"; -- F
            WHEN OTHERS => seg <= "1111111"; -- Apaga o display
        END CASE;
    END PROCESS;
END Behavior;