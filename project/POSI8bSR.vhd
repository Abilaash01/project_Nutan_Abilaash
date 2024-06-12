LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY POSI8bSR IS
	PORT(
		i_resetBar, i_shift, i_enable	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_Value			: IN	STD_LOGIC;
		o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0));
END POSI8bSR;

ARCHITECTURE rtl OF POSI8bSR IS
	SIGNAL int_Value : STD_LOGIC_VECTOR(7 downto 0);

	COMPONENT enardFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;

BEGIN

bit7: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => (i_Value and i_shift)or(int_Value(7) and not(i_shift)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(7),
	         	  o_qBar => open
	);

bit6: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => (int_Value(7) and i_shift)or(int_Value(6) and not(i_shift)),
			  i_enable => i_enable, 
			  i_clock => i_clock,
			  o_q => int_Value(6),
	          	  o_qBar => open
	);

bit5: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => (int_Value(6) and i_shift)or(int_Value(5) and not(i_shift)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(5),
	          	  o_qBar => open
	);
			  
bit4: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => (int_Value(5) and i_shift)or(int_Value(4) and not(i_shift)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(4),
	         	  o_qBar => open
	);
			  
bit3: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => (int_Value(4) and i_shift)or(int_Value(3) and not(i_shift)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(3),
	          	  o_qBar => open
	);
			  
bit2: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => (int_Value(3) and i_shift)or(int_Value(2) and not(i_shift)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(2),
	          	  o_qBar => open
	);
			  
bit1: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => (int_Value(2) and i_shift)or(int_Value(1) and not(i_shift)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(1),
	          	  o_qBar => open
	);
			  
bit0: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => (int_Value(1) and i_shift)or(int_Value(0) and not(i_shift)), 
			  i_enable => i_enable,
			  i_clock => i_clock,
			  o_q => int_Value(0),
	         	  o_qBar => open
	);

-- Output Driver
	o_Value		<= int_Value;

END rtl;

