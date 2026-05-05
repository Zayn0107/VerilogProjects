`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2026 17:53:22
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
reg [7:0] in0, in1, in2, in3;
reg [7:0] threshold;
wire alarm;

pipeline uut(
.clk(clk),
.rst(rst),
.in0(in0),
.in1(in1),
.in2(in2),
.in3(in3),
.threshold(threshold),
.alarm(alarm)
);

always #5 clk = ~clk;

initial begin 
clk = 0;
rst = 0;

in0 = 8'd0;
in1 = 8'd0;
in2 = 8'd0;
in3 = 8'd0;
threshold = 8'd0;

#20;
rst = 1;
$display("Start");
in0 = 8'd10;
in1 = 8'd200;
in2 = 8'd164;
in3 = 8'd255;
threshold = 8'd250;
#10;
$display("time %t | sum %d | alarm %b", $time, (in0 + in1 + in2 + in3) , alarm);
#20;
in0 = 8'd255;
in1 = 8'd255;
in2 = 8'd255;
in3 = 8'd255;
threshold = 8'd255;
#10;
$display("time %t | sum %d | alarm %b", $time, (in0 + in1 + in2 + in3) , alarm);
#20;
in0 = 8'd50;
in1 = 8'd55;
in2 = 8'd10;
in3 = 8'd15;
threshold = 8'd200;
#10;
$display("time %t | sum %d | alarm %b", $time, (in0 + in1 + in2 + in3) , alarm);
#20;
$display("Finish");
$finish;
end
endmodule
