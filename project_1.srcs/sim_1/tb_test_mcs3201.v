`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2021 23:23:46
// Design Name: 
// Module Name: tb_test_mcs3201
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_test_mcs3201();

	wire spi_clk;
	wire spi_ncs;
	wire spi_din;
	reg sys_clk;
	
	initial begin
		sys_clk <= 1'b0;
	end
	
	always @(*) #5 sys_clk <= ~sys_clk;
	
	test_mcp3201 inst_test_mcp3201(
		.isys_clk(sys_clk),
		.ospi_clk(spi_clk),
		.ospi_ncs(spi_ncs),
		.ispi_din(spi_din)
	);
	
	mcp3201_beh_model adc(
		.iclk(spi_clk),
		.odout(spi_din),
		.incs(spi_ncs)
    );
	
endmodule
