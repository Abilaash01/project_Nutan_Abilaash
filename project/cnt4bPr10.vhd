library ieee;
use ieee.std_logic_1164.all;

entity cnt4bPr10 is
	port(
		i_clk, i_enable, i_resetBar: in std_logic;
		o_clk, o_clk0: out std_logic
	);
end cnt4bPr10;

architecture structure of cnt4bPr10 is
	signal int_q0a, int_q1a, int_q2a, int_q3a, int_q0b, int_q1b, int_q2b, int_q3b : std_logic;

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
		i_preset => '1',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_q => int_q2a,
		o_qBAR => open
	);

	int_q2b <= int_q2a and int_q1b;

t3: enAPRtFF
	port map(
		i_T => int_q2b,
		i_clock => i_clk,
		i_preset => '0',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_q => int_q3a,
		o_qBAR => open
	);

	int_q3b <= int_q3a and int_q2b;

	o_clk <= (int_q3a and int_q2a)and (int_q1a and int_q0a);
	o_clk0 <= (not(int_q3a) and not(int_q2a)) and (not(int_q1a) and not(int_q0a));

end structure;
