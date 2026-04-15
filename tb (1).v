`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2026 16:21:58
// Design Name: 
// Module Name: tb
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


module tb();
parameter DATA_W = 8;
parameter ADDR_W = 4;
parameter DERINLIK = 16;

reg clk;
reg rst;
reg wr_en;
reg [DATA_W-1:0] wr_data;

reg rd_en;
wire [DATA_W-1:0] rd_data;

wire full;
wire empty;


fifo
#(.DATA_W(DATA_W),
.ADDR_W(ADDR_W),
.DERINLIK(DERINLIK))
uut(
.clk(clk),
.rst(rst),
.wr_en(wr_en),
.wr_data(wr_data),
.rd_data(rd_data),
.rd_en(rd_en),
.full(full),
.empty(empty)
);

always #5 clk = ~clk;

initial begin
clk = 0;
rst = 0;
wr_en = 0;
rd_en = 0;
wr_data = 0;
#10;
rst = 1; 
wr_en = 1;
wr_data = 8'hAA;
#10;
wr_data = 8'hBA;
#10;
wr_data = 8'hCA;
#10;
wr_en = 0;
#10;
rd_en = 1;
#100;
$finish;


end









endmodule
