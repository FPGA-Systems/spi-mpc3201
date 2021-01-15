----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2021 22:39:40
-- Design Name: 
-- Module Name: mcp3201_bram - rtl
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mcp3201_bram is
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
end mcp3201_bram;

architecture rtl of mcp3201_bram is
	
		type rom_type is array (33 downto 0) of std_logic_vector(1 downto 0);
		signal rom : rom_type := 
		(
		--rom(0) - spi_clk
		--rom(1) - spi_ncs 
			b"10",
			b"10",
			b"00",
			b"01",
			b"00",
			b"01",
			b"00",
			--null bit
			b"01",
			b"00",
			--data
			b"01",
			b"00",
			b"01",
			b"00",
			b"01",
			b"00",
			b"01",
			b"00",
			b"01",
			b"00",
			b"01",
			b"00",
			b"01",
			b"00",
			b"01",
			b"00",
			b"01",
			b"00",
			b"01",
			b"00",
			b"01",
			b"00",
			b"01",
			b"00",
			--
			b"10"
		);
		
	signal addr : natural  range 0 to 33 := 0;
	signal data : std_logic_vector(11 downto 0) := (others => '0');
	signal data_valid	:  std_logic := '0';
	signal spi_ncs  : std_logic := '1';
	signal spi_clk  : std_logic := '0';
	signal spi_clk_dff  : std_logic := '0';
	signal srl_dv : std_logic := '0';
begin
	
	process(isys_clk) begin
		if rising_edge(isys_clk) then
			if ice = '1' then
				
				if (addr = 33) then
					addr <= 0;
				else
					addr <= addr + 1;
				end if;
			
				spi_ncs <= rom(addr)(1);
				spi_clk <= rom(addr)(0);
				
			end if;			
		end if;
	end process;
	
	process (isys_clk) begin
		if rising_edge(isys_clk) then
						
			if (addr = 0 and ice = '1') then
				data_valid <= '1';
			else
				data_valid <= '0';
			end if;
			
			spi_clk_dff <= spi_clk;
			if(spi_clk = '1' and spi_clk_dff = '0') then
				srl_dv <= '1';
			else
				srl_dv <= '0';
			end if;
			
			if srl_dv = '1' then
				data(0) <= ispi_din;
				for i in 11 downto 1 loop
					data(i) <=  data(i - 1);
				end loop;
			end if;
		end if;
	end process;
	
	
	odata       <= data       ;
	odata_valid <= data_valid ;
	ospi_ncs    <= spi_ncs    ;
	ospi_clk    <= spi_clk    ;
end rtl;
