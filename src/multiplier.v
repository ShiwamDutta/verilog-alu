`timescale 1ns/1ps

// 8-bit Booth multiplier
module multiplier_8bit (
    input signed [7:0] multiplier, multiplicand,
    output reg signed [15:0] product,
    output reg zero
);

    integer i;
    reg signed [8:0] m;
    reg signed [17:0] comb; // {[A (9 bits)] [Q (8 bits)] [Q-1 (1 bit)]}

    always @(*) begin

        m = {multiplicand[7], multiplicand};
        comb = {9'b0, multiplier, 1'b0};

        for (i=0; i<8; i=i+1) begin
            case (comb[1:0])
                2'b01: comb[17:9] = comb[17:9] + m;
                2'b10: comb[17:9] = comb[17:9] - m;
                default: ;
            endcase
            comb = comb >>> 1; // R-Shift
        end

        product = comb[16:1]; // {[A (lower 8 bits)] [Q (8 bits)]}
        zero = ~|product;
    end

endmodule
