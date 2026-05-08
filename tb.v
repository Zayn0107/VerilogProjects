`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2026 16:49:43
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

reg clk;// 100MHz
reg rst; 
reg SW0;
reg SW1;  
wire led_5mhz ;    
wire led_50mhz ; 
wire led_100mhz ; 
 
speed_control uut(
.clk (clk),
.rst (rst),
. SW0( SW0),
. SW1( SW1),
.led_5mhz(led_5mhz),
.led_50mhz(led_50mhz),
.led_100mhz(led_100mhz)
); 
 
always #5 clk=~clk;
initial begin
    clk = 0;
    rst = 1;
    SW0 = 0;
    SW1 = 0;

    #200 rst = 0;

    repeat (100) begin
        #200 {SW1,SW0} = 2'b00;
        #200 {SW1,SW0} = 2'b01;
        #200 {SW1,SW0} = 2'b10;
        #200 {SW1,SW0} = 2'b11;
    end

    #1000 $finish;
end
endmodule
