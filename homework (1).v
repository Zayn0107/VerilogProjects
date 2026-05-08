`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.02.2026 15:13:12
// Design Name: 
// Module Name: homework
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


module homework
#(parameter N = 16)( // N benim parametremin geniþliði
input wire clk,
input wire rst,
input wire dp_done,


output reg load,
output reg compute_en,
output reg done
   );
    
localparam IDLE = 2'b00;
localparam COMPUTE = 2'b01;
localparam DONE = 2'b10;

localparam ADD = 3'b001;
localparam SUB = 3'b010;
localparam DIV = 3'b011;
localparam MUL = 3'b100;

reg [N-1 :0]counter;
reg [2*N-1 :0] temp;


always @(posedge clk)begin
  if(rst)begin 
    state <= IDLE;
    counter <= 0;
    temp <= 0;
    done_flag <= 1'b0;
    result <= 0;
    end
   else begin
     case(state)
     IDLE : begin
      done_flag <= 0;
      if(operation != 3'b000  )begin
      counter <= 0;
      temp <= 0;
      state <= COMPUTE;
      if(operation == DIV) begin 
       temp <= first_data;
      end
   
      end
      end
     COMPUTE : begin
       case(operation)
       ADD : begin
        result <= first_data + second_data;
        state <= DONE;
       end 
       SUB : begin
        result <= first_data - second_data;
        state <= DONE;
       end
       MUL : begin
        if (counter < second_data) begin
            temp <= temp + first_data;
            counter  <= counter + 1;
            end 
        else begin
            result <= temp;
            state  <= DONE;
            end
       end
       DIV: begin
        if (second_data != 0 && temp >= second_data) begin
        temp <= temp - second_data;
        counter  <= counter + 1;
       end
       else begin
        result <= counter; // Bölüm sonucu
        state  <= DONE;
        end
       end
       default: 
        state <= IDLE;
       endcase
       end
     DONE : begin
       done_flag <= 1;
       state <= IDLE;
     end
     
     endcase
     end 
     end
     
endmodule