LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY PISO10bSR IS
	PORT(
		i_resetBar, i_shift, i_enable	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_MSBin			: IN	STD_LOGIC;
		i_Value			: IN	STD_LOGIC_VECTOR(10 downto 0);
		o_Value			: OUT	STD_LOGIC
	);
END PISO10bSR;

ARCHITECTURE rtl OF PISO10bSR IS
	SIGNAL int_Value : STD_LOGIC_VECTOR(10 downto 0);

	COMPONENT enaprdff
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_preset	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;



BEGIN

bit10: enaprdff
	PORT MAP (i_resetBar => i_resetBar,
			  i_preset => '1',
			  i_d => (i_MSBin and i_shift)or(i_Value(10) and not(i_shift)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(10),
	         	  o_qBar => open
	);

bit9: enaprdff
	PORT MAP (i_resetBar => i_resetBar,
			  i_preset => '1',
			  i_d => (int_Value(10) and i_shift)or(i_Value(9) and not(i_shift)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(9),
	         	  o_qBar => open
	);

bit8: enaprdff
	PORT MAP (i_resetBar => i_resetBar,
			  i_preset => '1',
			  i_d => (int_Value(9) and i_shift)or(i_Value(8) and not(i_shift)),
			  i_enable => i_enable, 
			  i_clock => i_clock,
			  o_q => int_Value(8),
	          	  o_qBar => open
	);

bit7: enaprdff
	PORT MAP (i_resetBar => i_resetBar,
			  i_preset => '1',
			  i_d => (int_Value(8) and i_shift)or(i_Value(7) and not(i_shift)),
			  i_enable => i_enable, 
			  i_clock => i_clock,
			  o_q => int_Value(7),
	          	  o_qBar => open
	);

bit6: enaprdff
	PORT MAP (i_resetBar => i_resetBar,
			  i_preset => '1',
			  i_d => (int_Value(7) and i_shift)or(i_Value(6) and not(i_shift)),
			  i_enable => i_enable, 
			  i_clock => i_clock,
			  o_q => int_Value(6),
	          	  o_qBar => open
	);

bit5: enaprdff
	PORT MAP (i_resetBar => i_resetBar,
			  i_preset => '1',
			  i_d => (int_Value(6) and i_shift)or(i_Value(5) and not(i_shift)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(5),
	          	  o_qBar => open
	);
			  
bit4: enaprdff
	PORT MAP (i_resetBar => i_resetBar,
			  i_preset => '1',
			  i_d => (int_Value(5) and i_shift)or(i_Value(4) and not(i_shift)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(4),
	         	  o_qBar => open
	);
			  
bit3: enaprdff
	PORT MAP (i_resetBar => i_resetBar,
			  i_preset => '1',
			  i_d => (int_Value(4) and i_shift)or(i_Value(3) and not(i_shift)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(3),
	          	  o_qBar => open
	);
			  
bit2: enaprdff
	PORT MAP (i_resetBar => i_resetBar,
			  i_preset => '1',
			  i_d => (int_Value(3) and i_shift)or(i_Value(2) and not(i_shift)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(2),
	          	  o_qBar => open
	);
			  
bit1: enaprdff
	PORT MAP (i_resetBar => i_resetBar,
			  i_preset => '1',
			  i_d => (int_Value(2) and i_shift)or(i_Value(1) and not(i_shift)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(1),
	          	  o_qBar => open
	);
			  
bit0: enaprdff
	PORT MAP (i_resetBar => i_resetBar,
			  i_preset => '1',
			  i_d => (int_Value(1) and i_shift)or(i_Value(0) and not(i_shift)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(0),
	         	  o_qBar => open
	);

-- Output Driver
	o_Value		<= int_Value(0);

END rtl;

