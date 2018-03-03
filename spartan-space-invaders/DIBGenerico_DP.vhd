library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity DIBgenerico_DP is
port(	clear : in STD_LOGIC;
		pos_x : in STD_LOGIC_VECTOR(9 downto 0);
		pos_y : in STD_LOGIC_VECTOR(9 downto 0);
		xdib1 : in STD_LOGIC_VECTOR(9 downto 0);		
		ydib1 : in STD_LOGIC_VECTOR(9 downto 0);
		xdib2 : in STD_LOGIC_VECTOR(9 downto 0);		
		ydib2 : in STD_LOGIC_VECTOR(9 downto 0);
		DIR1 : out STD_LOGIC_VECTOR(9 downto 0);
		DIR2 : out STD_LOGIC_VECTOR(9 downto 0));

end DIBgenerico_DP;

architecture Behavioral of DIBgenerico_DP is

signal xrel1 : STD_LOGIC_VECTOR(9 downto 0);		
signal yrel1 : STD_LOGIC_VECTOR(9 downto 0);

signal xrel2 : STD_LOGIC_VECTOR(9 downto 0);	
signal yrel2 : STD_LOGIC_VECTOR(9 downto 0);

begin

direccion: process(clear,pos_x,pos_y,xdib1,ydib1,xdib2,ydib2,xrel1,yrel1,xrel2,yrel2)
begin

	if(clear = '0' and pos_x >= xdib1 and pos_x < xdib1+32 and pos_y >= ydib1 and pos_y < ydib1+32) then
		DIR1(9 downto 5)<=yrel1(4 downto 0); 
		DIR1(4 downto 0)<=xrel1(4 downto 0);
		xrel1(9 downto 5)<="00000";
		yrel1(9 downto 5)<="00000";
	else
		DIR1(9 downto 0)<="0000000000";
	end if;
	
	if(clear = '0' and pos_x >= xdib2 and pos_x < xdib2+32 and pos_y >= ydib2 and pos_y < ydib2+32) then
		DIR2(9 downto 5)<=yrel2(4 downto 0); 
		DIR2(4 downto 0)<=xrel2(4 downto 0);
		xrel2(9 downto 5)<="00000";
		yrel2(9 downto 5)<="00000";
	else
		DIR2(9 downto 0)<="0000000000";
	end if;
	
	
end process;

xrel1 <= pos_x - xdib1;
yrel1 <= pos_y - ydib1;

xrel2 <= pos_x - xdib2;
yrel2 <= pos_y - ydib2;

end Behavioral;