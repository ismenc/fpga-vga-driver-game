library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopBala is
	Port(	clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			clear : in STD_LOGIC;
			disp : in STD_LOGIC;
			pos_x : in STD_LOGIC_VECTOR(9 downto 0);
			pos_y : in STD_LOGIC_VECTOR(9 downto 0);
			rgb : out STD_LOGIC_VECTOR(2 downto 0);
			x_nave : in STD_LOGIC_VECTOR(9 downto 0);
			Y_nave : in STD_LOGIC_VECTOR(9 downto 0);
			x_bala : out STD_LOGIC_VECTOR(9 downto 0);
			y_bala : out STD_LOGIC_VECTOR(9 downto 0)
			);
end TopBala;

architecture Behavioral of TopBala is

component MovBala is
port (clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		vel : in STD_LOGIC;
		bot : in STD_LOGIC;
		x_nave : in STD_LOGIC_VECTOR(9 downto 0);
		y_nave : in STD_LOGIC_VECTOR(9 downto 0);
		x_bala : out STD_LOGIC_VECTOR(9 downto 0);
		y_bala : out STD_LOGIC_VECTOR(9 downto 0)
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

component DivBala is
	Generic(limite : STD_LOGIC_VECTOR(23 downto 0));
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           vel : out  STD_LOGIC);
end component;

component Bala is
Port ( CLKA : in STD_LOGIC;
			ADDRA : in STD_LOGIC_VECTOR(9 downto 0);
			DOUTA : out STD_LOGIC_VECTOR(2 downto 0));
end component;

----------------------------------------------------------------------------------------------

signal bala_x,bala_y,DIRS : STD_LOGIC_VECTOR (9 downto 0);
signal resets, vels : STD_LOGIC;

----------------------------------------------------------------------------------------------

begin

DivisorBala: DivBala
	Generic map(limite => "000000111111111111111111")
	Port map(clk=>clk,
				reset=>resets,
				vel=>vels);

MovimientoBala: MovBala
Port map(clk=>clk,
			reset=>resets,
			vel=>vels,
			bot=>disp,
			x_nave=>x_nave,
			y_nave=>y_nave,
			x_bala=>bala_x,
			y_bala=>bala_y);

DibujaBala: DIBgenerico
	Port map(clear=>resets,
				pos_x=>pos_x,
				pos_y=>pos_y,
				xdib=>bala_x,
				ydib=>bala_y,
				DIR=>DIRS);
				
MemoriaBala: Bala
Port map(CLKA=>clk,
			ADDRA=>DIRS,
			DOUTA=>rgb);

resets<=reset or clear;
x_bala<=bala_x;
y_bala<=bala_y;

end Behavioral;

