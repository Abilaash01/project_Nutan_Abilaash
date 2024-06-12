LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity UART is
	port(
		i_RxD:in	std_logic;
		i_clk: in std_logic;
		i_enable, i_resetBar: in	std_logic;
		i_ADDR: in STD_LOGIC_VECTOR(1 downto 0);
		i_r_wBar:in	std_logic;
		io_BUS:inout	std_logic_vector(7 downto 0);
		o_TxD, o_IRQ: out	std_logic
	);
end UART;

architecture structure of UART is
	signal int_SCSR, int_SCCR, int_SCSRr : std_logic_vector(7 downto 0);
	signal int_baud, int_baud8, int_OE, int_FE, int_RDRF, int_TDRE, int_TDREo : std_logic;
	signal int_TDRaddr, int_SCCRaddr, int_SCCRladdr, int_RDRaddr : std_logic_vector(7 downto 0);
	
	component UARTrx is
		port(
			i_BAUDx8		:in	std_logic;
			i_RxD			:in	std_logic;
			i_enable, i_resetBar	:in	std_logic;
			o_RDR			:out	std_logic_vector(7 downto 0);
			o_FE, o_RDRF		:out	std_logic
		);
	end component;
	
	component baudrategenerator is
		port(
			i_clk	:in	std_logic; -- clock is assumed at 25.175 MHz
			i_resetBar, i_enable :in std_logic;
			i_sel	:in	std_logic_vector(2 downto 0);
			o_baud, o_baud8	:out	std_logic
		);
	end component;

	component UARTtx is
		port(
			i_BAUD			:in	std_logic;
			i_enable, i_resetBar	:in	std_logic;
			i_TDR			:in	std_logic_vector(7 downto 0);	
			i_loadTDR		:in	std_logic;
			i_TDRE			:in	std_logic;
			o_TxD			:out	std_logic;
			o_TDRE			:out	std_logic
		);
	end component;

	component asyncReg8b IS
		PORT(
			i_d, i_load :in	std_logic_vector(7 downto 0);
			o_q :out	std_logic_vector(7 downto 0)
		);
	end component;
	
	component enardFF_2 IS
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC
		);
	end component;
	
	component address_decoder IS
		PORT(
			i_addr: in STD_LOGIC_VECTOR(2 downto 0);
			o_BUS, o_TDR , o_SCCR: out	STD_LOGIC_VECTOR(7 downto 0);
			o_SCSRr, o_SCCRl: OUT STD_LOGIC_VECTOR(7 downto 0);
			i_BUS, i_RDR, i_SCSR, i_SCCR, i_OE: in	STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;


begin

addrDecoder: address_decoder
	port map(
		i_addr(0) => i_r_wBar,
		i_addr(1) => i_ADDR(0),
		i_addr(2) => i_ADDR(1),
		o_BUS => io_BUS,
		o_TDR => int_TDRaddr,
		o_SCCR => int_SCCRaddr,
		o_SCSRr => int_SCSRr,
		o_SCCRl => int_SCCRladdr,
		i_BUS => io_BUS,
		i_RDR => int_RDRaddr,
		i_SCSR => int_SCSR,
		i_SCCR => int_SCCR,
		i_OE => int_SCSR
	);

OEgate: enardFF_2
	port map(
		i_resetBar => i_resetBar,
		i_d => int_SCSR(6),
		i_enable => i_enable,
		i_clock => int_RDRF,
		o_q => int_OE,
		o_qBar => open
	);

Baud: baudrategenerator
	port map(
		i_clk => i_clk,
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		i_sel(0) => int_SCCR(0),
		i_sel(1) => int_SCCR(1),
		i_sel(2) => int_SCCR(2),
		o_baud => int_baud,
		o_baud8 => int_baud8
	);

Rx: UARTrx
	port map(
		i_BAUDx8 => int_baud8,
		i_RxD => i_RxD,
		i_enable => i_enable,
		i_resetBar => i_resetBar,
		o_RDR => int_RDRaddr,
		o_FE => int_FE,
		o_RDRF => int_RDRF
	);

Tx: UARTtx
	port map(
		i_BAUD => int_baud,
		i_enable => i_enable,
		i_resetBar => i_resetBar,
		i_TDR => int_TDRaddr,
		i_loadTDR => int_TDRE,
		i_TDRE => int_TDRE,
		o_TxD => o_TxD,
		o_TDRE => int_TDREo
	);

SCSR: asyncReg8b
	port map(
		i_d(0) => int_FE and not(int_SCSRr(0)),
		i_d(1) => int_OE and not(int_SCSRr(1)),
		i_d(2) => '0',
		i_d(3) => '0',
		i_d(4) => '0',
		i_d(5) => '0',
		i_d(6) => int_RDRF and not(int_SCSRr(6)),
		i_d(7) => ((int_TDRE or int_TDREo) and not(int_SCSRr(7))) or not(i_resetBar),
		i_load(0) => (int_FE or not(i_resetBar)) or int_SCSRr(0),
		i_load(1) => (int_OE or not(i_resetBar)) or int_SCSRr(1),
		i_load(2) => ('0' or not(i_resetBar)),
		i_load(3) => ('0' or not(i_resetBar)),
		i_load(4) => ('0' or not(i_resetBar)),
		i_load(5) => ('0' or not(i_resetBar)),
		i_load(6) => (int_RDRF or not(i_resetBar)) or int_SCSRr(6),
		i_load(7) => (int_TDREo or not(i_resetBar)) or int_SCSRr(7),
		o_q => int_SCSR
	);

	int_TDRE <= int_SCSR(7);

SCCR: asyncReg8b
	port map(
		i_d(0) => int_SCCRaddr(0) and i_resetBar,
		i_d(1) => int_SCCRaddr(1) and i_resetBar,
		i_d(2) => int_SCCRaddr(2) and i_resetBar,
		i_d(3) => '0',
		i_d(4) => '0',
		i_d(5) => '0',
		i_d(6) => int_SCCRaddr(6) and i_resetBar,
		i_d(7) => int_SCCRaddr(7) and i_resetBar,
		i_load => int_SCCRladdr,
		o_q => int_SCCR
	);

	o_IRQ <= (int_SCCR(7) and int_SCSR(7))or(int_SCCR(6) and(int_SCSR(1) or int_SCSR(6)));

end structure;
