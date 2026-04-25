`timescale 1ns/1ps

module adder_sub #(
    parameter WIDTH = 8
) (
    input  [WIDTH - 1 : 0] x, y,
    input  sub,                     // 0=add, 1=sub
    output [WIDTH - 1 : 0] z,
    output c, v, zero
);

    wire [WIDTH - 1 : 0] y_mux = y ^ {WIDTH{sub}};

    wire [WIDTH / 4 - 1 : 0] zf, overflow;
    wire [WIDTH / 4 : 0] nibble_carry;

    assign nibble_carry[0] = sub;

    genvar i;
    generate
        for (i = 0; i < WIDTH / 4 ; i = i + 1) begin
            cla_4bit cla (
                .a(x[4 * i + 3 : 4 * i]),
                .b(y_mux[4 * i + 3 : 4 * i]),
                .c0(nibble_carry[i]),
                .sum(z[4 * i + 3 : 4 * i]),
                .c4(nibble_carry[i + 1]),
                .overflow(overflow[i]),
                .zero(zf[i])
            );
        end
    endgenerate

    assign v = overflow[WIDTH / 4 - 1];
    assign c = nibble_carry[WIDTH / 4];
    assign zero = &zf;

endmodule
