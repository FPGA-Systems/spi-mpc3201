`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2021 23:15:15
// Design Name: 
// Module Name: test_mcp3201
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


module test_mcp3201(
    input isys_clk,
    output ospi_clk,
    output ospi_ncs,
    input ispi_din
);
    
    wire sys_clk;
    wire ce;
    (* MARK_DEBUG="true" *)wire adc_data_valid;
    (* MARK_DEBUG="true" *)wire [11:0] adc_data;
    
    clk_wiz_0 inst_clk_wiz (
		.clk_out1(sys_clk),
		.clk_in1(isys_clk)
    ); 
    
    clk_div inst_clk_div(
		.isys_clk(sys_clk),
		.oce (ce)
    );
    
    mcp3201_srl inst_mcp3201_srl(
		.isys_clk(sys_clk),
		.ice(ce),
		//
		.ospi_ncs(ospi_ncs),
		.ispi_din(ispi_din),
		.ospi_clk(ospi_clk),
		//
		.odata(adc_data),
		.odata_valid(adc_data_valid)
   	);
   	
   	
endmodule
