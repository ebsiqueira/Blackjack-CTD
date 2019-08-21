library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity comp is
port (entrada: in std_logic_vector(5 downto 0);
		saida: out std_logic
		);
end comp;

architecture circuito of comp is
begin
	saida <= '1' when entrada > "11100" else '0';
end circuito;