`timescale 1ns / 1ps
module ip_project(
input wire clk ,// 100MHz  ana giriþ saati
input rst,
output led_50mhz,
output led_200mhz
    );
    
reg [24:0] counter_50 = 0;
reg [24:0] counter_200 = 0;    
    
wire clk_50;
wire clk_200;
wire locked;
 
 
// IP instance iþlemi 
 clk_wiz_0 instance_name
   (
    // Clock out ports
    .clk_out1(clk_50),     // output clk_out1
    .clk_out3(clk_200),     // output clk_out2
    // Status and control signals
    .reset(rst), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk(clk)      // input clk
);
// yavaþ blok 50MHz
always @(posedge clk_50) begin
    if (!locked) begin // ýp hazýr deðil
    counter_50 <=0;
    end
    else begin
    counter_50 <= counter_50 + 1;
    end

end
 
// Hýzlý blok 200Mhz
always @(posedge clk_200) begin
    if (!locked) begin // ýp hazýr deðil
    counter_200 <=0;
    end
    else begin
    counter_200 <= counter_200 + 1;
    end

end

//çýkýþ ledlerine atama bloðu
assign led_50mhz = counter_50[24];
assign led_200mhz= counter_200[24];
 
endmodule
