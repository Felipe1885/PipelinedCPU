LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.package_components.all;

-- Entidade da Unidade de Encaminhamento
ENTITY ForwardingUnit IS
    PORT (
        Rs_EX: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Rt_EX: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Rdest_MEM: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Rdest_WB: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        RegWrite_MEM: IN STD_LOGIC;
        RegWrite_WB: IN STD_LOGIC;
        ForwardA: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        ForwardB: OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ForwardingUnit;

ARCHITECTURE Behavior OF ForwardingUnit IS
BEGIN

    ForwardA <= "10" WHEN (RegWrite_MEM = '1' AND Rs_EX = Rdest_MEM) ELSE "01" WHEN (RegWrite_WB = '1' AND Rs_EX = Rdest_WB) ELSE "00";
    ForwardB <= "10" WHEN (RegWrite_MEM = '1' AND Rt_EX = Rdest_MEM) ELSE "01" WHEN (RegWrite_WB = '1' AND Rt_EX = Rdest_WB) ELSE "00";

END Behavior;