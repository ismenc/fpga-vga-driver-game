library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity DIBgenerico is
port(	clear : in STD_LOGIC;
		pos_x : in STD_LOGIC_VECTOR(9 downto 0);
		pos_y : in STD_LOGIC_VECTOR(9 downto 0);
		xdib : in STD_LOGIC_VECTOR(9 downto 0);		
		ydib : in STD_LOGIC_VECTOR(9 downto 0);
		DIR : out STD_LOGIC_VECTOR(9 downto 0));
end DIBgenerico;

architecture Behavioral of DIBgenerico is

signal xrel : STD_LOGIC_VECTOR(9 downto 0);		
signal yrel : STD_LOGIC_VECTOR(9 downto 0);

begin

direccion: process(clear, pos_x, pos_y, xdib, ydib, xrel, yrel)
begin

	if(clear = '0' and pos_x >= xdib and pos_x < xdib+32 and pos_y >= ydib and pos_y < ydib+32) then
		DIR(9 downto 5)<=yrel(4 downto 0); 
		DIR(4 downto 0)<=xrel(4 downto 0);
		xrel(9 downto 5)<="00000";
		yrel(9 downto 5)<="00000";
	else
		DIR(9 downto 0)<="0000000000";
	end if;
	
end process;

xrel <= pos_x - xdib;
yrel <= pos_y - ydib;

end Behavioral;