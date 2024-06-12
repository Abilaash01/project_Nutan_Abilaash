library ieee;
use ieee.std_logic_1164.all;

entity pipo8breg is
	port(
		i_resetBar, i_load, i_enable: in std_logic;
		i_clock: in	std_logic;
		i_Value: in	std_logic_vector(7 downto 0);
		o_Value: out std_logic_vector(7 downto 0));
end pipo8breg;

architecture rtl of pipo8breg is
	signal int_Value : std_logic_vector(7 downto 0);

	component enardFF_2
		port(
			i_resetBar	: in	std_logic;
			i_d		: in	std_logic;
			i_enable	: in	std_logic;
			i_clock		: in	std_logic;
			o_q, o_qBar	: out	std_logic);
	end component;

begin

bit7: enardFF_2
	port map (
		  i_resetBar => i_resetBar,
		  i_d => (i_Value(7) and i_load)or(int_Value(7) and not(i_load)), 
		  i_enable => i_enable,
		  i_clock => i_clock,
		  o_q => int_Value(7),
		  o_qBar => open
	);

bit6: enardFF_2
	port map (
		  i_resetBar => i_resetBar,
		  i_d => (i_Value(6) and i_load)or(int_Value(6) and not(i_load)),
		  i_enable => i_enable, 
		  i_clock => i_clock,
		  o_q => int_Value(6),
		  o_qBar => open
	);

bit5: enardFF_2
	port map (i_resetBar => i_resetBar,
			  i_d => (i_Value(5) and i_load)or(int_Value(5) and not(i_load)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(5),
	        o_qBar => open
	);
			  
bit4: enardFF_2
	port map (i_resetBar => i_resetBar,
			  i_d => (i_Value(4) and i_load)or(int_Value(4) and not(i_load)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(4),
	        o_qBar => open
	);
			  
bit3: enardFF_2
	port map (i_resetBar => i_resetBar,
			  i_d => (i_Value(3) and i_load)or(int_Value(3) and not(i_load)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(3),
	        o_qBar => open
	);
			  
bit2: enardFF_2
	port map (i_resetBar => i_resetBar,
			  i_d => (i_Value(2) and i_load)or(int_Value(2) and not(i_load)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(2),
	        o_qBar => open
	);
			  
bit1: enardFF_2
	port map (i_resetBar => i_resetBar,
			  i_d => (i_Value(1) and i_load)or(int_Value(1) and not(i_load)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(1),
	        o_qBar => open
	);
			  
bit0: enardFF_2
	port map (i_resetBar => i_resetBar,
			  i_d => (i_Value(0) and i_load)or(int_Value(0) and not(i_load)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(0),
	        o_qBar => open
	);

	o_Value <= int_Value;

END rtl;

