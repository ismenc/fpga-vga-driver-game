library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity ContV_VGA is
	 Generic (width:INTEGER:=10);
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           reset_s : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (width-1 downto 0));
end ContV_VGA;

architecture Behavioral of ContV_VGA is
signal cont, p_cont : STD_LOGIC_VECTOR (width-1 downto 0);

begin

sinc:process(clk,reset)
begin
	if(reset='1')then
		for i in cont' range
		loop
			cont(i)<='0';
		end loop;
	elsif(rising_edge(clk))then
		cont<=p_cont;
	end if;
end process;

comb:process(enable,reset_s,cont)
begin
	if(enable='1')then
		if(reset_s='1')then
			for i in cont' range
			loop
			p_cont(i)<='0';
			end loop;
		elsif(reset_s='0')then
			p_cont<=cont+1;
		end if;
	else
		p_cont<=cont;
	end if;
end process;

Q<=cont;

end Behavioral;