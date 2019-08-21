library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity decbcd is
port (entrada: in std_logic_vector(5 downto 0);
		saida: out std_logic_vector(7 downto 0)
		);
end decbcd;

architecture circuito of decbcd is
signal aux, saidaAux: std_logic_vector(7 downto 0);
begin
		P1: process(entrada, saidaAux, aux)
		begin
				aux <= "00"&entrada;
				if aux >= "00101000" then 
					saidaAux(7 downto 4) <= "0100";
					aux <= aux - "00101000";
					saidaAux(3 downto 0) <= aux(3 downto 0);
				elsif aux >= "00011110" then
					saidaAux(7 downto 4) <= "0011";
					aux <= aux - "00011110";
					saidaAux(3 downto 0) <= aux(3 downto 0);
				elsif aux >= "00010100" then
					saidaAux(7 downto 4) <= "0010";
					aux <= aux - "00010100";
					saidaAux(3 downto 0) <= aux(3 downto 0);
				elsif aux >= "00001010" then
					saidaAux(7 downto 4) <= "0001";
					aux <= aux - "00001010";
					saidaAux(3 downto 0) <= aux(3 downto 0);
				else
					saidaAux(7 downto 4) <= "0000";
					saidaAux(3 downto 0) <= aux(3 downto 0);
				end if;
		end process;
		saida <= saidaAux;
end circuito;