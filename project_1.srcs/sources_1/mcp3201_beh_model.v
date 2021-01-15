`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2021 21:01:22
// Design Name: mcp3201_beh_model
// Module Name: mcp3201_beh_model
// Project Name: music_led
// Target Devices: a7-35 
// Tool Versions:  2020.2
// Description:  this is a behavioral model of mcp3201 interface
// 
// Dependencies: 
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mcp3201_beh_model(
    input iclk,
    output odout,
    input incs
    );
    
    
    reg [11:0] data;
    reg dout;
    
    initial begin
    	dout <= 1'bz; 
    	data <= 12'b1111_1111_1111;	
    end
    
    initial  begin
     forever begin
    	data = $urandom_range(2**12 - 1);
    	@(negedge incs);
    	//
    	@(posedge iclk);
    	@(negedge iclk);
    	//
    	@(posedge iclk);
    	@(negedge iclk);
    	dout = 1'b0;
    	//
    	@(posedge iclk);
    	@(negedge iclk);
    	dout = data[11];
    	//
    	@(posedge iclk);
    	@(negedge iclk);
    	dout = data[10];
    	//
    	@(posedge iclk);
    	@(negedge iclk);
    	dout = data[9];
    	    	//
    	@(posedge iclk);
    	@(negedge iclk);
    	dout = data[8];
    	//
    	@(posedge iclk);
    	@(negedge iclk);
    	dout = data[7];
    	//
    	@(posedge iclk);
    	@(negedge iclk);
    	dout = data[6];
    	//
    	@(posedge iclk);
    	@(negedge iclk);
    	dout = data[5];
    	//
    	@(posedge iclk);
    	@(negedge iclk);
    	dout = data[4];
    	//
    	@(posedge iclk);
    	@(negedge iclk);
    	dout = data[3];
    	//
    	@(posedge iclk);
    	@(negedge iclk);
    	dout = data[2];
    	//
    	@(posedge iclk);
    	@(negedge iclk);
    	dout = data[1];
    	//
    	@(posedge iclk);
    	@(negedge iclk);
    	dout = data[0];
		//
    	@(posedge incs);
    	dout = 1'bz;
    end
    end
    
    assign odout = dout;
    
endmodule
