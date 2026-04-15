`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2026 13:25:05
// Design Name: 
// Module Name: addition
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
//Testbench file

module addition();

reg [3:0] a;
reg [3:0] b;
wire [4:0] result;

first uut(
.a(a),
.b(b),
.result(result)
);

initial begin
a = 4'b1000;
b = 4'b0111;
$finish;
end
endmodule
