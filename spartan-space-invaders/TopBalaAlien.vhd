library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopBalaAlien is
	Port(	clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			clear : in STD_LOGIC;
			pos_x : in STD_LOGIC_VECTOR(9 downto 0);
			pos_y : in STD_LOGIC_VECTOR(9 downto 0);
			rgb : out STD_LOGIC_VECTOR(2 downto 0);
			x_alien : in STD_LOGIC_VECTOR(9 downto 0);
			Y_alien : in STD_LOGIC_VECTOR(9 downto 0);
			x_bala_alien : out STD_LOGIC_VECTOR(9 downto 0);
			y_bala_alien : out STD_LOGIC_VECTOR(9 downto 0)
			);
end TopBalaAlien;

architecture Behavioral of TopBalaAlien is

component MovBalaAlien is
port (clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		vel : in STD_LOGIC;
		x_alien : in STD_LOGIC_VECTOR(9 downto 0);
		y_alien : in STD_LOGIC_VECTOR(9 downto 0);
		x_bala_alien : out STD_LOGIC_VECTOR(9 downto 0);
		y_bala_alien : out STD_LOGIC_VECTOR(9 downto 0)
		);
end component;

component DIBGenerico is
port(	clear : in STD_LOGIC;
		pos_x : in STD_LOGIC_VECTOR(9 downto 0);		
		pos_y : in STD_LOGIC_VECTOR(9 downto 0);
		xdib : in STD_LOGIC_VECTOR(9 downto 0);		
		ydib : in STD_LOGIC_VECTOR(9 downto 0);
		DIR : out STD_LOGIC_VECTOR(9 downto 0));
end component;

component DivBalaAlien is
	Generic(limite : STD_LOGIC_VECTOR(23 downto 0));
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           vel : out  STD_LOGIC);
end component;

component BalaAlien is
Port ( CLKA : in STD_LOGIC;
			ADDRA : in STD_LOGIC_VECTOR(9 downto 0);
			DOUTA : out STD_LOGIC_VECTOR(2 downto 0));
end component;

----------------------------------------------------------------------------------------------

signal bala_alien_x,bala_alien_y,DIRS : STD_LOGIC_VECTOR (9 downto 0);
signal resets, vels : STD_LOGIC;

----------------------------------------------------------------------------------------------

begin

DivisorBalaAlien: DivBalaAlien
	Generic map(limite => "000000111111111111111111")
	Port map(clk=>clk,
				reset=>resets,
				vel=>vels);

MovimientoBalaAlien: MovBalaAlien
Port map(clk=>clk,
			reset=>resets,
			vel=>vels,
			x_alien=>x_alien,
			y_alien=>y_alien,
			x_bala_alien=>bala_alien_x,
			y_bala_alien=>bala_alien_y);

DibujBalaAlien: DIBGenerico
	Port map(clear=>resets,
				pos_x=>pos_x,
				pos_y=>pos_y,
				xdib=>bala_alien_x,
				ydib=>bala_alien_y,
				DIR=>DIRS);
				
MemoriaBalaAlien: BalaAlien
Port map(CLKA=>clk,
			ADDRA=>DIRS,
			DOUTA=>rgb);

resets<=reset or clear;
x_bala_alien<=bala_alien_x;
y_bala_alien<=bala_alien_y;

end Behavioral;