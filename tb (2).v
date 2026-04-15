`timescale 1ns / 1ps
module tb;
reg clk;// 100MHz
reg rst;      
wire led_50mhz ;
wire led_200mhz;
 
ip_project uut(
.clk (clk),
.rst (rst),
.led_50mhz (led_50mhz ),
.led_200mhz(led_200mhz)
); 
 
always #5 clk=~clk;
initial begin
clk=0;
rst=1;
#30;
rst=0;
#2000;
$finish;
end
endmodule
