library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity DebounceUnit is
	port(
	clock: in std_logic;
	imgB: in std_logic;
	leftBtn: in std_logic;
	rightBtn: in std_logic;
	upBtn: in std_logic;
	downBtn: in std_logic;
	img: out std_logic;
	left: out std_logic;
	right: out std_logic;
	up: out std_logic;
	down: out std_logic
	);
end DebounceUnit;

architecture ARH of DebounceUnit is

component debounce is
	generic (nr_bistabile: integer);
	port (btn_in : in std_logic;
	clk: in std_logic; --internal clock
	btn_out: out std_logic);
end component ;	

constant nr_bistabile: integer := 3;

begin					
	
IMAGE_BTN: debounce generic map (nr_bistabile) port map (imgB, clock, img);
LEFT_BTN: debounce generic map (nr_bistabile) port map (leftBtn, clock, left);
RIGHT_BTN: debounce generic map (nr_bistabile) port map (rightBtn, clock, right);
UP_BTN: debounce generic map (nr_bistabile) port map (upBtn, clock, up);
DOWN_BTN: debounce generic map (nr_bistabile) port map (downBtn, clock, down);

end ARH;
