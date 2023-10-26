library	IEEE;
use	IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;	 

entity vga_controller is
	port(clock: in std_logic;
	HS: out std_logic := '1';
	VS: out std_logic := '1';		   
	ImgE: out std_logic := '1';
	x: out integer range 0 to 639:= 0;
	y: out integer range 0 to 639:= 0);
end vga_controller;

architecture ARCH of vga_controller is
constant h_display: integer := 640; --nr of pixels on a row of display
constant h_front: integer := 16; --nr of pixel clocks for front porch of horizontal sync
constant h_back: integer := 48; --nr of pixel clocks for back porch of horizontal sync
constant h_sync_pulse: integer := 96; --nr of pixel clocks for which horizontal sync is 0	
constant v_display: integer := 480; --nr of rows of diplay
constant v_front: integer := 10; -- nr of rows for front porch of vertical sync
constant v_back: integer := 29; --nr of rows for back porch of vertical sync
constant v_sync_pulse: integer := 2; --nr of rows for which vertical sync is 0
constant h_total_period: integer := h_front + h_display + h_sync_pulse + h_back; --total pixels clock for horizontal sync
constant v_total_period: integer := v_front + v_display + v_sync_pulse + v_back; --total rows for vertical sync
constant h_first_part: integer := h_display + h_front;
constant h_last_part: integer := h_display + h_front + h_sync_pulse - 1;
constant v_first_part: integer := v_display + v_front;
constant v_last_part: integer := v_display + v_front + v_sync_pulse - 1;
	
component int_counter is
	generic(max: integer);
	port(clk: in std_logic;			
	count: inout integer);
end component;						   

component comp is
	generic(N: integer);
	port(a,b: in integer range 0 to N - 1;
	r: out std_logic);
end component ;

component BISTABIL_D is
	port(D,CLK: in std_logic;
	Q: out std_logic);
end component ;

component BISTABIL is
	generic(number: integer);
	port(D: in integer range 0 to number - 1;
	E,CLK: in std_logic;
	Q: out integer range 0 to number - 1);
end component ;

signal h_count: integer range 0 to h_total_period - 1 := 0; --current column
signal v_count: integer range 0 to v_total_period - 1 := 0; --current row
signal v_sync_clock: std_logic := '0';
signal h_positive1, h_positive2, v_positive1, v_positive2 : std_logic;
signal h_aux, v_aux: std_logic;
signal column_enable, row_enable: std_logic;
signal h_sync_input, v_sync_input: std_logic;
signal v_sync_clock_input: std_logic;
signal display_enable_input: std_logic;
		
	
begin													
COUNT_HORIZONTAL: int_counter generic map (h_total_period) port map (clock, h_count);
COUNT_VERTICAL: int_counter generic map (v_total_period) port map (v_sync_clock, v_count);
H_PART1: comp generic map (h_total_period) port map (h_count, h_first_part, h_positive1);
H_PART2: comp generic map (h_total_period) port map (h_last_part, h_count, h_positive2);							   
V_PART1: comp generic map (v_total_period) port map (v_count, v_first_part, v_positive1);
C_ENABLE: comp generic map (h_total_period) port map (h_count, h_display, column_enable);
R_ENABLE: comp generic map (v_total_period) port map (v_count, v_display, row_enable);	

HSYNC_FF: BISTABIL_D port map (h_sync_input, clock, HS);
VSYNC_FF: BISTABIL_D port map (v_sync_input, clock, VS);
DISPLAY_FF: BISTABIL_D port map (display_enable_input, clock, ImgE);
VSYNCCLOCK_FF: BISTABIL_D port map(v_sync_clock_input, clock, v_sync_clock);
ROWS: BISTABIL generic map (v_total_period) port map (v_count, row_enable, clock, x); 
COLUMNS: BISTABIL generic map (h_total_period) port map (h_count, column_enable, clock, y);	  

h_sync_input <= h_positive1 or h_positive2;
v_sync_input <= v_positive1;
v_sync_clock_input <= not h_sync_input;		
display_enable_input <= column_enable and row_enable;	
end ARCH;