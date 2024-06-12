library ieee;
use ieee.std_logic_1164.all;

entity decoder is
	port(
		--i_resetBar		:IN	STD_LOGIC;
		--i_clock			:IN	std_logic;
		i_bcd: in std_logic_vector(3 downto 0);
		o_count: out std_logic_vector(6 downto 0)
	);

end entity decoder;
-------------------------------------------------------------------------------
architecture rtl of decoder is
	signal int_count: std_logic_vector(6 downto 0);
begin

--decoding:
--PROCESS(i_clock)
--BEGIN
	--IF (i_clock'EVENT and i_clock = '1') THEN
		-- a
		int_count(6) <= i_bcd(1) OR i_bcd(3) OR (NOT i_bcd(2) AND NOT i_bcd(0)) OR (i_bcd(2) AND i_bcd(0));
		-- b
		int_count(5) <= (NOT i_bcd(2)) OR (NOT i_bcd(1) AND NOT i_bcd(0)) OR (i_bcd(1) AND i_bcd(0));
		-- c
		int_count(4) <= (NOT i_bcd(1)) OR i_bcd(0) OR i_bcd(2);
		-- d
		int_count(3) <= i_bcd(3) OR (NOT i_bcd(2) AND NOT i_bcd(0)) OR (NOT i_bcd(2) AND i_bcd(1)) OR (i_bcd(1) AND NOT i_bcd(0)) OR (i_bcd(2) AND NOT i_bcd(1) AND i_bcd(0));
		-- e
		int_count(2) <= (NOT i_bcd(2) AND NOT i_bcd(0)) OR (i_bcd(1) AND NOT i_bcd(0));
		-- f
		int_count(1) <= i_bcd(3) OR (NOT i_bcd(1) AND NOT i_bcd(0)) OR (i_bcd(2) AND NOT i_bcd(1)) OR (i_bcd(2) AND NOT i_bcd(0));
		-- g
		int_count(0) <= i_bcd(3) OR (NOT i_bcd(2) AND i_bcd(1)) OR (i_bcd(1) AND NOT i_bcd(0)) OR (i_bcd(2) AND NOT i_bcd(1));

	--END IF;
--END PROCESS decoding;

	-- Output Driver
	
	o_count		<= int_count;

end architecture rtl;
-------------------------------------------------------------------------------