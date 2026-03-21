`timescale 1ns/1ps

module divider_unsigned_8bit (
    input  [7:0] dividend, divisor,
    output reg [7:0] quotient, remainder,
    output reg div_by_zero
);

    reg [3:0] i;
    reg [15:0] comb_reg; // {[A (8 bits)] [Q (8 bits)]}

    always @(*) begin
        div_by_zero = ~|divisor;

        if (div_by_zero) begin
            quotient = 8'b0;
            remainder = dividend;
        end
        else begin
            comb_reg = {8'b0, dividend};

            for (i = 0; i < 8; i = i + 1) begin
                comb_reg = comb_reg << 1;

                if (comb_reg[15:8] >= divisor) begin
                    comb_reg[15:8] = comb_reg[15:8] - divisor;
                    comb_reg[0] = 1'b1;
                end
            end

            remainder = comb_reg[15:8];     // [A (8 bits)]
            quotient  = comb_reg[7:0];      // [Q (8 bits)]
        end
    end

endmodule
