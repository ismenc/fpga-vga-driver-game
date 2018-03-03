library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity CompV_VGA is
Generic (width: integer :=10;
			End_Of_Screen: integer :=479;
			Start_Of_Pulse: integer :=489;
			End_Of_Pulse: integer :=491;
			End_Of_Line: integer := 520);

Port ( clk : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 data : in STD_LOGIC_VECTOR (width-1 downto 0);
		 O1 : out STD_LOGIC;
		 O2 : out STD_LOGIC;
		 O3 : out STD_LOGIC);
end CompV_VGA;

architecture Behavioral of CompV_VGA is

signal p_O1, p_O2, p_O3 : STD_LOGIC;
signal O1ac, O2ac, O3ac : STD_LOGIC;

begin

sinc: process(clk,reset)
begin
	if(reset='1')then
		O1ac<='0';
		O2ac<='1';
		O3ac<='0';
	elsif(rising_edge(clk))then
		O1ac<=p_O1;
		O2ac<=p_O2;
		O3ac<=p_O3;
	end if;
end process;

comb: process(data,O1ac,O2ac,O3ac)
begin
	if(data>End_Of_Screen)then
		p_O1<='1';
	else
		p_O1<='0';
	end if;
	
	if(Start_Of_Pulse<data and data<End_Of_Pulse)then
		p_O2<='0';
	else
		p_O2<='1';
	end if;
	
	if(data=End_Of_Line)then
		p_O3<='1';
	else
		p_O3<='0';
	end if;
end process;

O1<=O1ac;
O2<=O2ac;
O3<=O3ac;

end Behavioral;