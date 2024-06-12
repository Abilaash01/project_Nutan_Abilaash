library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TrafficLightController is
	port(
		GClock : in std_logic;
		GReset : in std_logic;
		MSC, SSC : in std_logic_vector(3 downto 0);
		SSCS : in std_logic;
		MSTL, SSTL : out std_logic_vector(2 downto 0);
		BCD1, BCD2 : out std_logic_vector(3 downto 0)
	);
end TrafficLightController;

architecture rtl of TrafficLightController is
	type state_type is (A, B, C, D);
	signal current_state, next_state : state_Type;
	signal counter_1s: std_logic_vector(27 downto 0):= x"0000000";
	signal delay_count:std_logic_vector(3 downto 0):= x"0";
	signal clk_1s_enable: std_logic;
	signal delay_3s, delay_S, delay_M, R_EN, YM_EN, YS_EN: std_logic:='0';
	
	--Design the state transition block
	begin
		process(GCLOCK,GRESET) 
			begin
				if(GRESET='1') then
					current_state <= A;
				elsif(rising_edge(GCLOCK)) then 
					current_state <= next_state; 
				end if;
		end process;
		
		--Designs the clock counter to countdown the MSC and SSC
		process(GCLOCK)
			begin
				if(rising_edge(GCLOCK)) then 
					counter_1s <= counter_1s + x"0000001";
					
					if(counter_1s >= x"0000003") then
						counter_1s <= x"0000000";
					end if;
			end if;
		end process;
		
		process(GCLOCK)
			begin
				if(rising_edge(GCLOCK)) then 
					if(clk_1s_enable='1') then
			 
						if(R_EN = '1' or YM_EN = '1' or YS_EN = '1') then
							delay_count <= delay_count + x"1";
							if((delay_count = x"9") and R_EN = '1') then 
								delay_3s <= '1';
								delay_M <= '0';
								delay_S <= '0';
								delay_count <= x"0";
							elsif((delay_count = x"2") and YM_EN = '1') then
								delay_3s <= '0';
								delay_M <= '1';
								delay_S <= '0';
								delay_count <= x"0";
							elsif((delay_count = x"2") and YS_EN = '1') then
								delay_3s <= '0';
								delay_M <= '0';
								delay_S <= '1';
								delay_count <= x"0";
							else
								delay_3s <= '0';
								delay_M <= '0';
								delay_S <= '0';
							end if;
						end if;
					end if;
				end if;
		end process;
		
		process (current_state, SSCS, delay_S, delay_M, delay_3s)
			begin
				case current_state is
					when A =>
						R_EN <= '0';
						YM_EN <= '0';
						YS_EN <= '0';
						MSTL <= "100"; --Green light on Main Street
						SSTL <= "001"; --Red light on Side Street
						
						if(SSCS = '1') then --If vehicle is detected on farm way by sensors
							next_state <= B;
						else 
							next_state <= A;
						end if;
					
					when B =>
						R_EN <= '0';
						YM_EN <= '1';
						YS_EN <= '0';
						MSTL <= "010"; --Yellow light on Main Street
						SSTL <= "001"; --Red light on Side Street
						
						if(delay_M = '1') then
							next_state <= C;
						else 
							next_state <= C;
						end if;
					
					when C =>
						R_EN <= '1';
						YM_EN <= '0';
						YS_EN <= '0';
						MSTL <= "001"; --Red light on Main Street
						SSTL <= "100"; --Green light on Side Street
						
						if(delay_3s = '1') then
							next_state <= D;
						else 
							next_state <= D;
						end if;
					
					when D =>
						R_EN <= '0';
						YM_EN <= '0';
						YS_EN <= '1';
						MSTL <= "001"; --Red light on Main Street
						SSTL <= "010"; --Yellow light on Side Street
						
						if(SSCS = '1') then
							next_state <= A;
						else
							next_state <= A;
						end if;
							
					when others =>
						next_state <= A; -- Default is Green on main street, red on side street
				end case;
		end process;
			
end rtl;