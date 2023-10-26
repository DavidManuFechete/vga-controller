library	IEEE;
use	IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity BISTABIL_D is
	port(D,CLK: in std_logic;
	Q: out std_logic);
end BISTABIL_D;

architecture ARCH of BISTABIL_D is
begin
	process(CLK)
	begin
		if CLK'event and CLK= '1' then Q <= D;
		end if;
	end process;
end ARCH;
