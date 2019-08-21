library IEEE;
use IEEE.Std_Logic_1164.all;

entity logica is
port (end_game: in std_logic;
		U0_POINT, U1_POINT: in std_logic_vector(5 downto 0);
		WIN_POINT0, WIN_POINT1: out std_logic
	);
end logica;

architecture circuito of logica is
begin
	WIN_POINT0 <= '1' when U0_POINT >= U1_POINT and end_game = '1' else
				'0';
	WIN_POINT1 <= '1' when U1_POINT > U0_POINT and end_game = '1' else
				'0';				
end circuito;