`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2026 22:04:35
// Design Name: 
// Module Name: tb
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


module tb();

reg clk;
reg rst;


reg  [7:0] s_tdata;
reg   s_tvalid;    
wire  s_tready;

wire  [7:0] m_tdata;
wire   m_tvalid;     
reg   m_tready ;        
   

axi_4 uut(
.clk(clk),
.rst(rst),
.s_tdata(s_tdata),
.s_tvalid(s_tvalid),
.s_tready(s_tready),
.m_tdata(m_tdata),
.m_tvalid(m_tvalid),
.m_tready(m_tready)
);


always #5 clk = ~clk;

initial begin
clk = 0;
rst = 0;
// inputs are zero
s_tdata = 0;
s_tvalid = 0;
m_tready = 0;
#20;

rst = 1;
#10;
$display("flow consistent");
repeat(10)begin
m_tready = 1;
s_tvalid = 1;
s_tdata = s_tdata +1;
end
#20;
s_tvalid = 0;
#20;

$display("backpressure");
m_tready = 0;
#10;
s_tvalid = 1;
s_tdata = 8'd255;
#20;

m_tready = 1;
#10;
s_tvalid = 0;
#30;

$display("mixed");
s_tvalid = 1;
#10;
s_tdata = 8'd200;
m_tready = 0;
#20;
m_tready = 1;
#10;
s_tvalid = 0;
#100;

$display("  finish");
$finish;


end











endmodule
