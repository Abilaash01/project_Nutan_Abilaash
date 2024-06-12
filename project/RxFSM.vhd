LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity RxFSM is
	port(
		i_clk			:in	std_logic;
		i_RxD			:in	std_logic;
		i_enable, i_resetBar	:in	std_logic;
		
		o_Load, o_FE, o_full	:out	std_logic
	);
end RxFSM;

architecture structure of RxFSM is
	signal int_resetBar, int_count, int_count0 : std_logic;
	signal int_y3, int_y2, int_y1, int_y0 : std_logic;
	signal int_y3BAR, int_y2BAR, int_y1BAR, int_y0BAR : std_logic;

	component Cnt8bPr4 is
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

counter: Cnt8bPr4
	port map(
		i_clk => i_clk,
		i_enable => i_enable,
		i_resetBar => i_resetBar and int_resetBar,
		o_clk => int_count,
		o_clk0 => int_count0
	);

t3: enAPRtFF
	port map(
		i_T => int_count and (((int_y3BAR and int_y2BAR)and (int_y1BAR and int_y0BAR))or((int_y3 and int_y2)and (int_y1BAR and int_y0))),
		i_clock => i_clk,
		i_preset => '1',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_q => int_y3,
		o_qBAR => int_y3BAR
	);

t2: enAPRtFF
	port map(
		i_T => int_count and (((int_y3BAR and int_y2BAR)and (int_y1BAR and int_y0BAR))or((int_y3BAR and int_y2)and (int_y1 and int_y0BAR))),
		i_clock => i_clk,
		i_preset => '1',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_q => int_y2,
		o_qBAR => int_y2BAR
	);

t1: enAPRtFF
	port map(
		i_T => (int_count and (((int_y3BAR and int_y2)and (int_y1BAR and int_y0))or((int_y3BAR and int_y2BAR)and (int_y1 and int_y0)))) or ((not(i_RxD) and ((int_y3 and int_y2)and (int_y1 and int_y0)))or(i_RxD and ((int_y3 and int_y2)and (int_y1BAR and int_y0BAR)))),
		i_clock => i_clk,
		i_preset => '1',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_q => int_y1,
		o_qBAR => int_y1BAR
	);

t0: enAPRtFF
	port map(
		i_T => (int_count and ((int_y3 xor int_y2) xor (int_y1 xor int_y0))) or (i_RxD and ((int_y3 and int_y2)and (int_y1BAR and int_y0BAR))),
		i_clock => i_clk,
		i_preset => '1',
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		o_q => int_y0,
		o_qBAR => int_y0BAR
	);

	int_resetBar <= not((int_y3 and int_y2)and (int_y1 and int_y0));

	o_Load <= int_y3BAR and int_count0;

	o_FE <= (((int_y3 and int_y2)and (int_y1BAR and int_y0BAR)) and (int_count and not(i_RxD)))and not(i_clk);

	o_full <= ((int_y3 and int_y2) and (int_y1BAR and int_y0BAR))and not(i_clk);


end structure;
