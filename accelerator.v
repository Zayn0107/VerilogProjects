`timescale 1ns / 1ps

module accelerator #(
parameter ADDR_W = 8,
parameter DATA_W = 32
)(
input  wire                 ACLK,
input  wire                 ARESETN,
input  wire                 start,
input  wire [ADDR_W-1:0]    base,

// AXI Reading ADDRES
output reg  [ADDR_W-1:0]    ARADDR,
output reg                  ARVALID,
input  wire                 ARREADY,

// AXI Reading DATA
input  wire [DATA_W-1:0]    RDATA,
input  wire                 RVALID,
output reg                  RREADY,

output reg  [DATA_W-1:0]    result,
output reg                  done
);


// FSM States
reg [2:0] state;
localparam IDLE     = 3'd0;
localparam READ_A   = 3'd1;
localparam READ_B   = 3'd2;
localparam READ_C   = 3'd3;
localparam COMPUTE = 3'd4;
localparam DONE     = 3'd5;



reg [31:0] A, B, C;
reg [31:0] multiplication;

reg addr_sent;   

always @(posedge ACLK) begin
    if (!ARESETN) begin
        state      <= IDLE;
        ARVALID    <= 0;
        RREADY     <= 0;
        done       <= 0;
        addr_sent  <= 0;
        result     <= 0;
        multiplication   <= 0;
    end
    else begin
        case(state)

        IDLE: begin
            done <= 0;
            RREADY <= 0;
            addr_sent <= 0;

            if (start)
                state <= READ_A;
        end

        READ_A: begin
            RREADY <= 1;

            if (!addr_sent) begin
                ARADDR    <= base + 8'd0;
                ARVALID   <= 1;
                addr_sent <= 1;
            end

            if (ARVALID && ARREADY) //address handshake
                ARVALID <= 0;

            if (RVALID && RREADY) begin //data handshake
                A <= RDATA;
                addr_sent <= 0;
                state <= READ_B;
            end
        end

        READ_B: begin
            RREADY <= 1;

            if (!addr_sent) begin
                ARADDR    <= base + 8'd4;
                ARVALID   <= 1;
                addr_sent <= 1;
            end

            if (ARVALID && ARREADY)
                ARVALID <= 0;

            if (RVALID && RREADY) begin
                B <= RDATA;
                addr_sent <= 0;
                state <= READ_C;
            end
        end

      
        READ_C: begin
            RREADY <= 1;

            if (!addr_sent) begin
                ARADDR    <= base + 8'd8;
                ARVALID   <= 1;
                addr_sent <= 1;
            end

            if (ARVALID && ARREADY)
                ARVALID <= 0;

            if (RVALID && RREADY) begin
                C <= RDATA;
                addr_sent <= 0;
                RREADY <= 0;
                state <= COMPUTE;
            end
        end

        COMPUTE: begin
            multiplication <= A * B;
            state <= DONE;
        end

        DONE: begin
            result <= multiplication + C;
            done <= 1;
            state <= IDLE;
        end

        endcase
    end
end

endmodule