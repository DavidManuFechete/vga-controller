library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity and_gate is
	generic(N:integer:=4);
	port(input:in std_logic_vector(1 to N);
	output:out std_logic);
end and_gate;  

architecture ARCH of and_gate is
signal s:std_logic_vector(1 to N+1);
begin
	s(1)<='1';
	gen:
	for i in 1 to N generate
		u1 : s(i+1)<=s(i) and input(i);
	end generate gen;
	output<=s(N+1);
end ARCH;