`timescale 1ns / 1ps

module top(
    input clk,              // Basys3 100MHz Saat 
    input btnC,             // Veri göndermeyi tetikleyen orta buton
    input RsRx,             // Bilgisayardan gelen veri hattý 
    output RsTx,            // Bilgisayara giden veri hattý 
    output [7:0] led        // Gelen veriyi gösterecek 8 adet LED
);

    // Dahili sinyaller
    wire [7:0] rx_data_out;
    wire rx_done_sig;
    wire tx_done_sig;
    reg [7:0] internal_led_reg;

    // HTerm'den veri geldiðinde LED'leri güncelle
    always @(posedge clk) begin
        if (rx_done_sig) begin
            internal_led_reg <= rx_data_out; // Gelen veriyi LED register'ýna yaz 
        end
    end

    // UART Modülünün Çaðrýlmasý 
    UART #(
        .CLK_FREQ(100_000_000), // 100 MHz 
        .BAUD_RATE(115_200)     // HTerm ile ayný olmalý 
    ) uart_unit (
        .clk(clk),
        .rst(1'b1),             // Basys3'te rst aktif düþükse butona baðlanabilir 
        .rx(RsRx),              // RX giriþi 
        .tx(RsTx),              // TX çýkýþý 
        .tx_data(8'h41),        // Sabit 'A' harfi 
        .tx_start(btnC),        // Orta butona basýnca gönder 
        .tx_done(tx_done_sig),
        .rx_done(rx_done_sig),  // Veri baþarýyla alýndý sinyali 
        .rx_data(rx_data_out)   // Alýnan 8 bitlik veri 
    );

    // LED çýkýþ baðlantýsý
    assign led = internal_led_reg;

endmodule