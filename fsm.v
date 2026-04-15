`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2026 14:47:42
// Design Name: 
// Module Name: kasa
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


module kasa
#(parameter SIFRE = 32'HA4A4_B1B1,
parameter LIMIT = 8'd16)(
input clk,
input rst,
input key_ready,
input [31:0] code_in,
input code_valid,

output reg erase_key,
output reg load,
output reg [2:0] control_state
    );
    
 localparam LOCKED = 3'b000;  
 localparam CHALLENGE = 3'b001;  
 localparam VALIDATION = 3'b010;   
 localparam SECURELOAD = 3'b011;   
 localparam TAMPER = 3'b100;   
    
 reg [7:0] counter;
 
 always @(posedge clk or posedge rst)begin
 if(rst)begin
 control_state <= LOCKED;
 counter <= 8'd0;
 erase_key <= 1'b0;
 load <= 1'b0;
 end
 else begin
 case(control_state)
   LOCKED: begin
    if(key_ready)begin
      control_state <= CHALLENGE;
    end
   end
   
   CHALLENGE: begin
    if(code_valid)begin
      if(counter <= LIMIT)begin
         control_state <= VALIDATION;
      end
      else begin
        control_state <= TAMPER;
      end
    end
    else if(counter >= LIMIT)begin
      control_state <= TAMPER;
    end
    else begin
      counter <= counter + 1;
    end
   end
   
   VALIDATION : begin
     if(code_in == SIFRE)begin
       control_state <= SECURELOAD;
     end
     else begin
       control_state <= TAMPER;
     end
 end
    SECURELOAD : begin
      load <= 1'b1;
      control_state <= LOCKED;
    end
    
    TAMPER : begin
      erase_key <= 1'b1;
      control_state <= TAMPER;
    end
    default : control_state <= TAMPER;
 
 endcase
 
 end
 
 
 
 
 
 end
    
    
    
    
    
    
endmodule
