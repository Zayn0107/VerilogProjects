`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2026 16:46:53
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

parameter N = 16;


reg clk;
reg rst;
reg start;
reg [N-1:0] first_data;
reg [N-1:0] second_data;
reg [2:0] operation;

wire [2*N-1:0] result;
wire done;

central 
#(.N(N)) uut(
.clk(clk),
.rst(rst),
.start(start),
.first_data(first_data),
.second_data(second_data),
.operation(operation),
.result(result),
.done(done)
);

always #5 clk = ~clk;

initial begin
 clk = 0;
 rst = 1;
 start = 0;
 first_data = 0;
 second_data = 0;
 operation = 0;
 
 #20;
 rst = 0;
 
 //ADDITION
 @(posedge clk);
 first_data <= 16'd10;
 second_data <= 16'd20;
 operation <= 3'b000;
 start <= 1;
 @(posedge clk);
 start <= 0;
@(posedge done);
 #50;
 
 @(posedge clk);
 first_data <= 16'd20;
 second_data <= 16'd10;
 operation <= 3'b001;
 start <= 1;
 @(posedge clk);
 start <= 0;
@(posedge done);

#50;
 @(posedge clk);
 first_data <= 16'd20;
 second_data <= 16'd4;
 operation <= 3'b010;
 start <= 1;
 @(posedge clk);
 start <= 0;
@(posedge done);

#50;
 @(posedge clk);
 first_data <= 16'd4;
 second_data <= 16'd5;
 operation <= 3'b011;
 start <= 1;
 @(posedge clk);
 start <= 0;
@(posedge done);
#50;
$finish;
end





endmodule
