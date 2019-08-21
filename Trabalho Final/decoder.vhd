library ieee;
use ieee.std_logic_1164.all;

entity decoder is port (
	TEMPO: in std_logic_vector(3 downto 0);
	Saida: out std_logic_vector(9 downto 0)
	);
end decoder;

architecture behv of decoder is
begin
	Saida <= "1111111111" when TEMPO = "0000" else
				"0111111111" when TEMPO = "0001" else
				"0011111111" when TEMPO = "0010" else
				"0001111111" when TEMPO = "0011" else
				"0000111111" when TEMPO = "0100" else
				"0000011111" when TEMPO = "0101" else
				"0000001111" when TEMPO = "0110" else
				"0000000111" when TEMPO = "0111" else
				"0000000011" when TEMPO = "1000" else
				"0000000001";
				
end behv;