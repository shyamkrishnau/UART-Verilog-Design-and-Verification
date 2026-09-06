module uart_rx (
    input wire clk,
    input wire reset,
    input wire rx,
    output reg [7:0] data_out,
    output reg rx_done
);

parameter CLKS_PER_BIT = 10;

reg [3:0] clock_count;
reg [3:0] bit_index;

localparam IDLE       = 2'b00;
localparam START_BIT  = 2'b01;
localparam DATA_BITS  = 2'b10;
localparam STOP_BIT   = 2'b11;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        rx_done <= 1'b0;
        data_out <= 8'b0;
        state <= IDLE;
        clock_count <= 0;
        bit_index <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                rx_done <= 1'b0;
                clock_count <= 0;
                bit_index <= 0;
                
                if (rx == 1'b0) begin
                    state <= START_BIT;
                end
            end

            START_BIT: begin
                if (clock_count == (CLKS_PER_BIT - 1) / 2) begin
                    if (rx == 1'b0) begin
                        clock_count <= 0;
                        state <= DATA_BITS;
                    end
                    else begin
                        state <= IDLE;
                    end
                end
                else begin
                    clock_count <= clock_count + 1;
                end
            end

            DATA_BITS: begin
                if (clock_count < CLKS_PER_BIT - 1) begin
                    clock_count <= clock_count + 1;
                end
                else begin
                    clock_count <= 0;
                    data_out[bit_index] <= rx;

                    if (bit_index < 7) begin
                        bit_index <= bit_index + 1;
                    end
                    else begin
                        bit_index <= 0;
                        state <= STOP_BIT;
                    end
                end
            end

            STOP_BIT: begin
                if (clock_count < CLKS_PER_BIT - 1) begin
                    clock_count <= clock_count + 1;
                end
                else begin
                    clock_count <= 0;
                    rx_done <= 1'b1;
                    state <= IDLE;
                end
            end

            default: state <= IDLE;
        endcase
    end
end

endmodule
