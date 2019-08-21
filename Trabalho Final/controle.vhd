library ieee;
use ieee.std_logic_1164.all;

entity controle is port(
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
end controle;
architecture circuito of controle is
	type STATES is (E0, E1, E2, E3, E4, E5, E6);
		signal EA, PE: STATES;
	   begin
			P1: process(clock, reset)
				begin
					if reset = '0' then
						EA <= E0;
					elsif clock'event and clock = '1' then
						EA <= PE;
					end if;
					end process;
					
			P2: process(EA, enter, stopfsm, overflow, endgame, endtime, win0, win1)
				begin
					case EA is
						when E0 => R2_fsm <= '1'; R1_fsm <= '1'; K1 <= '0'; K2 <= '0'; K3 <= '0'; K4 <= '0'; Sel <= "00"; --init
							if (enter = '1') then PE <= E0; else PE <= E1; end if; 
						when E1 => R2_fsm <= '0'; R1_fsm <= '0'; K1 <= '0'; K2 <= '1'; K3 <= '0'; K4 <= '0'; Sel <= "01"; --setup
							if (enter = '1') then PE <= E1; else PE <= E2; end if;
						when E2 => R2_fsm <= '0'; R1_fsm <= '0'; K1 <= '1'; K2 <= '0'; K3 <= '0'; K4 <= '1'; Sel <= "10"; --play
							if endtime = '1' then PE <= E6; elsif stopfsm = '0' then PE <= E3; else PE <= E2; end if;
						when E3 => R2_fsm <= '0'; R1_fsm <= '0'; K1 <= '1'; K2 <= '0'; K3 <= '0'; K4 <= '0'; Sel <= "10"; --Check
							if (win0 = '1') or (win1 = '1') or (overflow = '1') or (endgame = '1') then PE <= E6; else PE <= E4; end if;
						when E4 => R2_fsm <= '1'; R1_fsm <= '0'; K1 <= '1'; K2 <= '0'; K3 <= '1'; K4 <= '0'; Sel <= "10"; --Next_round
							PE <= E5;
						when E5 => R2_fsm <= '0'; R1_fsm <= '0'; K1 <= '1'; K2 <= '0'; K3 <= '0'; K4 <= '0'; Sel <= "10"; --wait
							if (enter = '1') then PE <= E5; else PE <= E2; end if;
						when E6 => R2_fsm <= '0'; R1_fsm <= '0'; K1 <= '0'; K2 <= '0'; K3 <= '0'; K4 <= '0'; Sel <= "11"; --result
							if (enter = '1') then PE <= E6; else PE <= E0; end if;
					end case;
			end process;
end circuito;