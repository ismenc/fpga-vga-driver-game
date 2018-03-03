
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity GenColor_VGA is

	Port ( blank_h : in STD_LOGIC;
			 blank_v : in STD_LOGIC;
			 R_in : in STD_LOGIC;
			 G_in : in STD_LOGIC;
			 B_in : in STD_LOGIC;
			 R : out STD_LOGIC;
			 G : out STD_LOGIC;
			 B : out STD_LOGIC);
			 
end GenColor_VGA;

architecture Behavioral of GenColor_VGA is

begin

gen_color:process(Blank_H, Blank_V, R_in, G_in, B_in)
	begin
		if (Blank_H='1' or Blank_V='1') then
			R<='0'; 
			G<='0'; 
			B<='0';
		else
			R<=R_in; 
			G<=G_in; 
			B<=B_in;
		end if;
		
end process;

end Behavioral;