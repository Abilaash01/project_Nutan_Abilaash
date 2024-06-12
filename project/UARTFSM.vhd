LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity UARTFSM is
	port(
		state: in  std_logic;
		i_clk: in std_logic;
		i_IRQ: in std_logic;
		io_BUS: inout std_logic_vector(7 downto 0);
		address: out std_LOGIC_VECTOR(1 downto 0)
	);
end UARTFSM;

architecture rtl of UARTFSM is
	signal io_BUS, i_rxd: std_logic;
	
	component TrafficLightController is
		port(
			GClock : in std_logic;
			GReset : in std_logic;
			MSC, SSC : in std_logic_vector(3 downto 0);
			SSCS : in std_logic;
			MSTL, SSTL : out std_logic_vector(2 downto 0);
			BCD1, BCD2 : out std_logic_vector(3 downto 0)
		);
	end component;
	
	component UART is
		port(
			i_RxD: in	std_logic;
			i_clk: in	std_logic;
			i_enable, i_resetBar: in	std_logic;
			i_ADDR: in	STD_LOGIC_VECTOR(1 downto 0);
			i_r_wBar: in std_logic;
			io_BUS: inout	std_logic_vector(7 downto 0);
			o_TxD, o_IRQ: out	std_logic
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

begin
end rtl;