library	IEEE;
use	IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity position is 	
generic(max: integer);	
port(plus: in std_logic;	
	minus: in std_logic;	
	pos: inout integer);
end position;

architecture ARCH of position is 
component offsetCounter is	
	generic(number: integer);
	port(E: in std_logic;
		clk: in std_logic;	
		offset: inout integer range 0 to number-1:=0);
end component;																	   
signal m:integer:=0;
signal p:integer:=0;
signal Ep:std_logic:='1';
signal Em:std_logic:='1'; 
CONSTANT offset : integer := 150; 
begin
	MINUS_M: offsetCounter generic map(max) port map(Em, minus, m);
	PLUS_M: offsetCounter generic map(max) port map(Ep, plus, p);
	pos<=p-m;
	process(pos)
	begin						  
		if (pos>max-150) then Ep<='0';
		else Ep<='1';
		end if;				  
		if (pos<0) then Em<='0';
		else Em<='1';
		end if;				  
	end process;
end ARCH;