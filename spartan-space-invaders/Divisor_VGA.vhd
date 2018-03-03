library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Divisor_VGA is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk_pixel : inout  STD_LOGIC);
end Divisor_VGA;

architecture Behavioral of Divisor_VGA is

begin

sinc: process(clk,reset)

begin
	if(reset='1')then
		clk_pixel<='0';
	elsif(rising_edge(clk))then
		clk_pixel<= not clk_pixel;
	end if;
end process;



end Behavioral;

