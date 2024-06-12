library ieee;
use ieee.std_logic_1164.all;

entity BINtoBCDConv is 
	port(
		i_bin: in std_logic_vector(3 downto 0);
		o_bcd: out std_logic_vector(4 downto 0)
	);
end BINtoBCDConv;

architecture structure of BINtoBCDConv is
begin

	o_bcd(0) <= i_bin(0);
	o_bcd(4) <= ((i_bin(3)) and (i_bin(2))) or ((i_bin(3)) and (i_bin(1)));
	o_bcd(3) <= ((i_bin(3)) and (not(i_bin(2)))) and (not(i_bin(1)));
	o_bcd(2) <= ((not(i_bin(3))) and (i_bin(2))) or ((i_bin(2)) and (i_bin(1)));
	o_bcd(1) <= (((i_bin(3)) and (i_bin(2))) and (not(i_bin(1)))) or ((not(i_bin(3))) and (i_bin(1)));

end structure;