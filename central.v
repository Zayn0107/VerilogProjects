`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2026 16:11:35
// Design Name: 
// Module Name: central
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


module central
#(parameter N = 16)(
input wire clk,
input wire rst,
input wire start,
input wire [N-1:0] first_data,
input wire [N-1:0] second_data,
input wire [2:0] operation,

output wire [2*N-1:0] result,
output wire done
    );
    
    
wire load;
wire compute_en;
wire dp_done;

fsm states(
.clk(clk),
.rst(rst),
.start(start),
.dp_done(dp_done),
.load(load),
.compute_en(compute_en),
.done(done)
);

datapath 
#(.N(N))
dp(
.clk(clk),
.rst(rst),
.load(load),
.compute_en(compute_en),
.first_data(first_data),
.second_data(second_data),
.operation(operation),
.result(result),
.dp_done(dp_done)
);



endmodule
