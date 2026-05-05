`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2026 22:32:31
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


///DSP SLICE!!!!!

module tb();
parameter WIDTH = 32;

reg clk;
reg rst;
reg [WIDTH-1:0] data_a, data_b;
reg [WIDTH-1:0] data_c, data_d;
wire [2*WIDTH-1:0] result;

mac#(.WIDTH(WIDTH))
 uut(
.clk(clk),
.rst(rst),
.data_a(data_a),
.data_b(data_b),
.data_c(data_c),
.data_d(data_d),
.result(result)
);

always #5 clk = ~clk;

initial begin 
clk = 0;
rst = 0;
data_a = 32'd0;
data_b = 32'd0;
data_c = 32'd0;
data_d = 32'd0;

#20;
rst = 1;
#10;
data_a = 32'd10;
data_b = 32'd20;
data_c = 32'd5;
data_d = 32'd20;

#10;

data_a = 32'd600;
data_b = 32'd100;
data_c = 32'd480;
data_d = 32'd120;

#10;
#100;
$finish;
end


endmodule
