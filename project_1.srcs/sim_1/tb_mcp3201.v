`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2021 21:34:23
// Design Name: 
// Module Name: tb_mcp3201
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


module tb_mcp3201();

	reg clk;
	reg ncs;
	wire dout;
	
	initial begin
	
		forever begin
			ncs <= 1'b1;
			#10;
			//
			ncs <= 1'b0;
			clk <= 1'b0;
			#10;
			//
			clk <= 1'b1;
			#5;
			clk <= 1'b0;
			#5;
			//
			//
			clk <= 1'b1;
			#5;
			clk <= 1'b0;
			#5
			//
			//
			clk <= 1'b1;
			#5;
			clk <= 1'b0;
			#5;
			//
			//
			clk <= 1'b1;
			#5;
			clk <= 1'b0;
			#5;
			//
			//
			clk <= 1'b1;
			#5;
			clk <= 1'b0;
			#5;
			//
			//
			clk <= 1'b1;
			#5;
			clk <= 1'b0;
			#5;
			//
			//
			clk <= 1'b1;
			#5;
			clk <= 1'b0;
			#5;
			//
			//
			clk <= 1'b1;
			#5;
			clk <= 1'b0;
			#5;
			//
			//
			clk <= 1'b1;
			#5;
			clk <= 1'b0;
			#5;
			//
			//
			clk <= 1'b1;
			#5;
			clk <= 1'b0;
			#5;
			//
			//
			clk <= 1'b1;
			#5;
			clk <= 1'b0;
			#5;
			//
			//
			clk <= 1'b1;
			#5;
			clk <= 1'b0;
			#5;
			//
			//
			clk <= 1'b1;
			#5;
			clk <= 1'b0;
			#5;
			//
			//
			clk <= 1'b1;
			#5;
			clk <= 1'b0;
			#5;
			//
			//
			clk <= 1'b1;
			#5;
			clk <= 1'b0;
			#5;
			//
			
		end
		
	end
	
	
	mcp3201_beh_model dut (
		.iclk(clk),
		.incs(ncs),
		.odout(dout)
	);
	
	
endmodule
