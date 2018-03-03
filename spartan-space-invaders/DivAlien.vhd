library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity DivAlien is
	Generic(limite : STD_LOGIC_VECTOR(23 downto 0) := "111111111111111111111111");
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           vel : out  STD_LOGIC);
end DivAlien;

architecture Behavioral of DivAlien is

signal cuenta,p_cuenta: STD_LOGIC_VECTOR(23 downto 0);

begin

	sinc:process(reset,clk)
	begin
		if(reset='1')then
			cuenta<="000000000000000000000000";
		elsif(rising_edge(clk))then
			cuenta<=p_cuenta;
		end if;
	end process;

	comb:process(cuenta)
	begin
		if(cuenta=limite)then 
			vel<='1';
			p_cuenta<="000000000000000000000000"; 
		else
			vel<='0';
			p_cuenta<=cuenta+1;
		end if;
	end process;
	
end Behavioral;