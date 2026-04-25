`timescale 1ns/1ps

// Combinational Booth multiplier
module multiplier #(
    parameter WIDTH = 8
) (
    input signed [WIDTH - 1 : 0] multiplier, multiplicand,
    output reg signed [2 * WIDTH - 1 : 0] product,
    output reg zero
);

    integer i;
    reg signed [WIDTH:0] m;
    reg signed [2 * WIDTH + 1 : 0] comb; // [A (W+1) | Q (W) | Q-1 (1)]

    always @(*) begin

        m = {multiplicand[WIDTH - 1], multiplicand};
        // comb = {A=0, Q=multiplier, Q-1=0}
        comb = {{(WIDTH + 1){1'b0}}, multiplier, 1'b0};

        for (i = 0; i < WIDTH; i = i + 1) begin
            case (comb[1:0])
                2'b01: comb[2 * WIDTH + 1 : WIDTH + 1] =
                        comb[2 * WIDTH + 1 : WIDTH + 1] + m;
                2'b10: comb[2 * WIDTH + 1 : WIDTH + 1] =
                        comb[2 * WIDTH + 1 : WIDTH + 1] - m;
                default: ;
            endcase
            comb = comb >>> 1; // R-Shift
        end

        // separate comb register
        product = comb[2 * WIDTH : 1]; // [A (lower W bit) | Q (W)]
        zero = ~|product;
    end

endmodule
