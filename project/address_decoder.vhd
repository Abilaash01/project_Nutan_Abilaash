library ieee;
use ieee.std_logic_1164.all;

entity address_decoder is
	port(
		i_addr: in	STD_LOGIC_VECTOR(2 downto 0);
		o_BUS, o_TDR , o_SCCR: out	STD_LOGIC_VECTOR(7 downto 0);
		o_SCSRr, o_SCCRl: out	STD_LOGIC_VECTOR(7 downto 0);
		i_BUS, i_RDR, i_SCSR, i_SCCR, i_OE: in	STD_LOGIC_VECTOR(7 downto 0)
	);
end address_decoder;

architecture rtl OF address_decoder is
	signal int_SCCR4, int_SCCR6 : std_logic_vector(7 downto 0);


	component mux8_to_1 is
		port (
			D0, D1, D2, D3, D4, D5, D6, D7 : in STD_LOGIC_VECTOR(7 downto 0);
			sel : in std_logic_VECTOR(2 downto 0);    
			mux_out : out STD_LOGIC_VECTOR(7 downto 0)
		); 
	end component;

	component demux8_1 is
		port (
			D0, D1, D2, D3, D4, D5, D6, D7 : out STD_LOGIC_VECTOR(7 downto 0);
			sel : in std_logic_VECTOR(2 downto 0);    
			mux_in : in STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;
	
	component decoder8_to_1 is
		port(
			i_addr: in	STD_LOGIC_VECTOR(2 downto 0);
			o_addr: out	STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;

begin

bitReset: decoder8_to_1
	port map(
		i_addr => i_addr,
		o_addr => o_SCSRr
	);

busSelectR: mux8_to_1
	port map(
		D0 => "00000000",
		D1 => i_RDR,
		D2 => "00000000",
		D3 => i_SCSR,
		D4 => "00000000",
		D5 => i_SCCR,
		D6 => "00000000",
		D7 => i_SCCR,
		sel => i_addr, 
		mux_out => o_BUS
	);

busSelectW: demux8_1
	port map(
		D0 => o_TDR,
		D1 => open,
		D2 => open,
		D3 => open,
		D4 => int_SCCR4,
		D5 => open,
		D6 => int_SCCR6,
		D7 => open,
		sel => i_addr, 
		mux_in => i_BUS
	);

	o_SCCR(0) <= int_SCCR4(0) or int_SCCR6(0);
	o_SCCR(1) <= int_SCCR4(1) or int_SCCR6(1);
	o_SCCR(2) <= int_SCCR4(2) or int_SCCR6(2);
	o_SCCR(3) <= int_SCCR4(3) or int_SCCR6(3);
	o_SCCR(4) <= int_SCCR4(4) or int_SCCR6(4);
	o_SCCR(5) <= int_SCCR4(5) or int_SCCR6(5);
	o_SCCR(6) <= int_SCCR4(6) or int_SCCR6(6);
	o_SCCR(7) <= int_SCCR4(7) or int_SCCR6(7);
	
	o_SCCRl(0) <= i_addr(2) and not(i_addr(0));
	o_SCCRl(1) <= i_addr(2) and not(i_addr(0));
	o_SCCRl(2) <= i_addr(2) and not(i_addr(0));
	o_SCCRl(3) <= i_addr(2) and not(i_addr(0));
	o_SCCRl(4) <= i_addr(2) and not(i_addr(0));
	o_SCCRl(5) <= i_addr(2) and not(i_addr(0));
	o_SCCRl(6) <= i_addr(2) and not(i_addr(0));
	o_SCCRl(7) <= i_addr(2) and not(i_addr(0));

END rtl;
