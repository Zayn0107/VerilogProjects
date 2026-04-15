`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2026 15:19:54
// Design Name: 
// Module Name: third
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
//Counter

module third(
input wire clk,
input wire rst,
output wire [2:0] q_out
    );
    
reg q0;

always @(posedge clk or negedge rst)begin
  if(!rst)begin
    q0 <= 1'b0;
  end
  else begin
    q0 <= ~q0;
  end
end

reg q1;

always @(posedge q0 or negedge rst)begin
  if(!rst)begin
    q1 <= 1'b0;
  end
  else begin
    q1 <= ~q1;
  end
end

reg q2;

always @(posedge q1 or negedge rst)begin
  if(!rst)begin
    q2 <= 1'b0;
  end
  else begin
    q2 <= ~q2;
  end
end

assign q_out = {q2,q1,q0};
endmodule
