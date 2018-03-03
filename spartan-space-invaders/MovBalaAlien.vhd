library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity MovBalaAlien is
port (clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		vel : in STD_LOGIC;
		x_alien : in STD_LOGIC_VECTOR(9 downto 0);
		y_alien : in STD_LOGIC_VECTOR(9 downto 0);
		x_bala_alien : out STD_LOGIC_VECTOR(9 downto 0);
		y_bala_alien : out STD_LOGIC_VECTOR(9 downto 0)
		);
end MovBalaAlien;

architecture Behavioral of MovBalaAlien is
signal q,act: STD_LOGIC;
signal ydib : integer range 0 to 1023;

begin

sinc: process(clk,reset,vel,ydib,x_alien,y_alien)
begin
	if(reset='1')then
		y_bala_alien<=y_alien;
		x_bala_alien<=x_alien;
		q<='0';
	elsif(rising_edge(clk))then
		if(vel='1' and q='0')then
			act<='1';
		elsif(vel='0' and act='1')then
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
			y_bala_alien<=y_alien;
			x_bala_alien<=x_alien;
		end if;
	end if;
end process;

end Behavioral;