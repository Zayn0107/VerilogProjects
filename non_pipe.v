`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2026 16:04:44
// Design Name: 
// Module Name: non_pipe
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


module non_pipe(
input clk,
input rst,
input [7:0] data_in,
input [7:0] katsayi,
output reg [23:0] result

    );
always @(posedge clk or negedge rst)begin
if(!rst)begin
result <= 24'd0;
end
else begin
result <= data_in * data_in * katsayi;
end

end   
    
    
endmodule
