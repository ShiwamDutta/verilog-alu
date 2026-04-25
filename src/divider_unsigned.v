`timescale 1ns/1ps

module divider_unsigned #(
    parameter WIDTH = 8
) (
    input  [WIDTH - 1 : 0] dividend, divisor,
    output reg [WIDTH - 1 : 0] quotient, remainder,
    output reg div_by_zero
);

    integer i;
    reg [2 * WIDTH - 1 : 0] comb_reg; // {[A (N bits)] [Q (N bits)]}

    always @(*) begin
        div_by_zero = ~|divisor;

        if (div_by_zero) begin
            quotient = {WIDTH{1'b0}};
            remainder = dividend;
        end
        else begin
            comb_reg = {{WIDTH{1'b0}}, dividend};

            for (i = 0; i < WIDTH; i = i + 1) begin
                comb_reg = comb_reg << 1;

                if (comb_reg[2 * WIDTH - 1 : WIDTH] >= divisor) begin
                    comb_reg[2 * WIDTH - 1 : WIDTH] =
                        comb_reg[2 * WIDTH - 1 : WIDTH] - divisor;
                    comb_reg[0] = 1'b1;
                end
            end

            remainder = comb_reg[2 * WIDTH - 1 : WIDTH];     // [A (N bits)]
            quotient  = comb_reg[WIDTH - 1 : 0];             // [Q (N bits)]
        end
    end

endmodule
