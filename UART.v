`timescale 1ns / 1ps
module UART #(
    parameter CLK_FREQ = 100_000_000,
    parameter BAUD_RATE = 115_200
)(
    input clk, rst,
    input rx,
    output tx,
    input [7:0] tx_data,
    input tx_start,
    output tx_done,
    output rx_done,
    output [7:0] rx_data   
);

    // Sabit hesaplama: Sentezleyici bunu sabit bir sayýya indirger 
    localparam [16:0] BAUD_DIV = CLK_FREQ / BAUD_RATE; 
    
    RX rx_inst(
        .clk(clk), .rst(rst), .rx_i(rx), .baud(BAUD_DIV),
        .d_out(rx_data), .rx_done(rx_done)
    );

    TX tx_inst(
        .clk(clk), .rst(rst), .baud(BAUD_DIV), .d_in(tx_data),
        .tx_start(tx_start), .tx_o(tx), .tx_done(tx_done) 
    );

endmodule