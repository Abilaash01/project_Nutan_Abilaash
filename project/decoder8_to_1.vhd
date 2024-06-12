library ieee;
use ieee.std_logic_1164.all;

entity decoder8_to_1 is
	PORT(
		i_addr		: in	STD_LOGIC_VECTOR(2 downto 0);
		o_addr		: out	STD_LOGIC_VECTOR(7 downto 0)
	);
end decoder8_to_1;

architecture rtl of decoder8_to_1 is
begin

	o_addr(0) <= (not(i_addr(0))) and ((not(i_addr(1)))and(not(i_addr(2))));
	o_addr(1) <= (i_addr(0)) and ((not(i_addr(1)))and(not(i_addr(2))));
	o_addr(2) <= (not(i_addr(0))) and ((i_addr(1))and(not(i_addr(2))));
	o_addr(3) <= (i_addr(0)) and ((i_addr(1))and(not(i_addr(2))));
	o_addr(4) <= (not(i_addr(0))) and ((not(i_addr(1)))and(i_addr(2)));
	o_addr(5) <= (i_addr(0)) and ((not(i_addr(1)))and(i_addr(2)));
	o_addr(6) <= (not(i_addr(0))) and ((i_addr(1))and(i_addr(2)));
	o_addr(7) <= (i_addr(0)) and ((i_addr(1))and(i_addr(2)));

end rtl;
