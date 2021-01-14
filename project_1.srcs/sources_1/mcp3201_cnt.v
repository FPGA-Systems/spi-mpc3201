`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.01.2021 21:09:17
// Design Name: 
// Module Name: mcp3201_cnt
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


module mcp3201_cnt(
	input isys_clk,
    input ice,
    //
    output ospi_ncs,
    input ispi_din,
    output ospi_clk,
    //
    output [11:0] odata,
    output odata_valid
);

	reg [5:0]  cnt;
    reg [11:0] sr_din;
	
	reg data_valid;
	reg spi_ncs;
	reg spi_clk;
	reg spi_clk_dff;
	
	reg srl_dv;
	
	initial begin
		cnt <= 0;
	end
	
	always @(posedge isys_clk) begin
		if (ice) begin
			if (cnt == 33) begin
				cnt <= 0;				
			end else begin
				cnt <= cnt + 1;
			end
		end
	end
	
	
	always @(posedge isys_clk) begin
		if (ice) begin
			//spi_ncs
			if (cnt <= 2) begin
				spi_ncs  <= 1'b1;
			end else begin
				spi_ncs <= 1'b0;
			end
			
			//spi_clk
			if (cnt > 3 && cnt <= 32) begin
				spi_clk <= ~spi_clk;
			end else begin
				spi_clk <= 1'b0;
			end	
		end
		
		if (cnt == 0 && ice == 1'b1) begin 
			data_valid <= 1'b1;
		end else begin
			data_valid <= 1'b0;
		end
	end
	
	always @(posedge isys_clk) begin
		spi_clk_dff <= spi_clk;
		if (spi_clk == 1'b1 && spi_clk_dff == 1'b0) begin
			srl_dv <= 1'b1;
		end else begin
			srl_dv <= 1'b0;
		end
	end
	

	//gen ispi_din
    always @(posedge isys_clk) begin
    	if(srl_dv) begin
  			sr_din <= {sr_din[10:0],ispi_din};
  		end		
	end
	
    assign ospi_clk 	= spi_clk;
    assign ospi_ncs 	= spi_ncs;
	assign odata 		= sr_din;
	assign odata_valid 	= data_valid;
	
endmodule
