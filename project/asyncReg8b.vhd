library ieee;
use ieee.std_logic_1164.all;

ENTITY asyncReg8b is
	PORT(
		i_d, i_load: in std_logic_vector(7 downto 0);
		o_q :out	std_logic_vector(7 downto 0)
	);
end asyncReg8b;

architecture rtl of asyncReg8b is

	component enadLatch is
		port(
			i_d: in std_logic;
			i_enable: in STD_LOGIC;
			o_q, o_qBar: out STD_LOGIC
		);
	end component;

begin

bit0 : enadLatch
	port map(
		i_d => i_d(0),
		i_enable => i_load(0),
		o_q => o_q(0),
		o_qBar => open
	);

bit1 : enadLatch
	port map(
		i_d => i_d(1),
		i_enable => i_load(1),
		o_q => o_q(1),
		o_qBar => open
	);

bit2 : enadLatch
	port map(
		i_d => i_d(2),
		i_enable => i_load(2),
		o_q => o_q(2),
		o_qBar => open
	);

bit3 : enadLatch
	port map(
		i_d => i_d(3),
		i_enable => i_load(3),
		o_q => o_q(3),
		o_qBar => open
	);

bit4 : enadLatch
	port map(
		i_d => i_d(4),
		i_enable => i_load(4),
		o_q => o_q(4),
		o_qBar => open
	);

bit5 : enadLatch
	port map(
		i_d => i_d(5),
		i_enable => i_load(5),
		o_q => o_q(5),
		o_qBar => open
	);

bit6 : enadLatch
	port map(
		i_d => i_d(6),
		i_enable => i_load(6),
		o_q => o_q(6),
		o_qBar => open
	);

bit7 : enadLatch
	port map(
		i_d => i_d(7),
		i_enable => i_load(7),
		o_q => o_q(7),
		o_qBar => open
	);

end rtl;
