`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2026 15:43:47
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
reg clk;
reg rst;
reg [7:0] data_in;
reg [7:0] katsayi;
wire [23:0] result;
integer i;
powerCalculation uut(
.clk(clk),
.rst(rst),
.data_in(data_in),
.katsayi(katsayi),
.result(result)
);


always #5 clk = ~clk;

initial begin
clk = 0;
rst = 0;
data_in = 0;
katsayi = 0;

#20;
rst = 1;
#10;
data_in = 8'd3;
katsayi = 8'd10;



for(i=0; i<20; i= i+1) begin
#10;
data_in = $random%256;
katsayi = $random%256;
end

#10;
data_in = 8'd3;
katsayi = 8'd10;

#50;
$display("Completed!");
$finish;
end
initial begin
$monitor ("Time %t | katsayi %d | input %d | output %d", $time, katsayi, data_in, result);
end





endmodule
