`timescale 1ns/1ps

module cla_4bit (
    input  [3:0] a, b,
    input  c0,
    output [3:0] sum,
    output c4,
    output overflow,
    output zero
);

    wire [3:0] p, g;
    wire c1, c2, c3;

    // pg logic
    assign p = a ^ b;
    assign g = a & b;

    // lookahead carry equations
    assign c1 = g[0] |
            (p[0] & c0);

    assign c2 = g[1] |
            (p[1] & g[0]) |
            (p[1] & p[0] & c0);

    assign c3 = g[2] |
            (p[2] & g[1]) |
            (p[2] & p[1] & g[0]) |
            (p[2] & p[1] & p[0] & c0);

    assign c4 = g[3] |
            (p[3] & g[2]) |
            (p[3] & p[2] & g[1]) |
            (p[3] & p[2] & p[1] & g[0]) |
            (p[3] & p[2] & p[1] & p[0] & c0);

    // sums
    assign sum[0] = p[0] ^ c0;
    assign sum[1] = p[1] ^ c1;
    assign sum[2] = p[2] ^ c2;
    assign sum[3] = p[3] ^ c3;

    // flag
    assign overflow = c4 ^ c3;
    assign zero = ~|sum;

endmodule
