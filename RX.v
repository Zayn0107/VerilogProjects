`timescale 1ns / 1ps
module RX(
    input clk,
    input rst,
    input rx_i,
    input [16:0] baud, 
    output [7:0] d_out,
    output reg rx_done
);

    reg [1:0] state;
    localparam IDLE  = 2'b00;    
    localparam START = 2'b01;     
    localparam DATA  = 2'b10;     
    localparam STOP  = 2'b11;

    // Metastabilite önleyici senkronizör 
    reg rx_sync_r1, rx_sync_r2;
    always @(posedge clk) begin
        rx_sync_r1 <= rx_i;
        rx_sync_r2 <= rx_sync_r1;
    end

    reg [16:0] bittimer;
    reg [2:0]  bitcounter;
    reg [7:0]  data_shifter;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= IDLE;
            rx_done <= 1'b0;
            bittimer <= 0;
            bitcounter <= 0;
            data_shifter <= 8'd0;
        end else begin
            case(state)
                IDLE: begin
                    rx_done <= 1'b0;
                    bittimer <= 0;
                    bitcounter <= 0;
                    if (rx_sync_r2 == 1'b0) begin // Baþlangýç biti algýlandý 
                        state <= START;
                    end
                end

                START: begin
                    if (bittimer == (baud >> 1)) begin // Orta noktada örnekle 
                        if (rx_sync_r2 == 1'b0) begin // Hala 0 ise geçerli START
                            bittimer <= 0;
                            state <= DATA;
                        end else begin
                            state <= IDLE; // Glitch ise geri dön
                        end
                    end else begin
                        bittimer <= bittimer + 1;
                    end
                end

                DATA: begin
                    if (bittimer == baud - 1) begin
                        bittimer <= 0;
                        data_shifter <= {rx_sync_r2, data_shifter[7:1]}; // LSB first 
                        if (bitcounter == 7) begin
                            state <= STOP;
                            bitcounter <= 0;
                        end else begin
                            bitcounter <= bitcounter + 1;
                        end
                    end else begin
                        bittimer <= bittimer + 1;
                    end
                end

                STOP: begin
                    if (bittimer == baud - 1) begin
                        if (rx_sync_r2 == 1'b1) begin // STOP biti geçerli mi?
                            rx_done <= 1'b1; 
                        end
                        state <= IDLE;
                        bittimer <= 0;
                    end else begin
                        bittimer <= bittimer + 1;
                    end
                end
                default: state <= IDLE;
            endcase
        end
    end

    assign d_out = data_shifter; 
endmodule