library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Counter_round is
port (reset: in std_logic;
		enable: in std_logic;
		clock: in std_logic;
		saida: out std_logic_vector(3 downto 0);
		end_game: out std_logic 
		);
end Counter_round;

architecture circuito of Counter_round is
signal contagem: std_logic_vector(3 downto 0);
begin
		P1: process(clock, reset, enable, contagem)
		begin
				if reset = '1' then 
					contagem <= "0000";
				elsif clock'event and clock= '1' then
					if enable = '1' then
						contagem <= contagem + 1;
						if(contagem = "0111") then
							end_game <= '1';
							contagem <= "0000";--tirar dps pq sera resetado pelo controle
						else 
							end_game <= '0';
						end if;
					end if;
				end if;
		end process;
		saida <= contagem;
end circuito;