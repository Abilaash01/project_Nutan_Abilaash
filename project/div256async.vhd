library ieee;
use ieee.std_logic_1164.all;

entity div256async is
	port(
		i_clk, i_enable, i_resetBar	:in	std_logic;
		o_clk	:out	std_logic_vector(7 downto 0)
	);
end div256async;

architecture structure of div256async is
	signal int_q0, int_q1, int_q2, int_q3, int_q4, int_q5, int_q6, int_q7 : std_logic;
	signal int_q0BAR, int_q1BAR, int_q2BAR, int_q3BAR, int_q4BAR, int_q5BAR, int_q6BAR, int_q7BAR : std_logic;

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
		o_qBAR => int_q0BAR,
		o_q => int_q0
	);

t1: enAPRtFF
	port map(
		i_T => '1',
		i_clock => int_q0BAR,
		i_preset => '0',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_qBAR => int_q1BAR,
		o_q => int_q1
	);

t2: enAPRtFF
	port map(
		i_T => '1',
		i_clock => int_q1BAR,
		i_preset => '0',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_qBAR => int_q2BAR,
		o_q => int_q2
	);

t3: enAPRtFF
	port map(
		i_T => '1',
		i_clock => int_q2BAR,
		i_preset => '0',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_qBAR => int_q3BAR,
		o_q => int_q3
	);

t4: enAPRtFF
	port map(
		i_T => '1',
		i_clock => int_q3BAR,
		i_preset => '0',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_qBAR => int_q4BAR,
		o_q => int_q4
	);

t5: enAPRtFF
	port map(
		i_T => '1',
		i_clock => int_q4BAR,
		i_preset => '0',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_qBAR => int_q5BAR,
		o_q => int_q5
	);

t6: enAPRtFF
	port map(
		i_T => '1',
		i_clock => int_q5BAR,
		i_preset => '0',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_qBAR => int_q6BAR,
		o_q => int_q6
	);

t7: enAPRtFF
	port map(
		i_T => '1',
		i_clock => int_q6BAR,
		i_preset => '0',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_qBAR => int_q7BAR,
		o_q => int_q7
	);


	o_clk(0) <= int_q0;
	o_clk(1) <= int_q0 and int_q1;
	o_clk(2) <= (int_q0 and int_q1) and int_q2;
	o_clk(3) <= (int_q0 and int_q1) and (int_q2 and int_q3);
	o_clk(4) <= ((int_q0 and int_q1) and (int_q2 and int_q3)) and int_q4;
	o_clk(5) <= ((int_q0 and int_q1) and (int_q2 and int_q3)) and (int_q4 and int_q5);
	o_clk(6) <= ((int_q0 and int_q1) and (int_q2 and int_q3)) and ((int_q4 and int_q5)and int_q7);
	o_clk(7) <= ((int_q0 and int_q1) and (int_q2 and int_q3)) and ((int_q4 and int_q5) and (int_q6 and int_q7));

end structure;
