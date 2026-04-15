`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2026 14:36:45
// Design Name: 
// Module Name: second
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
//Flip-flop

module second(
input wire clk,
input wire rst,
input wire D,
output wire Q
    );
reg q;
always @(posedge clk or negedge rst)begin
   if(!rst)begin
     q <= 1'b0;     
   end
   else begin
     q <= D;
   end
end

assign Q = q;
endmodule
