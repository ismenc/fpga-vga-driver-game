library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BlinkVidas is
port(clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		desap : in STD_LOGIC;
		vel : in STD_LOGIC;
		vidas : in STD_LOGIC_VECTOR(2 downto 0);
		cl : out STD_LOGIC;
		rst : out STD_LOGIC
		);
end BlinkVidas;

architecture Behavioral of BlinkVidas is

signal q : STD_LOGIC;
signal aux : integer range 0 to 11 := 0;
signal avidas : STD_LOGIC_VECTOR(2 downto 0);

begin

ponerTiempoQ:process(q, vel, aux, vidas, avidas)
begin

if(vidas/=avidas and vidas(2)='1')then
	q<='1';
elsif(avidas/=vidas and vidas(1)='1')then
	q<='1';
elsif(q='1' and aux<7)then
	if(vel'event and vel='1')then
		aux<=aux+1;
	elsif(aux=7)then
		aux<=0;
		q<='0';
	end if;
end if;

avidas<=(vidas and "111") and "111";

end process;

process(clk, reset, vidas, q)
begin
if(reset='1' or vidas="111")then
	cl<='1';
	rst<='1';
elsif(rising_edge(clk))then
	if(q='1')then
		if(vel='1')then
			cl<='1';
		else
			cl<='0';
		end if;
	elsif(q='0')then
		if(desap='1')then
			cl<='1';
		else
			cl<='0';
		end if;
	end if;
end if;
end process;

end Behavioral;