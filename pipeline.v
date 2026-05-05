`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2026 17:45:23
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


module pipeline(
input clk,
input rst,
input [7:0] in0, in1, in2, in3,
input [7:0] threshold,
output reg alarm
    );
    
 reg [8:0] stage1, stage2;
 wire [9:0] total_sum;
 
 always @(posedge clk or negedge rst)begin
 if(!rst)begin
  stage1 <= 9'd0;
  stage2 <= 9'd0;
 end
 else begin
  stage1 <= in0 + in1;
  stage2 <= in2 + in3;
 end
 
 
 end
 
 assign total_sum = stage1 + stage2;
 
 always @(posedge clk)begin
 
 if(total_sum > {2'b00, threshold})begin
 alarm <= 1'b1;
 end
 else begin
 alarm <= 1'b0;
 end
 
 end
 
endmodule
