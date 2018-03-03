library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Impact is
port (rgb_bala_alien : in STD_LOGIC_VECTOR(2 downto 0);
		rgb_alien : in STD_LOGIC_VECTOR(2 downto 0);
		rgb_nave : in STD_LOGIC_VECTOR(2 downto 0);
		muere : out STD_LOGIC;
		rst_ba : out STD_LOGIC
		);
end Impact;

architecture Behavioral of Impact is

begin

process(rgb_alien,rgb_bala_alien,rgb_nave)
begin

if(rgb_nave/="000" and (rgb_alien/="000" or rgb_bala_alien/="000"))then
	muere<='1';
	rst_ba<='1';
else
	rst_ba<='0';
	muere<='0';
end if;

end process;

end Behavioral;