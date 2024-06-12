library ieee;
use ieee.std_logic_1164.all;

entity mux2_to_1 is
	port(
		D0, D1: in std_logic_vector(3 downto 0);
		sel: in std_logic;
		mux_out: out std_logic_vector(3 downto 0)
	);
end mux2_to_1;

architecture structure of mux2_to_1 is
begin

with sel select
	mux_out <= D0 when '0',
				  D1 when '1',
				  "0000" when others;
end structure;