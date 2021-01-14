----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2021 20:21:11
-- Design Name: 
-- Module Name: mcp3201_fsm - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity mcp3201_fsm is
	Port (
		isys_clk	: in std_logic;
		ice			: in std_logic;
		--
		ospi_ncs	: out std_logic;
		ispi_din	: in std_logic;
		ospi_clk	: out std_logic;
		--
		odata		: out std_logic_vector(11 downto 0);
		odata_valid	: out std_logic
	);
end mcp3201_fsm;

architecture rtl of mcp3201_fsm is
	
	type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15);
	signal state : state_type := s0;
	
	signal data : std_logic_vector(11 downto 0) := (others => '0');
	signal data_valid	:  std_logic := '0';
	signal spi_ncs  : std_logic := '1';
	signal spi_clk  : std_logic := '0';
	
	signal k : natural range 0 to 15 := 0;
begin
	
	process (isys_clk) begin
		if rising_edge (isys_clk) then
			if ice = '1' then
				spi_ncs		<= '0';
				spi_clk		<= '0';
				data_valid  <= '0';
				
				case state is
					
					when s0 => 	spi_ncs <= '1';
								k <= 11;
								state <= s1;
								
					when s1 =>	spi_ncs <= '1';
					            state <= s2;
								
					when s2 =>	state <= s3;
					
					when s3 =>	spi_clk <= '1';
								state <= s4;
					
					when s4 => 	spi_clk <= '0';
								state <= s5;
					
					when s5 =>	spi_clk <= '1';
								state <= s6;
					
					when s6 => 	spi_clk <= '0';
								state <= s7;
					
					--null_bit
					when s7 =>	spi_clk <= '1';
								state <= s8;
					
					when s8 => 	spi_clk <= '0';
								state <= s9;
								
					--collect data
					when s9 => 	spi_clk <= '1';
								data(k) <= ispi_din;
								state <= s10;
					
					when s10 =>	spi_clk <= '0';
								if k = 0 then 
									state <= s11;
								else
									k <= k - 1;
									state <= s9;
								end if;
					
					when s11 => spi_ncs <= '1';
								data_valid <= '1';
								state <= s0;
								
					when others => state <= s0;
				end case;
			end if;
		end if;
	end process;
	
	odata       <= data       ;
	odata_valid <= data_valid ;
	ospi_ncs    <= spi_ncs    ;
	ospi_clk    <= spi_clk    ;
	
	
end rtl;
    