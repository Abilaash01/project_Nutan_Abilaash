library ieee;
use ieee.std_logic_1164.all;

entity enaprtff is
	port(
		i_t, i_resetBar, i_clock, i_preset, i_enable : in std_logic;
		o_q, o_qBar : out std_logic
	);
end enaprtff;

architecture structure of enaprtff is
	signal int_q: std_logic;
	
	component enaprdff
		port(
			i_resetBar: in	std_logic;
			i_preset: in std_logic;
			i_d: in std_logic;
			i_enable: in std_logic;
			i_clock: in	std_logic;
			o_q, o_qBar: out std_logic
		);
	end component;
begin

	dff: enaprdff
		port map(
			i_resetBar => i_resetBar,
			i_preset => i_preset,
			i_d => int_q xor i_t,
			i_enable => i_enable,
			i_clock => i_clock,
			o_q => int_q,
			o_qBar => o_qBar
		);
	
	o_q <= int_q;
	
end structure;