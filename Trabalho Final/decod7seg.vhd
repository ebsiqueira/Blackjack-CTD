library IEEE;
use IEEE.Std_Logic_1164.all;

entity decod7seg is
port (Entrada: in std_logic_vector(3 downto 0);
	Saida: out std_logic_vector(6 downto 0)
	);
end decod7seg;

architecture circuito of decod7seg is
begin
	Saida <= "1000000" when Entrada = "0000" else
				"1111001" when Entrada = "0001" else
				"0100100" when Entrada = "0010" else
				"0110000" when Entrada = "0011" else
				"0011001" when Entrada = "0100" else
				"0010010" when Entrada = "0101" else
				"0000010" when Entrada = "0110" else
				"1111000" when Entrada = "0111" else
				"0000000" when Entrada = "1000" else
				"0010000" when Entrada = "1001" else
				"0001000" when Entrada = "1010" else
				"0000011" when Entrada = "1011" else
				"0100111" when Entrada = "1100" else
				"0100001" when Entrada = "1101" else
				"0000110" when Entrada = "1110" else
				"0001110";
				
end circuito;