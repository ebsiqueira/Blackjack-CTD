library ieee;
use ieee.std_logic_1164.all;

entity reg is port (
	CLK, RST: in std_logic;
	D: in std_logic_vector(1 downto 0);
	Q: out std_logic_vector(1 downto 0);
	EN: in std_logic
	);
end reg;

architecture behv of reg is
begin
	process(CLK, D, RST, EN)
	begin
		if RST = '0' then
			Q <= "00"; 
		elsif (CLK'event and CLK = '1') then
			if EN = '0' then
				Q <= D;
			end if;
		end if;
	end process;
end behv;