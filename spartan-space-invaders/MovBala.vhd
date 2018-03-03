library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity MovBala is
port (clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		vel : in STD_LOGIC;
		bot : in STD_LOGIC;
		x_nave : in STD_LOGIC_VECTOR(9 downto 0);
		y_nave : in STD_LOGIC_VECTOR(9 downto 0);
		x_bala : out STD_LOGIC_VECTOR(9 downto 0);
		y_bala : out STD_LOGIC_VECTOR(9 downto 0)
		);
end MovBala;
architecture Behavioral of MovBala is
signal q: STD_LOGIC;
signal xdib : integer range 0 to 1023;
signal ydib : integer range 0 to 1023;

begin


sinc: process(clk,reset,bot,ydib,x_nave,y_nave)
begin
	if(reset='1')then
		y_bala<=y_nave;
		x_bala<=x_nave;
		q<='0';
	elsif(rising_edge(clk))then
		if(bot='1')then
			q<='1';
		elsif(ydib<5)then
			q<='0';
		end if;
		
		if(q='1')then
			if(vel='1' and ydib>=5)then
				ydib<=ydib-1;
				y_bala<="0000000000"+ydib;
				xdib<=xdib;
				x_bala<="0000000000"+xdib;
			elsif(ydib<5)then
				y_bala<=y_nave;
				x_bala<=x_nave;
				q<='0';
			end if;
		else
			ydib<=to_integer(unsigned(y_nave));
			xdib<=to_integer(unsigned(x_nave));
			y_bala<=y_nave;
			x_bala<=x_nave;
		end if;
	end if;
end process;

end Behavioral;