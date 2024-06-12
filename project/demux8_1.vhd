library ieee;
use ieee.std_logic_1164.all;

entity demux8_1 is
	port (
		D0, D1, D2, D3, D4, D5, D6, D7 : out STD_LOGIC_VECTOR(7 downto 0);
		sel : in std_logic_VECTOR(2 downto 0);    
		mux_in : in STD_LOGIC_VECTOR(7 downto 0)
	);
end demux8_1;

architecture structure of demux8_1 is
	signal int_dec : STD_LOGIC_VECTOR(7 downto 0);
	
	component decoder8_to_1 is
		port(
			i_addr: in	STD_LOGIC_VECTOR(2 downto 0);
			o_addr: out	STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;

begin

decoder: decoder8_to_1
	port map(
		i_addr => sel,
		o_addr => int_dec
	);

	D0(0) <= mux_in(0) and int_dec(0);
	D0(1) <= mux_in(1) and int_dec(0);
	D0(2) <= mux_in(2) and int_dec(0);
	D0(3) <= mux_in(3) and int_dec(0);
	D0(4) <= mux_in(4) and int_dec(0);
	D0(5) <= mux_in(5) and int_dec(0);
	D0(6) <= mux_in(6) and int_dec(0);
	D0(7) <= mux_in(7) and int_dec(0);

	D1(0) <= mux_in(0) and int_dec(1);
	D1(1) <= mux_in(1) and int_dec(1);
	D1(2) <= mux_in(2) and int_dec(1);
	D1(3) <= mux_in(3) and int_dec(1);
	D1(4) <= mux_in(4) and int_dec(1);
	D1(5) <= mux_in(5) and int_dec(1);
	D1(6) <= mux_in(6) and int_dec(1);
	D1(7) <= mux_in(7) and int_dec(1);

	D2(0) <= mux_in(0) and int_dec(2);
	D2(1) <= mux_in(1) and int_dec(2);
	D2(2) <= mux_in(2) and int_dec(2);
	D2(3) <= mux_in(3) and int_dec(2);
	D2(4) <= mux_in(4) and int_dec(2);
	D2(5) <= mux_in(5) and int_dec(2);
	D2(6) <= mux_in(6) and int_dec(2);
	D2(7) <= mux_in(7) and int_dec(2);

	D3(0) <= mux_in(0) and int_dec(3);
	D3(1) <= mux_in(1) and int_dec(3);
	D3(2) <= mux_in(2) and int_dec(3);
	D3(3) <= mux_in(3) and int_dec(3);
	D3(4) <= mux_in(4) and int_dec(3);
	D3(5) <= mux_in(5) and int_dec(3);
	D3(6) <= mux_in(6) and int_dec(3);
	D3(7) <= mux_in(7) and int_dec(3);

	D4(0) <= mux_in(0) and int_dec(4);
	D4(1) <= mux_in(1) and int_dec(4);
	D4(2) <= mux_in(2) and int_dec(4);
	D4(3) <= mux_in(3) and int_dec(4);
	D4(4) <= mux_in(4) and int_dec(4);
	D4(5) <= mux_in(5) and int_dec(4);
	D4(6) <= mux_in(6) and int_dec(4);
	D4(7) <= mux_in(7) and int_dec(4);

	D5(0) <= mux_in(0) and int_dec(5);
	D5(1) <= mux_in(1) and int_dec(5);
	D5(2) <= mux_in(2) and int_dec(5);
	D5(3) <= mux_in(3) and int_dec(5);
	D5(4) <= mux_in(4) and int_dec(5);
	D5(5) <= mux_in(5) and int_dec(5);
	D5(6) <= mux_in(6) and int_dec(5);
	D5(7) <= mux_in(7) and int_dec(5);

	D6(0) <= mux_in(0) and int_dec(6);
	D6(1) <= mux_in(1) and int_dec(6);
	D6(2) <= mux_in(2) and int_dec(6);
	D6(3) <= mux_in(3) and int_dec(6);
	D6(4) <= mux_in(4) and int_dec(6);
	D6(5) <= mux_in(5) and int_dec(6);
	D6(6) <= mux_in(6) and int_dec(6);
	D6(7) <= mux_in(7) and int_dec(6);

	D7(0) <= mux_in(0) and int_dec(7);
	D7(1) <= mux_in(1) and int_dec(7);
	D7(2) <= mux_in(2) and int_dec(7);
	D7(3) <= mux_in(3) and int_dec(7);
	D7(4) <= mux_in(4) and int_dec(7);
	D7(5) <= mux_in(5) and int_dec(7);
	D7(6) <= mux_in(6) and int_dec(7);
	D7(7) <= mux_in(7) and int_dec(7);

end structure;
