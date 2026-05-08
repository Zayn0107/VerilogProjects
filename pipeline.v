`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2026 23:15:17
// Design Name: 
// Module Name: pipeline
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

//pipeline mac
module pipeline#(parameter WIDTH = 32)(
input clk,
input rst,
input [WIDTH-1:0] data_a,
input [WIDTH-1:0] data_b,
input [WIDTH-1:0] data_c,
input [WIDTH-1:0] data_d,
output reg [2*WIDTH-1:0] result
    );
reg [2*WIDTH-1:0] multiply_1, multiply_2;
reg [2*WIDTH:0] accum;    
    
always @(posedge clk or negedge rst)begin

if(!rst)begin
  result <= 0;
  multiply_1 <= 0;
  multiply_2 <= 0;
  accum <= 0;
end
else begin
  multiply_1 <= data_a * data_b;
  multiply_2 <= data_c * data_d;
  accum <= multiply_1 + multiply_2;
  
  result <= result + accum;
end


end
endmodule
