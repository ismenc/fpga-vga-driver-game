library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopVidas is
port(	clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		desap : in STD_LOGIC;
		pos_x : in STD_LOGIC_VECTOR(9 downto 0);		
		pos_y : in STD_LOGIC_VECTOR(9 downto 0);
		rgb_nave : in STD_LOGIC_VECTOR(2 downto 0);
		rgb_alien : in STD_LOGIC_VECTOR(2 downto 0);
		rgb_bala_alien : in STD_LOGIC_VECTOR(2 downto 0);
		cl : out STD_LOGIC;
		rst : out STD_LOGIC;
		rst_ba : out STD_LOGIC;
		muerto : out STD_LOGIC;
		rgb : out STD_LOGIC_VECTOR(2 downto 0)
		);
end TopVidas;

architecture Behavioral of TopVidas is

component DivVidas is
	Generic(limite : STD_LOGIC_VECTOR(23 downto 0));
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           vel : out  STD_LOGIC);
end component;

component Impact is
port (rgb_nave : in STD_LOGIC_VECTOR(2 downto 0);
		rgb_bala_alien : in STD_LOGIC_VECTOR(2 downto 0);
		rgb_alien : in STD_LOGIC_VECTOR(2 downto 0);
		muere : out STD_LOGIC;
		rst_ba : out STD_LOGIC
		);
end component;

component ContVidas is
Port (clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		muere : in STD_LOGIC;
		--muerto : out STD_LOGIC;				MUERTO SE PUEDE HACER CON UNA AND NEGADA DE VIDAS
		vidas : inout STD_LOGIC_VECTOR(2 downto 0)
		);
end component;

component BlinkVidas is
port(clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		desap : in STD_LOGIC;
		vel : in STD_LOGIC;
		vidas : in STD_LOGIC_VECTOR(2 downto 0);
		cl : out STD_LOGIC;
		rst : out STD_LOGIC
		);
end component;

component DIBgenerico is
port(	clear : in STD_LOGIC;
		pos_x : in STD_LOGIC_VECTOR(9 downto 0);		-- Por donde va dibujando en pantalla
		pos_y : in STD_LOGIC_VECTOR(9 downto 0);
		xdib : in STD_LOGIC_VECTOR(9 downto 0);		-- Donde se tié que pintar el dibujo (llega de bloque movimiento)
		ydib : in STD_LOGIC_VECTOR(9 downto 0);
		DIR : out STD_LOGIC_VECTOR(9 downto 0));
end component;

component Corazon is
Port ( CLKA : in STD_LOGIC;
			ADDRA : in STD_LOGIC_VECTOR(9 downto 0);
			DOUTA : out STD_LOGIC_VECTOR(2 downto 0));
end component;

component FaltaCorazon is
Port ( CLKA : in STD_LOGIC;
			ADDRA : in STD_LOGIC_VECTOR(9 downto 0);
			DOUTA : out STD_LOGIC_VECTOR(2 downto 0));
end component;

--------------------------------------------------------------------------------------------------

signal vels,vols,mueres,cls : STD_LOGIC;
signal DIRS, DIRS1, DIRS2, DIRS3 : STD_LOGIC_VECTOR(9 downto 0);
signal vidass, rgb_cor, rgb_falta : STD_LOGIC_VECTOR(2 downto 0);

--------------------------------------------------------------------------------------------------

begin

DivisorVelVidas: DivVidas
Generic map(limite => "000000000000000000011111")
	Port map(clk=>clk,
				reset=>reset,
				vel=>vols);
				
DivisorVidas: DivVidas
Generic map(limite => "000000001111111111111111")
	Port map(clk=>vols,
				reset=>reset,
				vel=>vels);

Impacto: Impact
	Port map(rgb_alien=>rgb_alien,
				rgb_bala_alien=>rgb_bala_alien,
				rgb_nave=>rgb_alien,
				muere=>mueres,
				rst_ba=>rst_ba
				);

ContadorVidas: ContVidas
	Port map(clk=>clk,
				reset=>reset,
				muere=>mueres,
				vidas=>vidass
				);

ParpaedoVidas: BlinkVidas
	Port map(clk=>clk,
				reset=>reset,
				desap=>desap,
				vel=>vels,
				vidas=>vidass,
				cl=>cls,
				rst=>rst);

DibujaVidas1: DIBgenerico
	Port map(clear=>cls,
				pos_x=>pos_x,
				pos_y=>pos_y,
				xdib=>"0000000000",
				ydib=>"0111000000",
				DIR=>DIRS1);

DibujaVidas2: DIBgenerico
	Port map(clear=>cls,
				pos_x=>pos_x,
				pos_y=>pos_y,
				xdib=>"0000010001",
				ydib=>"0111000000",
				DIR=>DIRS2);
				
DibujaVidas3: DIBgenerico
	Port map(clear=>cls,
				pos_x=>pos_x,
				pos_y=>pos_y,
				xdib=>"0000100010",
				ydib=>"0111000000",
				DIR=>DIRS3);
				
MemoriaCorazon: Corazon
	Port map(CLKA=>clk,
				ADDRA=>DIRS,
				DOUTA=>rgb_cor);
	
MemoriaFaltaCorazon: FaltaCorazon
	Port map(CLKA=>clk,
				ADDRA=>DIRS,
				DOUTA=>rgb_falta);

cl<=cls;

muerto<= not(vidass(0) and vidass(1) and vidass(2));
DIRS<=DIRS1 OR DIRS2 OR DIRS3;

process(clk,vidass,pos_x,pos_y)
begin
	if(rising_edge(clk))then
		if(pos_x<"0000010001" and vidass(0)='0')then
			rgb<=rgb_cor;
		else
			rgb<=rgb_falta;
		end if;
		if(pos_x>="0000010001" and pos_x<"0000100010" and vidass(1)='0')then
			rgb<=rgb_cor;
		else
			rgb<=rgb_falta;
		end if;
		if(pos_x>"0000010001" and vidass(2)='0')then
			rgb<=rgb_cor;
		else
			rgb<=rgb_falta;
		end if;
	end if;
end process;

end Behavioral;