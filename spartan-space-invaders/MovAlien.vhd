library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MovAlien is
port (clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		vel : in STD_LOGIC;
		x_alien : out STD_LOGIC_VECTOR(9 downto 0);
		y_alien : out STD_LOGIC_VECTOR(9 downto 0));
end MovAlien;

architecture Behavioral of MovAlien is			

signal q : std_logic;
signal xdib : integer range 0 to 640;
signal ydib : integer range 0 to 480;

begin

sinc:process(clk,reset,vel,q,xdib,ydib)
begin

if(reset='1')then 
	xdib <=33;
	ydib <=33;
	q <='0';
elsif(rising_edge(clk)) then
	if(vel='1') then
		if(xdib >= 608)then
			xdib <= xdib-2;
			ydib <= ydib+32;
			q <= not q;
		elsif (xdib <=32)then
			xdib <= xdib+2;
			ydib <= ydib+32;
			q <= not q;
		elsif(q='0') then
			xdib <= xdib+1;
		elsif(q='1') then
			xdib <= xdib-1;
		end if;
	else
		xdib<=xdib;
		ydib<=ydib;
	end if;
end if;

x_alien<=std_logic_vector(to_unsigned(xdib,x_alien'length));
y_alien<=std_logic_vector(to_unsigned(ydib,y_alien'length));

end process;
end Behavioral;