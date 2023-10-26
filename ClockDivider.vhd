library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity clk_divider is
	port (clk_in : in std_logic;
	r : in std_logic :='0';
	clk_out : out std_logic);
end clk_divider;

architecture ARCH of clk_divider is
component counter is 
	generic(bits:integer);
	port(clk,r: in std_logic;
		q: inout std_logic_vector(bits-1 downto 0));
end component;
signal i: std_logic_vector(1 downto 0):="00";
begin
	COUNT: counter generic map(2) port map(clk_in,r,i);
	clk_out<=i(1);
end ARCH;