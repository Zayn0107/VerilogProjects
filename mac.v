`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2026 22:26:55
// Design Name: 
// Module Name: mac
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


module mac
#(parameter WIDTH = 32)(
input clk,
input rst,
input [WIDTH-1:0] data_a, data_b,
input [WIDTH-1:0] data_c, data_d,
output reg [2*WIDTH-1:0] result
    );
    
 always @(posedge clk or negedge rst) begin
  if(!rst)begin
   result <= 0;
  end
  else begin
   result <= result + (data_a * data_b) + (data_c * data_d);
  end
 end   
    
    
    
    
    
    
    
endmodule
