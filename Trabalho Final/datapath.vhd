library IEEE;
use IEEE.Std_Logic_1164.all;

entity datapath is
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
end datapath;

architecture circuito of datapath is
component decod7seg is
port (Entrada: in std_logic_vector(3 downto 0);
		Saida: out std_logic_vector(6 downto 0)
	);
end component;

component decoder is 
port (
	TEMPO: in std_logic_vector(3 downto 0);
	Saida: out std_logic_vector(9 downto 0)
	);
end component;

component FSM_clock is
        port ( reset: in std_logic;
					enable: in std_logic;
               clock: in std_logic;
               saida: out std_logic_vector(4 downto 0)
              );
end component;

component reg is 
port(
	CLK, RST: in std_logic;
	D: in std_logic_vector(1 downto 0);
	Q: out std_logic_vector(1 downto 0);
	EN: in std_logic
	);
end component;

component Counter_Time is
port (reset: in std_logic;
		enable: in std_logic;
		clock: in std_logic;
		saida: out std_logic_vector(3 downto 0);
		end_time: out std_logic 
		);
end component;

component mux is
port (F1, F2, F3, F4: in std_logic;
		Controle: in std_logic_vector(1 downto 0);
		Saida: out std_logic
	);
end component;

component Counter_round is
port (reset: in std_logic;
		enable: in std_logic;
		clock: in std_logic;
		saida: out std_logic_vector(3 downto 0);
		end_game: out std_logic 
		);
end component;

component sequencer is port(
		clock: in std_logic;
		reset: in std_logic;
		enable: in std_logic;
		saida: out std_logic_vector(3 downto 0)
);
end component;

component Counter_point is
port (data: in std_logic_vector(3 downto 0);
		reset: in std_logic;
		enable: in std_logic;
		clock: in std_logic;
		saida: out std_logic_vector(5 downto 0);
		end_game: out std_logic
		);
end component;

component comp is
port (entrada: in std_logic_vector(5 downto 0);
		saida: out std_logic
		);
end component;

component mux7 is
port (F1, F2, F3, F4: in std_logic_vector(6 downto 0);
		Controle: in std_logic_vector(1 downto 0);
		Saida: out std_logic_vector(6 downto 0)
	);
end component;

component logica is
port (end_game: in std_logic;
		U0_POINT, U1_POINT: in std_logic_vector(5 downto 0);
		WIN_POINT0, WIN_POINT1: out std_logic
	);
end component;

component decbcd is
port (entrada: in std_logic_vector(5 downto 0);
		saida: out std_logic_vector(7 downto 0)
		);
end component;

signal clockHZ,fim_jogo, OVERF1, OVERF0, USER, U1_29, U0_29, WIN_POINT0, WIN_POINT1: std_logic;
signal Level: std_logic_vector(1 downto 0);
signal Tempo, Round, Hexseq: std_logic_vector(3 downto 0);
signal clocks: std_logic_vector(4 downto 0);
signal U1_POINT, U0_POINT: std_logic_vector(5 downto 0);
signal display0A, display0B, display1, display2, display3, display4A, display4B, display5: std_logic_vector(6 downto 0);
signal U0_POINT_BCD, U1_POINT_BCD: std_logic_vector(7 downto 0);

begin		
		USER <= Round(0);
		
		AUX1: FSM_clock port map (R1, E1, Relogio_50, clocks);	
		AUX2: Counter_Time port map (R2, E4, clocks(1), Tempo, end_time);
		AUX3: decoder port map (Tempo, Lampadas(9 downto 0));
		AUX4: mux port map (clocks(1), clocks(2), clocks(3), clocks(4), Level, clockHZ);		
		AUX5: sequencer port map (clockHZ, R1, E4 and stop, Hexseq);		
		AUX6: decod7seg port map (Hexseq, display5);		
		AUX7: reg port map (Relogio_50, R1, Chaves(1 downto 0), Level, E2);		
		AUX8: Counter_round port map (R1, E3, Relogio_50, Round, fim_jogo);		
		AUX9: Counter_point port map (Hexseq, R1, USER and E3, Relogio_50, U1_POINT, U1_29);		
		AUX10: Counter_point port map (Hexseq, R1, not USER and E3, Relogio_50, U0_POINT, U0_29);		
		AUX11: comp port map (U1_POINT, OVERF1);		
		AUX12: comp port map (U0_POINT, OVERF0);		
		AUX13: logica port map (fim_jogo, U1_POINT, U0_POINT, WIN_POINT0, WIN_POINT1);
		AUX14: decbcd port map (U0_POINT, U0_POINT_BCD);
		AUX15: decbcd port map (U1_POINT, U1_POINT_BCD);
		AUX16: decod7seg port map (Round, display4A);
		AUX17: decod7seg port map ("000"&WIN_POINT1, display4B);
		AUX18: decod7seg port map (U0_POINT_BCD(7 downto 4), display3);
		AUX19: decod7seg port map (U0_POINT_BCD(3 downto 0), display2);
		AUX20: decod7seg port map (U1_POINT_BCD(7 downto 4), display1);
		AUX21: decod7seg port map ("00"&Level, display0A);
		AUX22: decod7seg port map (U0_POINT_BCD(3 downto 0), display0B);
		AUX23: mux7 port map ("1111111", "1110001", display5, "1000001", SEL, dis5);
		AUX24: mux7 port map ("0100100", "0110000", display4A, display4B, SEL, dis4);
		AUX25: mux7 port map ("1110000", "1100011", display3, display3, SEL, dis3);
		AUX26: mux7 port map ("0001000", "0110000", display2, display2, SEL, dis2);
		AUX27: mux7 port map ("1111010", "1110001", display1, display1, SEL, dis1);
		AUX28: mux7 port map ("1110000", display0A, display0B, display0B, SEL, dis0);
		
		end_game <= fim_jogo;
end circuito;