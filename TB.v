`timescale 1ns / 1ps

module TB();

    // Parametreler
    parameter CLK_FREQ = 100_000_000;
    parameter BAUD_RATE = 115_200;
    parameter CLK_PERIOD = 10; // 100MHz -> 10ns

    // Test Sinyalleri 
    reg clk;
    reg rst;
    reg rx;
    wire tx;
    reg [7:0] tx_data;
    reg tx_start;
    wire tx_done;
    wire rx_done;
    wire [7:0] rx_data;

   
   
    UART #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) uut (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .tx(tx),
        .tx_data(tx_data),
        .tx_start(tx_start),
        .tx_done(tx_done),
        .rx_done(rx_done),
        .rx_data(rx_data)
    );

    // Loopback Baðlantýsý: TX'ten çýkaný RX'e geri besle
    always @(*) rx = tx;

    // Saat Üretici
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Test Senaryosu
    initial begin
        // --- 1. Baþlatma ve Reset ---
        rst = 0;
        tx_start = 0;
        tx_data = 8'h0;
        $display("--- Test Basliyor: Reset Uygulaniyor ---");
        #(CLK_PERIOD * 10);
        rst = 1; // Reset býrakýldý 
        #(CLK_PERIOD * 10);

        // --- 2. Senaryo: 0xA5 Verisini Gönder ve Bekle ---
        #10;
        tx_data = 8'hA5; // Gönderilecek veri 
        tx_start = 1;    // Ýletiþimi baþlat 
        #10;
        tx_start = 0;    // Start sinyalini çek
        $display("[TX] 0xA5 gonderiliyor...");

        wait(rx_done);   // Alýcýnýn iþlemi bitirmesini bekle 
        if (rx_data === 8'hA5) 
            $display("[SUCCESS] Gelen veri dogru: %h", rx_data);
        else 
            $display("[ERROR] HATA! Beklenen: A5, Gelen: %h", rx_data);
        
        #(CLK_PERIOD * 100); // Paketler arasý bekleme

        // --- 3. Senaryo: 0x5A Verisini Gönder ve Bekle ---
        #10;
        tx_data = 8'h5A;
        tx_start = 1;
        #10;
        tx_start = 0;
        $display("[TX] 0x5A gonderiliyor...");

        wait(rx_done);
        if (rx_data === 8'h5A) 
            $display("[SUCCESS] Gelen veri dogru: %h", rx_data);
        else 
            $display("[ERROR] HATA! Beklenen: 5A, Gelen: %h", rx_data);

        // --- 4. Testi Bitir ---
        #(CLK_PERIOD * 200);
        $display("--- Tum Testler Tamamlandi ---");
        $finish;
    end

endmodule