`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2021 23:08:32
// Design Name: 
// Module Name: clk_div
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


module clk_div(
    input isys_clk,
    output oce
    );
    
    
    reg [3 : 0] cnt;
    reg ce;
    
    initial begin
    	cnt <= 0;
    	ce <= 0;
    end
    
    always @(posedge isys_clk)
    begin
    	if (cnt == 7) begin
    		ce <= 1'b1;
    	end else begin
    		ce <= 1'b0;
    	end
    	
    	if (cnt == 7) begin
    		cnt <= 0;
    	end else begin
    		cnt <= cnt + 1'b1;
    	end 
    end
    
    assign oce = ce;
    
endmodule
