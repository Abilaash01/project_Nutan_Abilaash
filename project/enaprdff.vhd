library ieee;
use ieee.std_logic_1164.all;

entity enaprdff is
	port(
		i_resetBar	: in	STD_LOGIC;
		i_preset	: in	STD_LOGIC;
		i_d		: in	STD_LOGIC;
		i_enable	: in	STD_LOGIC;
		i_clock		: in	STD_LOGIC;
		o_q, o_qBar	: out	STD_LOGIC);
end enaprdff;

architecture rtl of enaprdff is
	signal int_q : STD_LOGIC;
begin

oneBitRegister:
process(i_resetBar, i_clock)
begin
	IF (i_resetBar = '0') then
		int_q	<= i_preset;
	elsif (i_clock'event and i_clock = '1') then
		if (i_enable = '1') then
			int_q	<=	i_d;
		end if;
	end if;
end process oneBitRegister;

	--  Output Driver

	o_q		<=	int_q;
	o_qBar		<=	not(int_q);

end rtl;
