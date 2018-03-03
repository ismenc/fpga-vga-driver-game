library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MovNave is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           left : in  STD_LOGIC;
           right : in  STD_LOGIC;
			  vel : in  STD_LOGIC;
			  x_nave : out STD_LOGIC_VECTOR(9 downto 0);
			  y_nave : out STD_LOGIC_VECTOR(9 downto 0));
end MovNave;

architecture Behavioral of MovNave is

signal ejex_nave : integer range 0 to 640;
signal ejey_nave : integer range 0 to 448 := 416;

begin
	
mover: process(clk,reset,left,right,vel)			
	begin
		if(reset='1')then
			ejex_nave<=304;				 --"0100110000"
			ejey_nave<=ejey_nave;
		elsif(rising_edge(clk))then
			if(vel='1') then
				if(left ='1' and ejex_nave>=1) then
					ejex_nave<=ejex_nave-1;
					ejey_nave<=ejey_nave;
				elsif(right='1' and ejex_nave<=608) then
					ejex_nave<=ejex_nave+1;
					ejey_nave<=ejey_nave;
				else
					ejex_nave<=ejex_nave;
					ejey_nave<=ejey_nave;
				end if;
			end if;
		end if;
end process;

x_nave<=std_logic_vector(to_unsigned(ejex_nave, x_nave'length));
y_nave<=std_logic_vector(to_unsigned(ejey_nave, y_nave'length));

end Behavioral;