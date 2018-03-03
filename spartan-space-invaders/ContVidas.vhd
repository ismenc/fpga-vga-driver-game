library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity ContVidas is
Port (clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		muere : in STD_LOGIC;
		--muerto : out STD_LOGIC;				MUERTO SE PUEDE HACER CON UNA AND NEGADA DE VIDAS
		vidas : inout STD_LOGIC_VECTOR(2 downto 0)
		);
end ContVidas;

architecture Behavioral of ContVidas is

signal p_vidas : STD_LOGIC_VECTOR(2 downto 0);

begin

sinc:process(clk, reset)
begin
if(reset='1')then
	vidas<="000";						-- CUIDADO ACTIVO NIVEL BAJO
elsif(rising_edge(clk))then
	vidas<=p_vidas;
end if;
end process;

comb:process(vidas,muere)
begin
	if(muere='1' and vidas="000")then 
		p_vidas<="001";
	elsif(muere='1' and vidas="001")then		--muere='1' and vidas="001"
		p_vidas<="011";
	elsif(muere='1' and vidas="011")then		--muere='1' and vidas="011"
		p_vidas<="111";
	else 
		p_vidas<=vidas;
	end if;
end process;

end Behavioral;