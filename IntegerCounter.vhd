library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity int_counter is
	generic(max:integer :=53);
	port(clk: in std_logic;
		count: inout integer range 0 to max-1:=0);
end int_counter;

architecture ARCH of int_counter is 
component comp is
	generic(N:integer);
	port(a,b: in integer range 0 to N-1;
		r: out std_logic);
end component ;
signal comparison: std_logic;
begin 
	R: comp generic map(max) port map(count,max-1,comparison);
	process(clk)
	begin 
		if(clk'event and clk='1')
			then 
			if comparison='1' then count<=count+1;
			else
				count<=0;
		end if;
	end if;
end process;
end ARCH; 