LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity mux8_to_1 is
	port (
		D0, D1, D2, D3, D4, D5, D6, D7: in STD_LOGIC_VECTOR(7 downto 0);
		sel : in std_logic_VECTOR(2 downto 0);    
		mux_out : out STD_LOGIC_VECTOR(7 downto 0)
	);
end mux8_to_1;

architecture structure of mux8_to_1 is
begin

with sel select
    mux_out <= D0 when "000",
               D1 when "001",
					D2 when "010",
					D3 when "011",
					D4 when "100",
					D5 when "101",
					D6 when "110",
					D7 when "111",          
               "00000000" when others;    

end structure;