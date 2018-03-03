library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopAlien is
	Port(	clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			clear : in STD_LOGIC;
			pos_x : in STD_LOGIC_VECTOR(9 downto 0);
			pos_y : in STD_LOGIC_VECTOR(9 downto 0);
			rgb : out STD_LOGIC_VECTOR(2 downto 0);
			x_alien : out STD_LOGIC_VECTOR(9 downto 0);
			Y_alien : out STD_LOGIC_VECTOR(9 downto 0)
			);
end TopAlien;

architecture Behavioral of TopAlien is

component MovAlien is
port (clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		vel : in STD_LOGIC;
		x_alien : out STD_LOGIC_VECTOR(9 downto 0);
		y_alien : out STD_LOGIC_VECTOR(9 downto 0));
end component;

component DIBgenerico is
port(	clear : in STD_LOGIC;
		pos_x : in STD_LOGIC_VECTOR(9 downto 0);	
		pos_y : in STD_LOGIC_VECTOR(9 downto 0);
		xdib : in STD_LOGIC_VECTOR(9 downto 0);	
		ydib : in STD_LOGIC_VECTOR(9 downto 0);
		DIR : out STD_LOGIC_VECTOR(9 downto 0));
end component;

component DivAlien is
	Generic(limite : STD_LOGIC_VECTOR(23 downto 0));
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           vel : out  STD_LOGIC);
end component;

component Alien is
Port ( CLKA : in STD_LOGIC;
			ADDRA : in STD_LOGIC_VECTOR(9 downto 0);
			DOUTA : out STD_LOGIC_VECTOR(2 downto 0));
end component;

------------------------------------------------------------------------------------------------

signal alien_x, alien_y, DIRS : STD_LOGIC_VECTOR (9 downto 0);
signal vels : STD_LOGIC;

------------------------------------------------------------------------------------------------

begin

DivisorAlien: DivAlien
	Generic map(limite => "000011111111111111111111")
	Port map(clk=>clk,
				reset=>reset,
				vel=>vels);
						
MovimientoAlien: MovAlien
	Port map(
				clk=>clk,
				reset=>reset,
				vel=>vels,
				x_alien=>alien_x,
				y_alien=>alien_y);
				
DibujaAlien: DIBgenerico
	Port map(clear=>clear,
				pos_x=>pos_x,
				pos_y=>pos_y,
				xdib=>alien_x,
				ydib=>alien_y,
				DIR=>DIRS);
				
MemoriaAlien: Alien
Port map(CLKA=>clk,
			ADDRA=>DIRS,
			DOUTA=>rgb);
			
x_alien<=alien_x;
y_alien<=alien_y;

end Behavioral;

