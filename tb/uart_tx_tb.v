`timescale 1ns/1ps

module uart_tx_tb;

    // Inputs
    reg clk;
    reg reset;
    reg start;
    reg [7:0] data_in;

    // Outputs
    wire tx;
    wire busy;

    // Instantiate UART Transmitter
    uart_tx uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .data_in(data_in),
        .tx(tx),
        .busy(busy)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        // Initialize signals
        clk = 0;
        reset = 1;
        start = 0;
        data_in = 8'b00000000;

        // Reset
        #20;
        reset = 0;

        // Send data
        #20;
        data_in = 8'b10101010;
        start = 1;

        #10;
        start = 0;

        // Wait for transmission to complete
        #200;

        // Send another data byte
        data_in = 8'b11001100;
        start = 1;

        #10;
        start = 0;

        #200;

        $finish;

    end

endmodule
