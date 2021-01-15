`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2021 22:43:17
// Design Name: 
// Module Name: mcp3201_srl
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


module mcp3201_srl(
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
    
    
    reg [32:0] sr_clk;
    reg [32:0] sr_ncs;
    reg [11:0] sr_din;
    reg [11:0] data;
    
    reg spi_clk;
    reg spi_clk_dff;
    reg data_valid;
    wire data_valid_2;
    reg spi_ncs;
    reg spi_ncs_dff;
    
    initial begin
    	sr_ncs <= 33'b111_0000_0000_0000_0000_0000_0000_0000_00;
    	sr_clk <= 33'b000_0101_0101_0101_0101_0101_0101_0101_01;    	
    end
    
    //gen ospi_clk
    always @(posedge isys_clk) begin
    	if(ice) begin
  			sr_clk <= {sr_clk[31:0],sr_clk[32]};
  		end
  		spi_clk <= sr_clk[32];
	end
	
	//gen ospi_ncs
    always @(posedge isys_clk) begin
    	if(ice) begin
  			sr_ncs <= {sr_ncs[31:0],sr_ncs[32]};
  		end
  		spi_ncs <= sr_ncs[32];
	end
	
	//gen ispi_din
    always @(posedge isys_clk) begin
    	if(data_valid_2) begin
  			sr_din <= {sr_din[10:0],ispi_din};
  		end
	end
    
    
    always @(posedge isys_clk) begin
    	spi_clk_dff <= spi_clk;
    	if ((spi_clk == 1'b1) & (spi_clk_dff == 1'b0)) begin
    		data_valid <= 1'b1;
    	end else begin
    		data_valid <= 1'b0;
    	end
    end
    
    assign data_valid_2 = ((spi_clk == 1'b1) & (spi_clk_dff == 1'b0))?1'b1 : 1'b0;
    
    always @(posedge isys_clk) begin
    	spi_ncs_dff <= spi_ncs;
    end
    
    assign odata_valid = ((spi_ncs == 1'b1) & (spi_ncs_dff == 1'b0))?1'b1 : 1'b0;
    always @(posedge isys_clk) begin
    	if (odata_valid) begin
    		data <= sr_din;
    	end
    end
    
    assign odata = data;
    
    
    assign ospi_clk = spi_clk;
    assign ospi_ncs = spi_ncs;
    
endmodule
