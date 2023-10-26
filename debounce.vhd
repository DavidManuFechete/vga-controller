library	ieee;
use	ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity debounce is
	generic (nr_bistabile: integer);
	port (btn_in : in std_logic;
	clk: in std_logic; --internal clock
	btn_out: out std_logic);
end debounce;

architecture ARH of debounce is

component BISTABIL_D is
	port(D: in std_logic;
	clk: in std_logic;
	Q: out std_logic);
end component ;

component and_gate is
	generic(N: integer);
	port(input: in std_logic_vector (1 to N);
	output: out std_logic);
end component ;

signal inter : std_logic_vector (1 to nr_bistabile)	;

begin
	GEN_BIST: for i in 1 to nr_bistabile generate
		FIRST: if i = 1 generate
			D1: BISTABIL_D port map (btn_in, clk, inter(1));
		end generate FIRST;
		
		LAST: if i > 1 generate
			D2: bistabil_d port map (inter(i-1), clk, inter(i));
		end generate LAST;
	end generate GEN_BIST;
	
	GATE: and_gate generic map (nr_bistabile) port map (inter, btn_out);
end ARH;

