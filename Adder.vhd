LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.COMPONENTS.all;

--SOMADOR RIPPLE CARRY DE 4 BITS
ENTITY Adder  IS
PORT ( Cin : IN STD_LOGIC;
	X, Y : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	Cout : OUT STD_LOGIC );
END Adder;

ARCHITECTURE Structure OF Adder  IS
	SIGNAL C : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL P : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN													  
	
	P(0)  <= Y(0)  XOR Cin;
	P(1)  <= Y(1)  XOR Cin;
	P(2)  <= Y(2)  XOR Cin;
	P(3)  <= Y(3)  XOR Cin;
	P(4)  <= Y(4)  XOR Cin;
	P(5)  <= Y(5)  XOR Cin;
	P(6)  <= Y(6)  XOR Cin;
	P(7)  <= Y(7)  XOR Cin;
	P(8)  <= Y(8)  XOR Cin;
	P(9)  <= Y(9)  XOR Cin;
	P(10) <= Y(10) XOR Cin;
	P(11) <= Y(11) XOR Cin;
	P(12) <= Y(12) XOR Cin;
	P(13) <= Y(13) XOR Cin;
	P(14) <= Y(14) XOR Cin;
	P(15) <= Y(15) XOR Cin;
	
	stage0:  FA PORT MAP ( C(0),  X(0),  P(0),  S(0),  C(1)  );
	stage1:  FA PORT MAP ( C(1),  X(1),  P(1),  S(1),  C(2)  );
	stage2:  FA PORT MAP ( C(2),  X(2),  P(2),  S(2),  C(3)  );
	stage3:  FA PORT MAP ( C(3),  X(3),  P(3),  S(3),  C(4)  );
	stage4:  FA PORT MAP ( C(4),  X(4),  P(4),  S(4),  C(5)  );
	stage5:  FA PORT MAP ( C(5),  X(5),  P(5),  S(5),  C(6)  );
	stage6:  FA PORT MAP ( C(6),  X(6),  P(6),  S(6),  C(7)  );
	stage7:  FA PORT MAP ( C(7),  X(7),  P(7),  S(7),  C(8)  );
	stage8:  FA PORT MAP ( C(8),  X(8),  P(8),  S(8),  C(9)  );
	stage9:  FA PORT MAP ( C(9),  X(9),  P(9),  S(9),  C(10) );
	stage10: FA PORT MAP ( C(10), X(10), P(10), S(10), C(11) );
	stage11: FA PORT MAP ( C(11), X(11), P(11), S(11), C(12) );
	stage12: FA PORT MAP ( C(12), X(12), P(12), S(12), C(13) );
	stage13: FA PORT MAP ( C(13), X(13), P(13), S(13), C(14) );
	stage14: FA PORT MAP ( C(14), X(14), P(14), S(14), C(15) );
	stage15: FA PORT MAP ( C(15), X(15), P(15), S(15), Cout  );

END Structure;