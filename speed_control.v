`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2026 16:23:19
// Design Name: 
// Module Name: speed_control
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


module speed_control(
input clk ,// 100MHz  ana giriþ saati
input rst,
input  SW0,
input  SW1,
output led_5mhz,
output led_50mhz,
output led_100mhz
    );
reg [26:0] counter_5 = 0;  
reg [26:0] counter_50 = 0;    
reg [26:0] counter_100 = 0;  

wire clk_5;  
wire clk_50;
wire clk_100;
wire locked;
 

clk_wiz_0 clk_inst (
    .clk_in1(clk),
    .reset(rst),
    .clk_out1(clk_5),
    .clk_out2(clk_50),
    .clk_out3(clk_100),
    .locked(locked)
);



wire selected_clk;

assign selected_clk =
    (SW1==0 && SW0==1) ? clk_5 :
    (SW1==1 && SW0==0) ? clk_50  :
    (SW1==1 && SW0==1) ? clk_100 :
    1'b0;
always @(posedge clk_5 or posedge rst)
    if(rst) counter_5 <= 0;
    else if(locked) counter_5 <= counter_5 + 1;

always @(posedge clk_50 or posedge rst)
    if(rst) counter_50 <= 0;
    else if(locked) counter_50 <= counter_50 + 1;

always @(posedge clk_100 or posedge rst)
    if(rst) counter_100 <= 0;
    else if(locked) counter_100 <= counter_100 + 1;



//çýkýþ ledlerine atama bloðu
assign led_5mhz  = counter_5[4:3];
assign led_50mhz   = counter_50[4:3];
assign led_100mhz  = counter_100[4:3];


endmodule
