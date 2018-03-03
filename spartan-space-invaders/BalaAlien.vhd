----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:56:13 02/12/2015 
-- Design Name: 
-- Module Name:    bala_alien - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity MovBalaAlien is
port (clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		vel : in STD_LOGIC;
		bot : in STD_LOGIC;
		x_alien : in STD_LOGIC_VECTOR(9 downto 0);
		y_alien : in STD_LOGIC_VECTOR(9 downto 0);
		x_bala_alien : out STD_LOGIC_VECTOR(9 downto 0);
		y_bala_alien : out STD_LOGIC_VECTOR(9 downto 0)
		);
end mov_bala_alien;

architecture Behavioral of mov_bala_alien is
signal q,act: STD_LOGIC;
signal xdib : integer range 0 to 1023;
signal ydib : integer range 0 to 1023;

begin

sinc: process(clk,reset,bot,ydib,x_alien,y_alien)
begin
	if(reset='1')then
		y_bala_alien<=y_alien;
		x_bala_alien<=x_alien;
		q<='0';
	elsif(rising_edge(clk))then
		if(bot='1' and q='0')then
			act<='1';
		elsif(bot='0' and act='1')then
			act<='0';
			q<='1';
		end if;
		
		if(q='1')then
			if(vel='1' and ydib>=5)then
				ydib<=ydib+1;
				y_bala_alien<="0000000000"+ydib;
			elsif(ydib<5)then
				y_bala_alien<=y_alien;
				x_bala_alien<=x_alien;
				q<='0';
			end if;
		else
			ydib<=to_integer(unsigned(y_alien));
			xdib<=to_integer(unsigned(y_alien));
			y_bala_alien<=y_alien;
			x_bala_alien<=x_alien;
		end if;
	end if;
end process;

end Behavioral;