library IEEE;
use IEEE.Std_Logic_1164.all;

entity topo is
port (CLOCK_50: in std_logic;
		KEY: in std_logic_vector(3 downto 0);
		SW: in std_logic_vector(9 downto 0);
		
		HEX5, HEX4, HEX3, HEX2, HEX1, HEX0: out std_logic_vector(6 downto 0);
		
		LEDR: out std_logic_vector(9 downto 0)
	);
end topo;

architecture circuito of topo is

component ButtonSync is
port (
		-- Input ports
		key0	: in  std_logic;
		key1	: in  std_logic;
		key2	: in  std_logic;
		key3	: in  std_logic;	
		clk : in std_logic;
		-- Output ports
		btn0	: out std_logic;
		btn1	: out std_logic;
		btn2	: out std_logic;
		btn3	: out std_logic
	);
end component;

component datapath is
port (Relogio_50: in std_logic;
		stop: in std_logic;
		Chaves: in std_logic_vector(9 downto 0);
		
		Dis5: out std_logic_vector(6 downto 0);
		Dis4: out std_logic_vector(6 downto 0);
		Dis3: out std_logic_vector(6 downto 0);
		Dis2: out std_logic_vector(6 downto 0);
		Dis1: out std_logic_vector(6 downto 0);
		Dis0: out std_logic_vector(6 downto 0);
		
		SEL: in std_logic_vector(1 downto 0);
		R1, R2, E1, E2, E3, E4: in std_logic;
		overflow, end_game, end_time, win0, win1: out std_logic;
		
		Lampadas: out std_logic_vector(9 downto 0)

	);
end component;

component controle is port(
	overflow: in std_logic;
	endgame: in std_logic;
	endtime: in std_logic;
	win0: in std_logic;
	win1: in std_logic;
	stopfsm: in std_logic;
	clock: in std_logic;
	enter: in std_logic;
	reset: in std_logic;
	R2_fsm: out std_logic;
	R1_fsm: out std_logic;
	K1: out std_logic;
	K2: out std_logic;
	K3: out std_logic;
	K4: out std_logic;
	Sel: out std_logic_vector (1 downto 0)
	);
end component;
signal R1, R2, E1, E2, E3, E4, overflow, end_game, end_time, win0, win1, stop: std_logic;
signal SEL: std_logic_vector(1 downto 0);
signal BTN: std_logic_vector(3 downto 0);
begin
		stop <= BTN(2);
		AUX0: ButtonSync port map(KEY(0), KEY(1), KEY(2), KEY(3), CLOCK_50, BTN(0), BTN(1), BTN(2), BTN(3));
		Ctrl: controle port map(overflow, end_game, end_time, win0, win1, stop, CLOCK_50,  BTN(1), BTN(0), R2, R1, E1, E2, E3, E4, SEL(1 downto 0));
		DP: datapath port map(CLOCK_50, stop, SW(9 downto 0), HEX5(6 downto 0), HEX4(6 downto 0), HEX3(6 downto 0), HEX2(6 downto 0), HEX1(6 downto 0), HEX0(6 downto 0), SEL(1 downto 0), R1, R2, E1, E2, E3, E4 , overflow, end_game, end_time, win0, win1, LEDR(9 downto 0));
end circuito;