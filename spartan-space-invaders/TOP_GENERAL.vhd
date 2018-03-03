library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP_GENERAL is
Port (clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		left : in STD_LOGIC;
		right : in STD_LOGIC;
		disp : in STD_LOGIC;
		VS : out STD_LOGIC;
		HS : out STD_LOGIC;
		R : out STD_LOGIC;
		G : out STD_LOGIC;
		B : out STD_LOGIC
		);
end TOP_GENERAL;

architecture Behavioral of TOP_GENERAL is

component TopDriver_VGA is
	Port ( clk : in STD_LOGIC;
			 reset : in STD_LOGIC;
 			 VS : out STD_LOGIC;
 			 HS : out STD_LOGIC;
			 RGB_in : in STD_LOGIC_VECTOR(2 downto 0);
			 pos_x : out STD_LOGIC_VECTOR(9 downto 0);
			 pos_y : out STD_LOGIC_VECTOR(9 downto 0);
 			 R : out STD_LOGIC;
 			 G : out STD_LOGIC;
 			 B : out STD_LOGIC);
end component;

component TopNave is
	Port(	clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			clear : in STD_LOGIC;
			pos_x : in STD_LOGIC_VECTOR(9 downto 0);
			pos_y : in STD_LOGIC_VECTOR(9 downto 0);
			left : in  STD_LOGIC;
         right : in  STD_LOGIC;
			rgb : out STD_LOGIC_VECTOR(2 downto 0);
			x_nave : out STD_LOGIC_VECTOR(9 downto 0);
			y_nave : out STD_LOGIC_VECTOR(9 downto 0)
			);
end component;

component TopBala is
	Port(	clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			clear : in STD_LOGIC;
			disp : in STD_LOGIC;
			pos_x : in STD_LOGIC_VECTOR(9 downto 0);
			pos_y : in STD_LOGIC_VECTOR(9 downto 0);
			rgb : out STD_LOGIC_VECTOR(2 downto 0);
			x_nave : in STD_LOGIC_VECTOR(9 downto 0);
			y_nave : in STD_LOGIC_VECTOR(9 downto 0);
			x_bala : out STD_LOGIC_VECTOR(9 downto 0);
			y_bala : out STD_LOGIC_VECTOR(9 downto 0)
			);
end component;

component TopBalaAlien is
	Port(	clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			clear : in STD_LOGIC;
			pos_x : in STD_LOGIC_VECTOR(9 downto 0);
			pos_y : in STD_LOGIC_VECTOR(9 downto 0);
			rgb : out STD_LOGIC_VECTOR(2 downto 0);
			x_alien : in STD_LOGIC_VECTOR(9 downto 0);
			Y_alien : in STD_LOGIC_VECTOR(9 downto 0);
			x_bala_alien : out STD_LOGIC_VECTOR(9 downto 0);
			Y_bala_alien : out STD_LOGIC_VECTOR(9 downto 0)
			);
end component;

component TopAlien is
	Port(	clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			clear : in STD_LOGIC;
			pos_x : in STD_LOGIC_VECTOR(9 downto 0);
			pos_y : in STD_LOGIC_VECTOR(9 downto 0);
			rgb : out STD_LOGIC_VECTOR(2 downto 0);
			x_alien : out STD_LOGIC_VECTOR(9 downto 0);
			y_alien : out STD_LOGIC_VECTOR(9 downto 0)
			);
end component;

component MuereAlien is
	Port(	clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			muerto : inout STD_LOGIC;
			cl : out STD_LOGIC;
			rst : out STD_LOGIC;
			rst_bala : out STD_LOGIC;
			rgb_bala : in STD_LOGIC_VECTOR(2 downto 0);
			rgb_alien : in STD_LOGIC_VECTOR(2 downto 0)
			);
end component;

--------------------------------------------------------------------------------------------------------------------

signal pos_xs,pos_ys,x_naves,y_naves,x_aliens,y_aliens,x_balas,y_balas,x_BA,y_BA : STD_LOGIC_VECTOR(9 downto 0);
signal rgbs,rgb_naves,rgb_aliens,rgb_balas,rgb_bala_alien : STD_LOGIC_VECTOR(2 downto 0);
signal rstA,rstB,rst_ali,clA,muertoA,rstBA,clBA : STD_LOGIC;
--------------------------------------------------------------------------------------------------------------------

begin

DRIVER_VGA_GRAL: TopDriver_VGA
Port map(
	clk=>clk,
	reset=>reset,
	VS=>VS,
	HS=>HS,
	RGB_in=>rgbs,
	pos_x=>pos_xs,
	pos_y=>pos_ys,
	R=>R,
	G=>G,
	B=>B);

NAVE_GRAL: TopNave
Port map(
	clk=>clk,
	reset=>reset, 
	clear=>reset, 
	pos_x=>pos_xs,
	pos_y=>pos_ys,
	left=>left,
	right=>right,
	rgb=>rgb_naves,
	x_nave=>x_naves,
	y_nave=>y_naves);
	
BALA_GRAL: TopBala
Port map(
	clk=>clk,
	reset=>reset, 
	clear=>rstB, 
	disp=>disp,
	rgb=>rgb_balas,
	pos_x=>pos_xs,
	pos_y=>pos_ys,
	x_nave=>x_naves,
	y_nave=>y_naves,
	x_bala=>x_balas,
	y_bala=>y_balas);
	
BALA_ALIEN_GRAL: TopBalaAlien
Port map(
	clk=>clk,
	reset=>rstBA,
	clear=>clBA,
	pos_x=>pos_xs,
	pos_y=>pos_ys,
	rgb=>rgb_bala_alien,
	x_alien=>x_aliens,
	y_alien=>y_aliens,
	x_bala_alien=>x_BA,
	y_bala_alien=>y_BA);	
		
ALIEN_GRAL: TopAlien
Port map(
	clk=>clk,
	reset=>rst_ali,
	pos_x=>pos_xs,
	pos_y=>pos_ys,
	clear=>clA,
	rgb=>rgb_aliens,
	x_alien=>x_aliens,
	y_alien=>y_aliens);
	
MUERE_ALIEN: MuereAlien
Port map(
	clk=>clk,
	reset=>reset,
	rgb_bala=>rgb_balas,
	rgb_alien=>rgb_aliens,
	muerto=>muertoA,
	cl=>clA,		    
	rst=>rstA,		 
	rst_bala=>rstB);  
	
rst_ali<=reset or rstA;
rgbs<= rgb_naves or rgb_aliens or rgb_balas or rgb_bala_alien;
	
end Behavioral;

