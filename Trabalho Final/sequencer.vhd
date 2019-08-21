library ieee;
use ieee.std_logic_1164.all;
entity sequencer is port(
		clock: in std_logic;
		reset: in std_logic;
		enable: in std_logic;
		saida: out std_logic_vector(3 downto 0)
);
end sequencer;
architecture bhv of sequencer is
type STATES is (E0, E1, E2, E3, E4, E5, E6, E7, E8, E9, E10, E11, E12, E13, E14, E15, E16, E17, E18, E19);
signal EA, PE: STATES;
begin

	P1: process(clock, reset)
	begin
		if reset= '1' then
			EA <= E0;
		elsif clock'event and clock= '0' then
			EA <= PE;
		end if;
	end process;
	
	P2: process(EA)
	begin
		case EA is
			when E0 =>
				saida <= "1011";
				if enable='1' then
					PE <= E1;
				end if;
			when E1 =>
				saida <= "1010";
				if enable='1' then
					PE <= E2;
				end if;
			when E2 =>
				saida <= "1110";
				if enable='1' then
					PE <= E3;
				end if;
			when E3 =>
				saida <= "0101";
				if enable='1' then
					PE <= E4;
				end if;
			when E4 =>
				saida <= "0011";
				if enable='1' then
					PE <= E5;
				end if;
			when E5 =>
				saida <= "0110";
				if enable='1' then
					PE <= E6;
				end if;
			when E6 =>
				saida <= "0000";
				if enable='1' then
					PE <= E7;
				end if;
			when E7 =>
				saida <= "1001";
				if enable='1' then
					PE <= E8;
				end if;
			when E8 =>
				saida <= "1100";
				if enable='1' then
					PE <= E9;
				end if;
			when E9 =>
				saida <= "0111";
				if enable='1' then
					PE <= E10;
				end if;
			when E10 =>
				saida <= "0010";
				if enable='1' then
					PE <= E11;
				end if;
			when E11 =>
				saida <= "1000";
				if enable='1' then
					PE <= E12;
				end if;
			when E12 =>
				saida <= "0100";
				if enable='1' then
					PE <= E13;
				end if;
			when E13 =>
				saida <= "1101";
				if enable='1' then
					PE <= E14;
				end if;
			when E14 =>
				saida <= "0001";
				if enable='1' then
					PE <= E15;
				end if;
			when E15 =>
				saida <= "1111";
				if enable='1' then
					PE <= E16;
				end if;
			when E16 =>
				saida <= "1011";
				if enable='1' then
					PE <= E17;
				end if;
			when E17 =>
				saida <= "1100";
				if enable='1' then
					PE <= E18;
				end if;
			when E18 =>
				saida <= "0010";
				if enable='1' then
					PE <= E19;
				end if;
			when E19 =>
				saida <= "0100";
				if enable='1' then
					PE <= E0;
				end if;
		end case;
	end process;
end bhv;