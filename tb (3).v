`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2026 17:25:30
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


module tb;
reg  clk;             
reg  rst;              
reg  [7:0] data_in;   
reg  [7:0] katsayi;    
wire [23:0] result;
integer i;

non_pipe uut(
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
data_in = 8'd12;
katsayi = 8'd3;

for(i=0; i<10; i = i+1)begin
#10;
data_in = $random%256;
katsayi = $random%256;
end

end
   
endmodule
