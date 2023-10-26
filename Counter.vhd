library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity counter is 
	generic(bits:integer:=3);
	port(clk: in std_logic;
		r: in std_logic:='0';
		q: inout std_logic_vector(bits-1 downto 0):=(others=>'0'));
end counter;

architecture ARCH of counter is		  
begin
COUNT: process(clk,r)	  
begin
	if r='1' then
		q<=(others=>'0');
	elsif clk'event and clk='1' then 
		 q<=q+1;
	end if;
end process COUNT;
end ARCH;