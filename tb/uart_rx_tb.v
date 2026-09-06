`timescale 1ns/1ps

module uart_rx_tb;

    reg clk;
    reg reset;
    reg rx;

    wire [7:0] data_out;
    wire rx_done;

    uart_rx uut (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .data_out(data_out),
        .rx_done(rx_done)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        reset = 1;
        rx = 1;

        // Reset
        #20;
        reset = 0;

        // Idle
        #20;

        // Start bit
        rx = 0;
        #100;

        // Data bits: 10101010
        // LSB first

        rx = 0;
        #100;

        rx = 1;
        #100;

        rx = 0;
        #100;

        rx = 1;
        #100;

        rx = 0;
        #100;

        rx = 1;
        #100;

        rx = 0;
        #100;

        rx = 1;
        #100;

        // Stop bit
        rx = 1;
        #100;

        #50;

        $finish;

    end

endmodule
