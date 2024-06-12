library ieee;
use ieee.std_logic_1164.all;

entity clkDiv41 is
	port(
		i_clk, i_enable, i_resetBar	:in	std_logic;
		o_clk	:out	std_logic
	);
end clkDiv41;

architecture structure of clkDiv41 is
	signal int_q0, int_q1, int_q2, int_q3, int_q4, int_q5, int_q0BAR, int_q1BAR, int_q2BAR, int_q3BAR, int_q4BAR, int_q5BAR : std_logic;
	signal int_resetBar: std_logic;

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
		i_preset => '1' or not(i_resetBar),
		i_resetBar => int_resetBar,
		i_enable => i_enable,
		o_qBAR => int_q0BAR,
		o_q => int_q0
	);

t1: enAPRtFF
	port map(
		i_T => '1',
		i_clock => int_q0BAR,
		i_preset => '1' or not(i_resetBar),
		i_resetBar => int_resetBar,
		i_enable => i_enable,
		o_qBAR => int_q1BAR,
		o_q => int_q1
	);

t2: enAPRtFF
	port map(
		i_T => '1',
		i_clock => int_q1BAR,
		i_preset => '1' or not(i_resetBar),
		i_resetBar => int_resetBar,
		i_enable => i_enable,
		o_qBAR => int_q2BAR,
		o_q => int_q2
	);

t3: enAPRtFF
	port map(
		i_T => '1',
		i_clock => int_q2BAR,
		i_preset => '0' or not(i_resetBar),
		i_resetBar => int_resetBar,
		i_enable => i_enable,
		o_qBAR => int_q3BAR,
		o_q => int_q3
	);

t4: enAPRtFF
	port map(
		i_T => '1',
		i_clock => int_q3BAR,
		i_preset => '1' or not(i_resetBar),
		i_resetBar => int_resetBar,
		i_enable => i_enable,
		o_qBAR => int_q4BAR,
		o_q => int_q4
	);

t5: enAPRtFF
	port map(
		i_T => '1',
		i_clock => int_q4BAR,
		i_preset => '0' or not(i_resetBar),
		i_resetBar => int_resetBar,
		i_enable => i_enable,
		o_qBAR => int_q5BAR,
		o_q => int_q5
	);

	int_resetBar <= i_resetBar and ((((int_q0 or int_q1) or (int_q2 or int_q3)) or (int_q4 or int_q5))or i_clk);
	o_clk <= ((int_q0 and int_q1) and (int_q2 and int_q3)) and (int_q4 and int_q5);

end structure;
