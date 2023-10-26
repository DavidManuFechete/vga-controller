 library IEEE;
 use IEEE.STD_LOGIC_1164.ALL;
 use IEEE.STD_LOGIC_UNSIGNED.ALL; 
 use IEEE.STD_LOGIC_ARITH.ALL;
 
 entity comp is
	 generic(N:integer);
	 port(a,b: in integer range 0 to N-1;
	 	 r:out std_logic);	 
end comp;

architecture ARCH of comp is 
begin 
	process(a,b)
	begin 
		if a<b then r<='1';
		else r<='0';
		end if;
	end process;
end ARCH;
 