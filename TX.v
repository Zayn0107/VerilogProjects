`timescale 1ns / 1ps
module TX(
    input clk, rst,
    input [16:0] baud,
    input [7:0] d_in,
    input tx_start,
    output reg tx_o,
    output reg tx_done 
);

    reg [1:0] state;
    localparam IDLE  = 2'b00;    
    localparam START = 2'b01;     
    localparam DATA  = 2'b10;     
    localparam STOP  = 2'b11;

    reg [16:0] bittimer;
    reg [2:0]  bitcounter;
    reg [7:0]  tx_data_reg;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= IDLE;
            tx_o <= 1'b1; 
            tx_done <= 1'b0;
            bittimer <= 0;
            bitcounter <= 0;
        end else begin
            case(state)
                IDLE: begin
                    tx_done <= 1'b0;
                    tx_o <= 1'b1; 
                    if (tx_start) begin
                        tx_data_reg <= d_in; 
                        state <= START;
                        bittimer <= 0;
                    end
                end

                START: begin
                    tx_o <= 1'b0; // Start biti 
                    if (bittimer == baud - 1) begin
                        state <= DATA;
                        bittimer <= 0;
                        bitcounter <= 0;
                    end else begin
                        bittimer <= bittimer + 1;
                    end
                end

                DATA: begin
                    tx_o <= tx_data_reg[bitcounter]; // Bit bit gönder 
                    if (bittimer == baud - 1) begin
                        bittimer <= 0;
                        if (bitcounter == 7) begin
                            state <= STOP;
                        end else begin
                            bitcounter <= bitcounter + 1;
                        end
                    end else begin
                        bittimer <= bittimer + 1;
                    end
                end

                STOP: begin
                    tx_o <= 1'b1; // Stop biti 
                    if (bittimer == baud - 1) begin
                        tx_done <= 1'b1; 
                        state <= IDLE;
                    end else begin
                        bittimer <= bittimer + 1;
                    end
                end
                default: state <= IDLE;
            endcase
        end
    end
endmodule