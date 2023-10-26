library	IEEE;
use	IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;	

entity final is
	port(CLK: in std_logic;				  
	ImgB: in std_logic;	 
	B_Up: in std_logic;
	B_Down: in std_logic;
	B_Left: in std_logic;
	B_Right: in std_logic;  
	
	Red_In: in std_logic_vector (3 downto 0); 
	Blue_In: in std_logic_vector (3 downto 0);
	Green_In: in std_logic_vector (3 downto 0);
	
	HS: out std_logic;
	VS: out std_logic;	 
	
	Red_Out: out std_logic_vector (3 downto 0);	 
	Blue_Out: out std_logic_Vector (3 downto 0);
	Green_Out: out std_logic_vector (3 downto 0));
end final;

architecture ARCH of final is

component clk_divider is
	port(clk_in : in std_logic;
	r: in std_logic;
	clk_out : out std_logic);
end component;

component vga_controller is
	port(clock: in std_logic;			  
	HS: out std_logic := '1';
	VS: out std_logic := '1';		   
	ImgE: out std_logic := '1';
	x: out integer := 0;
	y: out integer := 0);
end component;

component position is 
	generic(max: integer);
	port(plus: in std_logic;
		minus: in std_logic;
		pos: inout integer);
end component;	

component img_gen is 
	port(ImgE: in std_logic;
	img: in integer;
	x: in integer;
	y: in integer;
	a: in integer;
	b: in integer;
	Red_In: in std_logic_vector (3 downto 0);
	Green_In: in std_logic_vector (3 downto 0);
	Blue_In: in std_logic_vector (3 downto 0);
	Red_Out: out std_logic_vector (3 downto 0);
	Green_Out: out std_logic_vector (3 downto 0);
	Blue_Out: out std_logic_vector (3 downto 0));
end component;

component DebounceUnit is
port ( clock : in std_logic;
       imgB: in std_logic;
       leftBtn: in std_logic; 
       rightBtn : in std_logic;
       upBtn: in std_logic;
       downBtn: in std_logic;
       img: out std_logic;
       left : out std_logic;
       right : out std_logic;
       up : out std_logic;
       down : out std_logic);
end component; 

component int_counter is
	generic(max:integer);
	port(clk: in std_logic;			
		count: inout integer range 0 to max - 1 :=0);
end component;

signal img, clock, ImgE, B_U, B_D, B_L, B_R: std_logic;
signal imag_nr: integer;
signal z, t, a, b: integer;
constant max_imag: integer := 4; 
							   										
begin
	   			  
DIVIDE: clk_divider port map (CLK, '0', clock);
COUNT: int_counter generic map (max_imag) port map(img, imag_nr);
DEBOUNCE : DebounceUnit port map (clock, ImgB, B_Left, B_right, B_Up, B_Down, img, B_L, B_R, B_U, B_D);
POS: vga_controller port map (clock, HS, VS, ImgE, z, t);
X_AXIS: position generic map (640) port map (B_R, B_L, a);
Y_AXIS: position generic map (480) port map (B_D, B_U, b);
IMAGE: img_gen port map (ImgE,imag_nr, z,t, a,b, Red_In, Green_In,Blue_In, Red_Out, Green_Out, Blue_Out );
end ARCH;