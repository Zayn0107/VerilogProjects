`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2026 16:16:54
// Design Name: 
// Module Name: datapath
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


module datapath
#(parameter N = 16) (
input wire clk,
input wire rst,
input wire load,
input wire compute_en,
input wire [N-1:0] first_data,
input wire [N-1:0] second_data,
input wire [2:0] operation,

output reg [2*N-1:0] result,
output reg dp_done
    );

localparam ADD = 3'b000;
localparam SUB = 3'b001;
localparam DIV = 3'b010;
localparam MUL = 3'b011;


reg [N-1:0] opA, opB;
reg [2*N-1:0] accumulator;
reg [N-1:0] counter;
reg [2:0] op_reg;

always @(posedge clk)begin
 if(rst)begin
   opA <= 0;
   opB <= 0;
   accumulator <= 0;
   counter <= 0;
   result <= 0;
   dp_done <= 0;
  end
  else begin 
  
   if(load)begin 
    opA <= first_data;
    opB <= second_data;
    op_reg <= operation;
    accumulator <= 0;
    counter <= 0;
    dp_done <= 0;
    result <= 0;
   end
   else if(compute_en)begin
    dp_done <= 0;
    case(op_reg)
      ADD : begin
       result <= opA + opB;
       dp_done <= 1;
      end 
      SUB : begin
       result <= opA - opB;
       dp_done <= 1;
      end
      DIV : begin
       if(opB == 0)begin
        result <= 0;
        dp_done <= 1;
       end
       else if(opA >= opB)begin
       opA <= opA - opB;
       counter <= counter +1;
       end
       else begin
        result <= counter;
        dp_done <= 1;
       end
      end 
      MUL : begin
       if(counter < opB)begin 
        accumulator <= accumulator + opA;
        counter <= counter +1;
       end 
       else begin
        result <= accumulator;
        dp_done <= 1;
       end
     end
     default : begin
      dp_done <= 1;
      result <= 0;
     end
    endcase
   end
  end
 end
 
      
endmodule
