library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopNave is
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
end TopNave;

-------------------------------------------------------------------------------------------------------

architecture Behavioral of TopNave is

component MovNave is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           left : in  STD_LOGIC;
           right : in  STD_LOGIC;
			  vel : in  STD_LOGIC;
			  x_nave : out STD_LOGIC_VECTOR(9 downto 0);
			  y_nave : out STD_LOGIC_VECTOR(9 downto 0));
end component;

component DIBGenerico is
	 Port(	clear : in STD_LOGIC;
				pos_x : in STD_LOGIC_VECTOR(9 downto 0);
				pos_y : in STD_LOGIC_VECTOR(9 downto 0);
				xdib : in STD_LOGIC_VECTOR(9 downto 0);
				ydib : in STD_LOGIC_VECTOR(9 downto 0);
				DIR : out STD_LOGIC_VECTOR(9 downto 0));
end component;

component DivNave is
	Generic(limite : STD_LOGIC_VECTOR(23 downto 0));
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           vel : out  STD_LOGIC);
end component;

component Nave is
	 Port ( CLKA : in STD_LOGIC;
			  ADDRA : in STD_LOGIC_VECTOR(9 downto 0);
			  DOUTA : out STD_LOGIC_VECTOR(2 downto 0));
end component;

-------------------------------------------------------------------------------------------------------

signal nave_x, nave_y, DIRS : STD_LOGIC_VECTOR (9 downto 0);
signal vels : STD_LOGIC;

-------------------------------------------------------------------------------------------------------

begin

DivisorNave: DivNave
Generic map(limite => "000000111111111111111111")
Port map(clk=>clk,
			reset=>reset,
			vel=>vels);
				
MovimientoNave: MovNave
Port map(clk=>clk,
			reset=>reset,
			left=>left,
			right=>right,
			vel=>vels,
			x_nave=>nave_x,
			y_nave=>nave_y);
			
DibujaNave: DIBgenerico
Port map(clear=>clear,
			pos_x=>pos_x,
			pos_y=>pos_y,
			xdib=>nave_x,
			ydib=>nave_y,
			DIR=>DIRS);
	
MemoriaNave: Nave
Port map(CLKA=>clk,
			ADDRA=>DIRS,
			DOUTA=>rgb);

x_nave<=nave_x;
y_nave<=nave_y;

end Behavioral;