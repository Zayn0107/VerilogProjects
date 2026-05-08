`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2026 15:20:16
// Design Name: 
// Module Name: ram
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


module ram#(parameter WIDTH = 32)(
input clk,
input rst,
input [7:0] threshold,
input [7:0] addr,
output reg selection,
input en
    );
 reg [WIDTH-1:0] mem [0:255];   
 reg [WIDTH-1:0] ram [0:255]; 
 wire [2*WIDTH-1:0] result;
 
 reg [WIDTH-1:0] ram_a; 
 reg [WIDTH-1:0] ram_b; 
 reg [WIDTH-1:0] ram_c; 
 reg [WIDTH-1:0] ram_d;    
 
 always @(posedge clk or negedge rst)begin
 if(!rst)begin
  selection <= 0;
 end
 else begin
  if(en)begin
  ram_a <= mem[addr];
  ram_b <= mem[addr];
  ram_c <= mem[addr+1];
  ram_d <= mem[addr+1];
   if(result > threshold)begin
      selection <= 1 ;
   end
   else begin
     selection <= 0;
   end
  end
  
 end

end 
 
  
 pipeline #(.WIDTH(WIDTH))uut(
 .clk(clk),
 .rst(rst),
 .data_a(ram_a),
 .data_b(ram_b),
 .data_c(ram_c),
 .data_d(ram_d),
 .result(result)
 );
  
 
    
    
endmodule
