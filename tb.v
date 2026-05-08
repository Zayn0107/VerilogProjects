`timescale 1ns / 1ps

module tb;
parameter THRESHOLD = 100;
reg clk;
reg rst;
reg start;
wire [7:0] led;

top
#(.THRESHOLD(THRESHOLD)) uut(
.clk(clk),
.rst(rst),
.start(start),
.led(led)
);

always #5 clk = ~clk;

initial begin
clk = 0;
rst = 0;
start = 0;

#20;
rst = 1;

#20;
start = 1;
#10;
start = 0;

#300;

$display("RESULT = %d", uut.acc.result);

$finish;
end

endmodule