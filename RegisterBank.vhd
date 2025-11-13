LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.package_components.all;

-- Banco de 16 registradores de 16 bits
ENTITY RegisterBank IS
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
END RegisterBank;

ARCHITECTURE Behavior OF RegisterBank IS
	
    -- Sinal para a saída dos registradores de 16 bits
	SIGNAL reg0  : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL reg1  : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL reg2  : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL reg3  : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL reg4  : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL reg5  : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL reg6  : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL reg7  : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL reg8  : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL reg9  : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL reg10 : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL reg11 : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL reg12 : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL reg13 : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL reg14 : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL reg15 : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');

	-- Enables de escrita dos registradores
	SIGNAL WriteEn0, WriteEn1, WriteEn2, WriteEn3, WriteEn4, WriteEn5, WriteEn6, WriteEn7 : STD_LOGIC := '0';
	SIGNAL WriteEn8, WriteEn9, WriteEn10, WriteEn11, WriteEn12, WriteEn13, WriteEn14, WriteEn15 : STD_LOGIC := '0';
		
BEGIN
	-- Decoder para os sinais de escrita dos registradores (estágio WB)
	WriteEn0  <= '1' WHEN (RegWrite = '1' AND WriteReg = "0000") ELSE '0'; -- reg $zero??? n sei
	WriteEn1  <= '1' WHEN (RegWrite = '1' AND WriteReg = "0001") ELSE '0';
	WriteEn2  <= '1' WHEN (RegWrite = '1' AND WriteReg = "0010") ELSE '0';
	WriteEn3  <= '1' WHEN (RegWrite = '1' AND WriteReg = "0011") ELSE '0';
	WriteEn4  <= '1' WHEN (RegWrite = '1' AND WriteReg = "0100") ELSE '0';
	WriteEn5  <= '1' WHEN (RegWrite = '1' AND WriteReg = "0101") ELSE '0';
	WriteEn6  <= '1' WHEN (RegWrite = '1' AND WriteReg = "0110") ELSE '0';
	WriteEn7  <= '1' WHEN (RegWrite = '1' AND WriteReg = "0111") ELSE '0';
	WriteEn8  <= '1' WHEN (RegWrite = '1' AND WriteReg = "1000") ELSE '0';
	WriteEn9  <= '1' WHEN (RegWrite = '1' AND WriteReg = "1001") ELSE '0';
	WriteEn10 <= '1' WHEN (RegWrite = '1' AND WriteReg = "1010") ELSE '0';
	WriteEn11 <= '1' WHEN (RegWrite = '1' AND WriteReg = "1011") ELSE '0';
	WriteEn12 <= '1' WHEN (RegWrite = '1' AND WriteReg = "1100") ELSE '0';
	WriteEn13 <= '1' WHEN (RegWrite = '1' AND WriteReg = "1101") ELSE '0';
	WriteEn14 <= '1' WHEN (RegWrite = '1' AND WriteReg = "1110") ELSE '0';
	WriteEn15 <= '1' WHEN (RegWrite = '1' AND WriteReg = "1111") ELSE '0';


	-- Port Map dos registradores para escrita neles (cada um escreve WriteData quando seu enable = '1')
	reg0_i: Registrador PORT MAP ( d_InReg => WriteData, En_Reg => WriteEn0,  Clk => Clk, Reset => Reset, d_OutReg => reg0 );
	reg1_i: Registrador PORT MAP ( d_InReg => WriteData, En_Reg => WriteEn1,  Clk => Clk, Reset => Reset, d_OutReg => reg1 );
	reg2_i: Registrador PORT MAP ( d_InReg => WriteData, En_Reg => WriteEn2,  Clk => Clk, Reset => Reset, d_OutReg => reg2 );
	reg3_i: Registrador PORT MAP ( d_InReg => WriteData, En_Reg => WriteEn3,  Clk => Clk, Reset => Reset, d_OutReg => reg3 );
	reg4_i: Registrador PORT MAP ( d_InReg => WriteData, En_Reg => WriteEn4,  Clk => Clk, Reset => Reset, d_OutReg => reg4 );
	reg5_i: Registrador PORT MAP ( d_InReg => WriteData, En_Reg => WriteEn5,  Clk => Clk, Reset => Reset, d_OutReg => reg5 );
	reg6_i: Registrador PORT MAP ( d_InReg => WriteData, En_Reg => WriteEn6,  Clk => Clk, Reset => Reset, d_OutReg => reg6 );
	reg7_i: Registrador PORT MAP ( d_InReg => WriteData, En_Reg => WriteEn7,  Clk => Clk, Reset => Reset, d_OutReg => reg7 );
	reg8_i: Registrador PORT MAP ( d_InReg => WriteData, En_Reg => WriteEn8,  Clk => Clk, Reset => Reset, d_OutReg => reg8 );
	reg9_i: Registrador PORT MAP ( d_InReg => WriteData, En_Reg => WriteEn9,  Clk => Clk, Reset => Reset, d_OutReg => reg9 );
	reg10_i: Registrador PORT MAP ( d_InReg => WriteData, En_Reg => WriteEn10, Clk => Clk, Reset => Reset, d_OutReg => reg10 );
	reg11_i: Registrador PORT MAP ( d_InReg => WriteData, En_Reg => WriteEn11, Clk => Clk, Reset => Reset, d_OutReg => reg11 );
	reg12_i: Registrador PORT MAP ( d_InReg => WriteData, En_Reg => WriteEn12, Clk => Clk, Reset => Reset, d_OutReg => reg12 );
	reg13_i: Registrador PORT MAP ( d_InReg => WriteData, En_Reg => WriteEn13, Clk => Clk, Reset => Reset, d_OutReg => reg13 );
	reg14_i: Registrador PORT MAP ( d_InReg => WriteData, En_Reg => WriteEn14, Clk => Clk, Reset => Reset, d_OutReg => reg14 );
	reg15_i: Registrador PORT MAP ( d_InReg => WriteData, En_Reg => WriteEn15, Clk => Clk, Reset => Reset, d_OutReg => reg15 );


	-- Mux para escolher qual registrador vai ser a saída do banco de registradores (estágio ID)
	with ReadReg1 select
		ReadData1 <= 
            reg0  when "0000",
			reg1  when "0001",
			reg2  when "0010",
			reg3  when "0011",
			reg4  when "0100",
			reg5  when "0101",
			reg6  when "0110",
			reg7  when "0111",
			reg8  when "1000",
			reg9  when "1001",
			reg10 when "1010",
			reg11 when "1011",
	    	reg12 when "1100",
			reg13 when "1101",
			reg14 when "1110",
			reg15 when others;

	with ReadReg2 select
		ReadData2 <= 
            reg0  when "0000",
			reg1  when "0001",
			reg2  when "0010",
			reg3  when "0011",
			reg4  when "0100",
			reg5  when "0101",
			reg6  when "0110",
			reg7  when "0111",
			reg8  when "1000",
			reg9  when "1001",
			reg10 when "1010",
			reg11 when "1011",
			reg12 when "1100",
			reg13 when "1101",
			reg14 when "1110",
			reg15 when others;

END Behavior;

