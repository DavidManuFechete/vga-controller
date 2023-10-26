library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity BISTABIL is	
generic(number: integer);	
port(D: in integer range 0 to number-1;
	 E,CLK: in std_logic;
	 Q: out integer range 0 to number-1);
end BISTABIL;

architecture ARCH of BISTABIL is
begin
	process(D,E,CLK)
	begin
		if(E='1') then	
			if CLK'event and CLK='1' then Q<=D;
			end if;
		end if;
	end process;
end ARCH;

			
	