`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2026 16:14:47
// Design Name: 
// Module Name: fsm
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


module fsm(
input wire clk,
input wire rst,
input wire start,
input wire dp_done,

output reg load,
output reg compute_en,
output reg done
    );
    
localparam IDLE = 2'b00;
localparam LOAD = 2'b01;
localparam COMPUTE = 2'b10;
localparam DONE = 2'b11;

reg [1:0] state;


always @(posedge clk)begin
 if(rst)begin
   state <= IDLE;
   load <= 0;
   compute_en <= 0;
   done <= 0;
 end
 else begin
  load <= 0;
  compute_en <= 0;
  done <= 0;
  case(state)
    IDLE : begin
      if(start)begin
        state <= LOAD;
      end
     end
    LOAD : begin
     load <= 1;
     state <= COMPUTE;
    end
    COMPUTE : begin
      compute_en <= 1;
      if(dp_done)begin
        state = DONE;
      end
     end
    DONE : begin
      done <= 1;
      state <= IDLE;
    end
    endcase
  end
end 
  
always @(*)begin
   load <= 0;
   compute_en <= 0;
   done <= 0;
   
   
   case(state)
     IDLE : begin
       if(start)begin
         load <= 1;
       end 
     end 
     
     COMPUTE : begin
       compute_en <= 1;
     end 
     
     DONE : begin
       done <= 1;
     end 
   endcase 
end
      
        

endmodule
