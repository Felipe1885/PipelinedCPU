LIBRARY ieee;
USE ieee.std_logic_1164.all ;
USE work.package_components.all;

--Entidade do Extensor de Sinal
ENTITY SignExt IS
    PORT ( DataIn :IN STD_LOGIC_VECTOR(4 DOWNTO 0);
           DataOut :OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
         );
END ENTITY SignExt;

ARCHITECTURE Behavior OF SignExt IS
BEGIN

    DataOut(4 DOWNTO 0) <= DataIn;                  --Copia para os 5 bits menos significativos
    DataOut(15 DOWNTO 5) <= (OTHERS => DataIn(4));  --Extende o sinal copiando o bit mais significativo

END Behavior;