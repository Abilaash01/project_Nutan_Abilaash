LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Decoder3to8UART IS
	PORT(
		i_addr		: IN	STD_LOGIC_VECTOR(2 downto 0);
		o_addr		: OUT	STD_LOGIC_VECTOR(7 downto 0)
	);
END Decoder3to8UART;

ARCHITECTURE rtl OF Decoder3to8UART IS

BEGIN

	o_addr(7) <= (not(i_addr(0))) and ((not(i_addr(1)))and(not(i_addr(2))));
	o_addr(6) <= (i_addr(0)) and ((not(i_addr(1)))and(not(i_addr(2))));
	o_addr(5) <= '0';
	o_addr(4) <= '0';
	o_addr(3) <= '0';
	o_addr(2) <= '0';
	o_addr(1) <= (i_addr(0)) and ((not(i_addr(1)))and(not(i_addr(2))));
	o_addr(0) <= (i_addr(0)) and ((not(i_addr(1)))and(not(i_addr(2))));

END rtl;
