library ieee;
use ieee.std_logic_1164.all;

entity downcnt4b is 
	port(
		i_c: in std_logic_vector(3 downto 0);
		i_clock, i_enable, i_resetBar: in std_logic;
		o_f: out std_logic;
		o_toBCD: out std_logic_vector(3 downto 0)

	);
end downcnt4b;

architecture structure of downcnt4b is
	signal int_f, int_q0, int_q1, int_q2, int_q3 : std_logic;

	component enAPRtFF
		port(
			i_T, i_clock, i_preset, i_resetBar, i_enable: in std_logic;
			o_q, o_qBAR: out std_logic
		);
	end component;

begin

t0: enAPRtFF
	port map(
		i_T => int_f,
		i_clock => i_clock,
		i_preset => not(i_c(0)),
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_q => int_q0,
		o_qBAR => o_toBCD(0)
	);

t1: enAPRtFF
	port map(
		i_T => int_q0 and int_f,
		i_clock => i_clock,
		i_preset => not(i_c(1)),
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_q => int_q1,
		o_qBAR => o_toBCD(1)
	);

t2: enAPRtFF
	port map(
		i_T => int_q1 and (int_q0 and int_f),
		i_clock => i_clock,
		i_preset => not(i_c(2)),
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_q => int_q2,
		o_qBAR => o_toBCD(2)
	);

t3: enAPRtFF
	port map(
		i_T => int_q2 and (int_q1 and (int_q0 and int_f)),
		i_clock => i_clock,
		i_preset => not(i_c(3)),
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_q => int_q3,
		o_qBAR => o_toBCD(3)
	);

	int_f <= ((int_q0)and(int_q1))nand((int_q2)and(int_q3));
	o_f <= int_f;

end structure;