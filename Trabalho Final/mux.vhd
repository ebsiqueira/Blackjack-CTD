library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux is
port (F1, F2, F3, F4: in std_logic;
		Controle: in std_logic_vector(1 downto 0);
		Saida: out std_logic
	);
end mux;

architecture circuito of mux is
begin
	saida <= F1 when Controle = "00" else
				F2 when Controle = "01" else
				F3 when Controle = "10" else
				F4;				
end circuito;