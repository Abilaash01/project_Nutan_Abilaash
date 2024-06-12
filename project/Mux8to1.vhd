LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity mux8to1 is
	port (
		D : in STD_LOGIC_VECTOR(7 downto 0);
		Sel : in std_logic_VECTOR(2 downto 0);    
		mux_out : out STD_LOGIC
	);
end mux8to1;

architecture structure of mux8to1 is
begin

with Sel select
    mux_out <=  D(0) when "000",
                D(1) when "001",
		D(2) when "010",
		D(3) when "011",
		D(4) when "100",
		D(5) when "101",
		D(6) when "110",
		D(7) when "111",          
                '0' when others;    

end structure;
