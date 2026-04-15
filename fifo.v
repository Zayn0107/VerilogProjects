`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2026 16:04:24
// Design Name: 
// Module Name: fifo
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


module fifo
#(parameter DATA_W = 8, // HER SATIRIN BÝT GENÝÞLÝÐÝ
parameter ADDR_W = 4, //TOTALDE 2^4 SATIR VAR
parameter DERINLIK = 16)(
input clk,
input rst,

input wr_en,
input [DATA_W-1:0] wr_data,

input rd_en,
output reg [DATA_W-1:0] rd_data,

output full,
output empty
    );
    
reg [DATA_W-1:0] mem [0:DERINLIK-1];

reg [ADDR_W-1:0] wr_ptr;
reg [ADDR_W-1:0] rd_ptr;
reg [ADDR_W:0] counter;

assign empty = (counter == 0);
assign full = (counter == DERINLIK);

//yazma
always @(posedge clk or negedge rst)begin
if(!rst)begin
  wr_ptr <= 4'b0;
end
else if(wr_en && !full)begin
  mem[wr_ptr] <= wr_data;
  wr_ptr <= wr_ptr + 1;
end
end

//okuma
always @(posedge clk or negedge rst)begin
if(!rst)begin
rd_ptr <= 4'b0;
rd_data <= 8'b0;
end
else if(rd_en && !empty)begin
rd_data <= mem[rd_ptr];
rd_ptr <= rd_ptr + 1;
end
end

//sayaç atamasý
always @(posedge clk or negedge rst)begin
if(!rst)begin
counter <= 0;
end
else begin
case({wr_en && !full, rd_en && !empty})
  2'b10 : counter <= counter + 1;
  2'b01 : counter <= counter - 1;
  default : counter <= counter;


endcase
end

end


endmodule
