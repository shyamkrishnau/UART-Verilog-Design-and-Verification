module uart_tx (
    input wire clk,
    input wire reset,
    input wire [7:0] data_in,
    input wire start,
    output reg tx,
    output reg busy
);

parameter CLKS_PER_BIT = 10;

reg [3:0] clock_count;
reg [3:0] bit_index;

localparam IDLE       = 2'b00;
localparam START_BIT  = 2'b01;
localparam DATA_BITS  = 2'b10;
localparam STOP_BIT   = 2'b11;

reg [1:0] state;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        tx <= 1'b1;
        busy <= 1'b0;
        state <= IDLE;
        clock_count <= 0;
        bit_index <= 0;
        data_reg <= 0;
    end
    else begin
        if (state == IDLE) begin
            if (start) begin
                data_reg <= data_in;
                busy <= 1'b1;
                tx <= 1'b0;
                state <= START_BIT;
            end
        end
        else if (state == START_BIT) begin
            if (clock_count < CLKS_PER_BIT - 1) begin
                clock_count <= clock_count + 1;
            end
            else begin
                clock_count <= 0;
                bit_index <= 0;
                state <= DATA_BITS;
                tx <= data_reg[0];
            end
        end
        else if (state == DATA_BITS) begin
            if (clock_count < CLKS_PER_BIT - 1) begin
                clock_count <= clock_count + 1;
            end
            else begin
                clock_count <= 0;

                if (bit_index < 7) begin
                    bit_index <= bit_index + 1;
                    tx <= data_reg[bit_index + 1];
                end
                else begin
                    state <= STOP_BIT;
                    tx <= 1'b1;
                end
            end
        end
        else if (state == STOP_BIT) begin
            if (clock_count < CLKS_PER_BIT - 1) begin
                clock_count <= clock_count + 1;
            end
            else begin
                clock_count <= 0;
                busy <= 1'b0;
                state <= IDLE;
                tx <= 1'b1;
            end
        end
    end
end
endmodule
