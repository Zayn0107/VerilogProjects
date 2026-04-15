`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2026 13:20:28
// Design Name: 
// Module Name: first
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
//Addition

module first(
input wire [3:0] a,
input wire [3:0] b,
output wire [4:0] result
    );
    
assign result = a + b; // wire must assigned!!
endmodule
