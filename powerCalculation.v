`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2026 15:38:08
// Design Name: 
// Module Name: powerCalculation
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


module powerCalculation(
input clk,
input rst,
input [7:0] data_in,
input [7:0] katsayi,
output reg [23:0] result
    );
    
reg [7:0] constant;
reg [15:0] square;

always @(posedge clk or negedge rst)begin
if(!rst)begin
result <= 24'd0;
constant <= 8'd0;
square <= 16'b0;
end
else begin
square <= data_in * data_in;
constant <= katsayi;

result <= square * constant;
end
end
endmodule
