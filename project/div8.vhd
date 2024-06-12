library ieee;
use ieee.std_logic_1164.all;

entity div8 is
	port(
		i_clk, i_enable, i_resetBar	:in	std_logic;
		o_clk	:out	std_logic
	);
end div8;

architecture structure of div8 is
	signal int_q0a, int_q1a, int_q2a, int_q0b, int_q1b, int_q2b: std_logic;

	component enAPRtFF
		PORT(
			i_T, i_clock, i_preset, i_resetBar, i_enable: in std_logic;
			o_q, o_qBAR: out std_logic
		);
	end component;

begin

t0: enAPRtFF
	port map(
		i_T => '1',
		i_clock => i_clk,
		i_preset => '0',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_q => int_q0a,
		o_qBAR => open
	);

	int_q0b <= int_q0a;

t1: enAPRtFF
	port map(
		i_T => int_q0b,
		i_clock => i_clk,
		i_preset => '0',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_q => int_q1a,
		o_qBAR => open
	);

	int_q1b <= int_q1a and int_q0b;

t2: enAPRtFF
	port map(
		i_T => int_q1b,
		i_clock => i_clk,
		i_preset => '0',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_q => int_q2a,
		o_qBAR => open
	);

	int_q2b <= int_q2a and int_q1b;
	o_clk <= (int_q2b and int_q1b)and int_q0b;

end structure;