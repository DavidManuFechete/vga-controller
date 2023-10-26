library	IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity img_gen is
	port(ImgE:in std_logic;
	x: integer;
	y:in integer;
	img:in integer;
	a:in integer;
	b:in integer;
	Red_In:in std_logic_vector(3 downto 0);
	Green_In:in std_logic_vector(3 downto 0);
	Blue_In:in std_logic_vector(3 downto 0);
	Red_Out:out std_logic_vector(3 downto 0);
	Green_Out:out std_logic_vector(3 downto 0);
	Blue_Out:out std_logic_vector(3 downto 0));
end img_gen;

architecture arh of img_gen is
constant R:integer:=50;
constant size:integer:=130;	   
constant circle_disp  : integer := 50;
begin
	process(ImgE,x,y,a,b,Red_In,Blue_In,Green_In,img)
	begin 
		if ImgE='1' then   
		case img is
			when 0=>
					if(((x-(a+circle_disp ))*(x-(a+circle_disp) )+(y-(b+circle_disp) )*(y-(b+circle_disp )))<R*R) then
					   Red_Out<=Red_In;
						Green_Out<=Green_In;
						Blue_Out<=Blue_In;
				else
						Red_Out<="1111";
						Green_Out<="1111";
						Blue_Out<="1111";
					end if;	
                when 1=>
					if(x>a and x<a+size and y>b and y<b+size) then
						Red_Out<=Red_In;
						Green_Out<=Green_In;
						Blue_Out<=Blue_In;
				else
						Red_Out<="1111";
					Green_Out<="1111";
					Blue_Out<="1111";
					end if;
			when 2=>
					if((x-b)+(y-a)<=size and x>b and y>a) then
			     	Red_Out<=Red_In;
					Green_Out<=Green_In;
					Blue_Out<=Blue_In;
					else
						Red_Out<="1111";
					   Green_Out<="1111";
					   Blue_Out<="1111";
					end if;		 
				when 3 => 
				if ((y-a) mod size = 0 ) then  
				    Red_Out<=Red_In;
					Green_Out<=Green_In;
					Blue_Out<=Blue_In;
				else
				    Red_Out<="1111";
                    Green_Out<="1111";
					 Blue_Out<="1111";
				end if;
				when others=>
				Red_Out<="1111";
				Green_Out<="1111";
				Blue_Out<="1111";  
		     
			end case;	
		else
		  Red_Out <= (others => '0');
		  Green_Out <= (others => '0');
		  Blue_Out <= (others => '0');
	end if;
	end process;
end arh;
			