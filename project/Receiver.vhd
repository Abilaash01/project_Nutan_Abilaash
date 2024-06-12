LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity UARTrx is
	port(
		i_BAUDx8		:in	std_logic;
		i_RxD			:in	std_logic;
		i_enable, i_resetBar	:in	std_logic;
		
		o_RDR			:out	std_logic_vector(7 downto 0);
		o_FE, o_RDRF, o_newRX	:out	std_logic
	);
end UARTrx;

architecture structure of UARTrx is
	signal int_loadRSR, int_loadRDR : std_logic;
	signal int_RSR : std_logic_vector(7 downto 0);

	component RxFSM is
		port(
			i_clk			:in	std_logic;
			i_RxD			:in	std_logic;
			i_enable, i_resetBar	:in	std_logic;
			o_Load, o_FE, o_full	:out	std_logic
		);
	end component;

	component srLatch IS
		PORT(
			i_set, i_reset		: IN	STD_LOGIC;
			o_q, o_qBar		: OUT	STD_LOGIC
		);
	end component;

	component POSI8bSR IS
		PORT(
			i_resetBar, i_shift, i_enable	: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			i_Value			: IN	STD_LOGIC;
			o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0)
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

fsm: RxFSM
	port map(
		i_clk => i_BAUDx8,
		i_RxD => i_RxD,
		i_enable => i_enable,
		i_resetBar => i_resetBar,
		o_Load => int_loadRSR,
		o_FE => o_FE,
		o_full => int_loadRDR
	);

RSR: POSI8bSR
	port map(
		i_resetBar => i_resetBar,
		i_shift => int_loadRSR,
		i_enable => i_enable,
		i_clock => i_BAUDx8,
		i_Value => i_RxD,
		o_Value => int_RSR
	);	

RDR: pipo8breg
	port map(
		i_resetBar => i_resetBar,
		i_load => int_loadRDR,
		i_enable => i_enable,
		i_clock => i_BAUDx8,
		i_Value => int_RSR,
		o_Value => o_RDR
	);	

	o_RDRF <= int_loadRDR;

end structure;