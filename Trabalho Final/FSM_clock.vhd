library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity FSM_clock is
	port ( reset: in std_logic;
		enable: in std_logic;
		clock: in std_logic;
		saida: out std_logic_vector(4 downto 0)
		);
end FSM_clock;

architecture topo_beh of FSM_clock is
signal contador0: std_logic_vector(27 downto 0);
signal contador1: std_logic_vector(27 downto 0);
signal contador2: std_logic_vector(27 downto 0);
signal contador3: std_logic_vector(27 downto 0);
signal contador4: std_logic_vector(27 downto 0);
-- registra valor da contagem

begin

P1: process(clock, reset, contador0, contador1, contador2, contador3, contador4, enable)
	begin
			if reset= '1' then
				contador0 <= x"0000000";
				contador1 <= x"0000000";
				contador2 <= x"0000000";
				contador3 <= x"0000000";
				contador4 <= x"0000000";
		elsif clock'event and clock= '1' then
			if enable= '1' then 
				contador0 <= contador0 + 1;
					if contador0 = x"5F5E0FF" then
						contador0 <= x"0000000";
						saida(0) <= '1';
					else
						saida(0) <= '0';
					end if;
				
				contador1 <= contador1 + 1;
					if contador1 = x"2FAF07F" then
						contador1 <= x"0000000";
						saida(1) <= '1';
					else
						saida(1) <= '0';
					end if;
				
				contador2 <= contador2 + 1;
					if contador2 = x"17D783F" then
						contador2 <= x"0000000";
						saida(2) <= '1';
					else
						saida(2) <= '0';
					end if;
				
				contador3 <= contador3 + 1;
					if contador3 = x"BEBC1F" then
						contador3 <= x"0000000";
						saida(3) <= '1';
					else
						saida(3) <= '0';
					end if;
				
				contador4 <= contador4 + 1;
					if contador4 = x"4C4B3F" then
						contador4 <= x"0000000";
						saida(4) <= '1';
					else
						saida(4) <= '0';
					end if;
				
			end if;
		end if;
	end process;
end topo_beh;