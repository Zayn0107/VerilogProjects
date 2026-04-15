`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2026 16:01:31
// Design Name: 
// Module Name: counter
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


module counter();
reg clk;
reg rst;

wire [2:0] q_out;

third uut(
.clk(clk),
.rst(rst),
.q_out(q_out)
);

initial begin
clk = 0;
end

always #5 clk = ~clk;

initial begin
rst = 0;
#10;
rst = 1;

#80;
if(q_out == 3'b000)
  $display("1 cycle");
else
  $display("%b", q_out);
 #20;
$finish;
end
endmodule
