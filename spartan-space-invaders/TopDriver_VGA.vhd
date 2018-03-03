library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopDriver_VGA is

	Port ( clk : in STD_LOGIC;
			 reset : in STD_LOGIC;
 			 VS : out STD_LOGIC;
 			 HS : out STD_LOGIC;
			 RGB_in : in STD_LOGIC_VECTOR(2 downto 0);
			 pos_x : out STD_LOGIC_VECTOR(9 downto 0);
			 pos_y : out STD_LOGIC_VECTOR(9 downto 0);
 			 R : out STD_LOGIC;
 			 G : out STD_LOGIC;
 			 B : out STD_LOGIC);

end TopDriver_VGA;

----------------------------------------------------------------------------------------

architecture Behavioral of TopDriver_VGA is

component Divisor_VGA is
Port ( clk : in  STD_LOGIC;
       reset : in  STD_LOGIC;
       clk_pixel : inout  STD_LOGIC);
end component;

component ContH_VGA is
Generic (width:INTEGER:=10);
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           reset_s : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (width-1 downto 0));
end component;

component ContV_VGA is
Generic (width:INTEGER:=10);
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           reset_s : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (width-1 downto 0));
end component;

component CompH_VGA is
Generic (width: integer :=10;
			End_Of_Screen: integer :=639;
			Start_Of_Pulse: integer :=655;
			End_Of_Pulse: integer :=751;
			End_Of_Line: integer :=799);

Port ( clk : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 data : in STD_LOGIC_VECTOR (width-1 downto 0);
		 O1 : out STD_LOGIC;
		 O2 : out STD_LOGIC;
		 O3 : out STD_LOGIC);
end component;

component CompV_VGA is
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
end component;

component GenColor_VGA is
Port ( blank_h : in STD_LOGIC;
		 blank_v : in STD_LOGIC;
		 R_in : in STD_LOGIC;
		 G_in : in STD_LOGIC;
		 B_in : in STD_LOGIC;
		 R : out STD_LOGIC;
		 G : out STD_LOGIC;
		 B : out STD_LOGIC);
end component;

----------------------------------------------------------------------------------------

signal clk_pixel : STD_LOGIC;
signal clkpixel_and_o3h : STD_LOGIC;
signal signal_O1H,signal_O2H,signal_O3H : STD_LOGIC;
signal signal_O1V,signal_O2V,signal_O3V : STD_LOGIC;
--signal sigR,sigG,sigB : STD_LOGIC;
signal rgb_gen : STD_LOGIC_VECTOR(2 downto 0);
signal pos_xs, pos_ys : STD_LOGIC_VECTOR(9 downto 0);

----------------------------------------------------------------------------------------

begin

clkpixel_and_o3h<=signal_O3H and clk_pixel;

DivVGA: Divisor_VGA
port map(
	clk=>clk,
	reset=>reset,
	clk_pixel=>clk_pixel);


ContHVGA: ContH_VGA
port map(
	enable=>clk_pixel,
	reset_s=>signal_O3H,
	clk=>clk,
	reset=>reset,
	Q=>pos_xs);
	
ContVVGA: ContV_VGA
port map(
	enable=>clkpixel_and_o3h,
	reset=>reset,
	clk=>clk,
	reset_s=>signal_O3V,
	Q=>pos_ys);
	
CompHVGA: CompH_VGA
port map(
	clk=>clk,
	reset=>reset,
	data=>pos_xs,
	O1=>signal_O1H,
	O2=>signal_O2H,
	O3=>signal_O3H);

CompVVGA: CompV_VGA
port map(
	clk=>clk,
	reset=>reset,
	data=>pos_ys,
	O1=>signal_O1V,
	O2=>signal_O2V,
	O3=>signal_O3V);

GenColorVGA: GenColor_VGA
port map(
	blank_h=>signal_O1H,
	blank_v=>signal_O1V,
	R_in=>rgb_gen(2),
	G_in=>rgb_gen(1),
	B_in=>rgb_gen(0),
	R=>R,
	G=>G,
	B=>B);

HS<=signal_O2H;
VS<=signal_O2V;
rgb_gen<=rgb_in;
pos_x<=pos_xs;
pos_y<=pos_ys;

end Behavioral;