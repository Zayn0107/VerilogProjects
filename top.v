`timescale 1ns / 1ps

module top
#(parameter THRESHOLD = 100)(
input  wire clk,
input  wire rst, 
input  wire start,
output wire [7:0] led
);

wire [31:0] result;
wire done;

wire [5:0]  ARADDR;
wire        ARVALID;
wire        ARREADY;
wire [31:0] RDATA;
wire        RVALID;
wire        RREADY;
wire [1:0]  RRESP;

accelerator acc(
.ACLK(clk),
.ARESETN(rst),   
.start(start),
.base(8'd0),
.ARADDR(ARADDR),
.ARVALID(ARVALID),
.ARREADY(ARREADY),
.RDATA(RDATA),
.RVALID(RVALID),
.RREADY(RREADY),
.result(result),
.done(done)
);

axi_ram ram(
.ACLK(clk),
.ARESETN(rst),
.ARADDR(ARADDR),
.ARVALID(ARVALID),
.ARREADY(ARREADY),
.RDATA(RDATA),
.RVALID(RVALID),
.RREADY(RREADY),
.RRESP(RRESP)
);


reg [23:0] led_control;
reg blink;

always @(posedge clk) begin
    if (!rst) begin
        led_control <= 0;
        blink <= 0;
    end
    else begin
        led_control <= led_control + 1;
        if (led_control == 0)
            blink <= ~blink;
    end
end

assign led = (result > THRESHOLD) ?
             (blink ? result[31:24] : 8'd0) :
             result[31:24];

endmodule