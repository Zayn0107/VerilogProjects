`timescale 1ns / 1ps

module axi_ram #(
parameter ADDR_W = 8,    
parameter DATA_W = 32
)(
input  wire                 ACLK,
input  wire                 ARESETN,

input  wire [ADDR_W-1:0]    ARADDR,
input  wire                 ARVALID,
output reg                  ARREADY,


output reg  [DATA_W-1:0]    RDATA,
output reg                  RVALID,
input  wire                 RREADY,
output wire [1:0]           RRESP
);

assign RRESP = 2'b00; 

reg [31:0] mem [0:15];
reg [3:0]  addr_reg;
reg        addr_latched;

wire [3:0] word_addr = ARADDR[5:2];

integer i;

always @(posedge ACLK) begin
    if (!ARESETN) begin
        ARREADY      <= 0;
        RVALID       <= 0;
        addr_latched <= 0;

        mem[0] <= 32'd10;
        mem[1] <= 32'd5;
        mem[2] <= 32'd20;

        for(i=3;i<16;i=i+1)
            mem[i] <= 0;
    end
    else begin

        if (!addr_latched && ARVALID) begin
            ARREADY      <= 1;
            addr_reg     <= word_addr;
            addr_latched <= 1;
        end
        else begin
            ARREADY <= 0;
        end

        if (addr_latched && !RVALID) begin
            RDATA  <= mem[addr_reg];
            RVALID <= 1;
        end

        if (RVALID && RREADY) begin
            RVALID       <= 0;
            addr_latched <= 0;
        end
    end
end

endmodule