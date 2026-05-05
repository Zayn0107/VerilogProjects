`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2026 21:58:55
// Design Name: 
// Module Name: axi_4
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


module axi_4(
input clk,
input rst,
//Slave
input [7:0] s_tdata,
input s_tvalid,
output s_tready,

//Master
output reg [7:0] m_tdata,
output reg m_tvalid,
input  m_tready
    );
  assign s_tready = m_tready || !m_tvalid; //Backpressure  
    always @(posedge clk or negedge rst)begin
      if(!rst)begin
       m_tvalid <= 0;
      end
      else begin
        if(s_tready)begin
         m_tvalid <= s_tvalid;
         if(s_tvalid)begin
          m_tdata <= s_tdata;
         end
        end
      
      end
     
    end
    
    
    
    
    
    
    
endmodule








