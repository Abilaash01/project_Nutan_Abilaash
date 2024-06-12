LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity UARTtx is
	port(
		i_BAUD			:in	std_logic;
		i_enable, i_resetBar	:in	std_logic;
		i_TDR			:in	std_logic_vector(7 downto 0);	
		i_loadTDR		:in	std_logic;
		i_TDRE			:in	std_logic;

		o_TxD			:out	std_logic;
		o_TDRE			:out	std_logic
	);
end UARTtx;

architecture structure of UARTtx is
	signal int_shift, int_TDRE : std_logic;
	signal int_TDR : std_logic_vector(7 downto 0);

	component TxFSM is
		port(
			i_clk			:in	std_logic;
			i_TDRE			:in	std_logic;
			i_enable, i_resetBar	:in	std_logic;
			o_Shift, o_TDRE		:out	std_logic
		);
	end component;

	component PISO10bSR IS
		PORT(
			i_resetBar, i_shift, i_enable	: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			i_MSBin			: IN	STD_LOGIC;
			i_Value			: IN	STD_LOGIC_VECTOR(10 downto 0);
			o_Value			: OUT	STD_LOGIC
		);
	end component;

	component pipo8breg IS
		PORT(
			i_resetBar, i_load, i_enable	: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			i_Value			: IN	STD_LOGIC_VECTOR(7 downto 0);
			o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;

begin

fsm: TxFSM
	port map(
		i_clk => i_BAUD,
		i_TDRE => i_TDRE,
		i_enable => i_enable,
		i_resetBar => i_resetBar,
		o_Shift => int_shift,
		o_TDRE => int_TDRE
	);

TDR: pipo8breg
	port map(
		i_resetBar => i_resetBar,
		i_load => i_loadTDR,
		i_enable => i_enable,
		i_clock => i_BAUD,
		i_Value => i_TDR,
		o_Value => int_TDR
	);	

TSR: PISO10bSR
	port map(
		i_resetBar => i_resetBar,
		i_shift => int_shift,
		i_enable => i_enable,
		i_clock => i_BAUD,
		i_MSBin => '1',
		i_Value(10) => '1',
		i_Value(9) => int_TDR(7),
		i_Value(8) => int_TDR(6),
		i_Value(7) => int_TDR(5),
		i_Value(6) => int_TDR(4),
		i_Value(5) => int_TDR(3),
		i_Value(4) => int_TDR(2),
		i_Value(3) => int_TDR(1),
		i_Value(2) => int_TDR(0),
		i_Value(1) => '0',
		i_Value(0) => '1',
		o_Value => o_TxD
	);	

	o_TDRE <= int_TDRE;

end structure;
