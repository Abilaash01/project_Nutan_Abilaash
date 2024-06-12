library ieee;
use ieee.std_logic_1164.all;

entity enaprJKFF is
		port(
		i_J, i_K, i_clock, i_pre, i_clr, i_enable: in std_logic;
		o_q, o_qBAR: out std_logic
	);

end enaprJKFF;

architecture structure of enaprJKFF is
	signal int_q, int_qBAR, int_nandJ, int_nandK: std_logic;
begin
	
	int_nandJ <= (i_J) nand ((i_clock) and (int_qBAR));
	int_nandK <= (i_K) nand ((i_clock) and (int_q));

	int_q <= (int_nandJ) nand ((i_pre) and (int_qBAR));
	int_qBAR <= (int_nandK) nand ((i_clr) and (int_q));

	o_q <= int_q;
	o_qBAR <= int_qBAR;

end structure;
