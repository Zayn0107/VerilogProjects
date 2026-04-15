`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2026 15:12:12
// Design Name: 
// Module Name: flipflop
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


module flipflop();

reg clk;
reg rst;
reg D;

wire Q;

second uut(
.clk(clk),
.rst(rst),
.D(D),
.Q(Q)
);
initial begin
clk = 0;
end
always #5 clk = ~clk;
initial begin
rst = 0;
D = 0;

#15;
rst = 1;
#10;
D = 1;
#15;
D = 0;
#20;
D = 0;
#50;
$finish;
end
endmodule
