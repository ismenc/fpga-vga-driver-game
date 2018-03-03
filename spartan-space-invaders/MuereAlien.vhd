library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MuereAlien is
Port(	clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		rgb_bala : in STD_LOGIC_VECTOR(2 downto 0);
		rgb_alien : in STD_LOGIC_VECTOR(2 downto 0);
		muerto : inout STD_LOGIC;
		cl : out STD_LOGIC;
		rst : out STD_LOGIC;
		rst_bala : out STD_LOGIC
		);
end MuereAlien;

architecture Behavioral of MuereAlien is

signal muere : STD_LOGIC;

begin

process(rgb_bala,rgb_alien)
begin

if(rgb_bala/="000" and rgb_alien/="000")then
	muere<='1';
	rst_bala<='1';
else
	rst_bala<='0';
	muere<='0';
end if;
end process;

process(clk,reset,muerto)
begin
	if(reset='1')then
		cl<='1';
		rst<='1';
		muerto<='0';
	elsif(rising_edge(clk))then
		if(muere='1')then
			muerto<='1';
		end if;
		if(muerto='1')then
			rst<='1';
			cl<='1';
			muerto<='0';
		else
			rst<='0';
			cl<='0';
		end if;
	end if;
end process;
end Behavioral;