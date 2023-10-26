library	IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity offsetCounter is
	generic(number:integer);
	port(E,clk:in std_logic;
		offset:inout integer range 0 to number-1:=0);
end offsetCounter;

architecture ARCH of offsetCounter is	 
begin
	process(clk,offset,E)
	begin	   	   	  
		if (clk'event and clk='1' and E='1') then offset<=offset+1;
		end if;					  						 	  
	end process;
end ARCH;
