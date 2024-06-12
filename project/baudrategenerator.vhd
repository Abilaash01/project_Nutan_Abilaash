library ieee;
use ieee.std_logic_1164.all;

entity baudrategenerator is
	port(
		i_clk: in std_logic; -- clock is assumed at 25.175 MHz
		i_resetBar, i_enable: in std_logic;
		i_sel: in std_logic_vector(2 downto 0);
		o_baud, o_baud8: out std_logic
	);
end baudrategenerator;

architecture structure of baudrategenerator is
	signal int_clk41, int_clkSel : std_logic;
	signal int_clk256 : std_logic_vector(7 downto 0);

	component div8 is
		port(
			i_clk, i_enable, i_resetBar	:in	std_logic;
			o_clk	:out	std_logic
		);
	end component;

	component clkdiv41 is
		port(
			i_clk, i_enable, i_resetBar	:in	std_logic;
			o_clk	:out	std_logic
		);
	end component;

	component div256async is
		port(
			i_clk, i_enable, i_resetBar	:in	std_logic;
			o_clk	:out	std_logic_vector(7 downto 0)
		);
	end component;

	component mux8to1 is
		port (
			D : in STD_LOGIC_VECTOR(7 downto 0);
			sel : in std_logic_VECTOR(2 downto 0);    
			mux_out : out STD_LOGIC
		);
	end component;

begin

Divide41: clkdiv41
	port map(
		i_clk => i_clk,
		i_enable => i_enable,
		i_resetBar => i_resetBar,
		o_clk => int_clk41
	);

Divide256: div256async
	port map(
		i_clk => int_clk41,
		i_enable => i_enable,
		i_resetBar => i_resetBar,
		o_clk => int_clk256
	);

BaudSel: mux8to1
	port map(
		D => int_clk256,
		sel => i_sel,
		mux_out => int_clkSel
	);

Divide8: div8
	port map(
		i_clk => int_clkSel,
		i_enable => i_enable,
		i_resetBar => i_resetBar,
		o_clk => o_baud
	);

	o_baud8 <= int_clkSel;

end structure;
