	LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity TxFSM is
	port(
		i_clk			:in	std_logic;
		i_TDRE			:in	std_logic;
		i_enable, i_resetBar	:in	std_logic;
		
		o_Shift, o_TDRE		:out	std_logic
	);
end TxFSM;

architecture structure of TxFSM is
	signal int_resetBar, int_count : std_logic;
	signal int_y1, int_y0 : std_logic;
	signal int_y1BAR, int_y0BAR : std_logic;

	component Cnt4bPr10 is
		port(
			i_clk, i_enable, i_resetBar	:in	std_logic;
			o_clk, o_clk0	:out	std_logic
		);
	end component;

	component enAPRtFF IS
		PORT(
			i_T, i_clock, i_preset, i_resetBar, i_enable	:in	std_logic;
			o_q, o_qBAR				:out	std_logic
		);
	end component;

begin

counter: Cnt4bPr10
	port map(
		i_clk => i_clk,
		i_enable => i_enable,
		i_resetBar => i_resetBar and int_resetBar,
		o_clk => int_count,
		o_clk0 => open
	);

t1: enAPRtFF
	port map(
		i_T => (int_y0BAR and i_TDRE) or (not(i_TDRE) and(int_y0BAR and int_y1BAR)),
		i_clock => i_clk,
		i_preset => '0',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_q => int_y1,
		o_qBAR => int_y1BAR
	);

t0: enAPRtFF
	port map(
		i_T => (int_y0BAR and i_TDRE) or ((not(i_TDRE)and int_y1BAR)or((int_y1 and int_y0)and int_count)),
		i_clock => i_clk,
		i_preset => '1',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_q => int_y0,
		o_qBAR => int_y0BAR
	);

	int_resetBar <= not(int_y0 xor int_y1);

	o_Shift <= int_y0 and int_y1;

	o_TDRE <= (int_y0BAR and int_y1) and not(i_clk);

end structure;
