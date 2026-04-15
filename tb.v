`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2026 15:06:17
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

parameter [31:0] SIFRE = 32'hA4A4_B1B1;
parameter [7:0] LIMIT = 8'd16;


reg clk;
reg rst;
reg key_ready;
reg [31:0] code_in;
reg code_valid;

wire erase_key;
wire load;
wire [2:0] control_state;



kasa 
#(.SIFRE(SIFRE),
.LIMIT(LIMIT))
uut(
.clk(clk),
.rst(rst),
.key_ready(key_ready),
.code_in(code_in),
.code_valid(code_valid),
.erase_key(erase_key),
.load(load),
.control_state(control_state)
);

always #5 clk = ~clk;

initial begin
clk = 0;
rst = 1;
key_ready = 0;
code_in = 0;
code_valid = 0;
#20;
rst = 0;
#10;
key_ready = 1;
#200;
code_valid = 1;
#10;
code_in = SIFRE;
#10;
code_valid = 0;
#10;
key_ready = 0;
#20;
rst = 1;
#10;
rst = 0;
#10;
key_ready = 1;
#200;
code_valid = 1;
#10;
code_in = 32'hA4A4_A4A4;
#10;
key_ready = 0;

#20;
if(erase_key == 1 && control_state == 3'b100)
$display("hata var");
$finish;

end

endmodule
