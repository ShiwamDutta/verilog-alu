`timescale 1ns/1ps

module adder_sub_8bit (
    input  [7:0] x, y,
    input        sub,   // 0=add, 1=sub
    output [7:0] z,
    output       c, v, zero
);

    wire [7:0] y_mux = y ^ {8{sub}};
    wire nibble_carry, zf1, zf2, o;

    cla_4bit cla1 (
        x[3:0], y_mux[3:0], sub, 
        z[3:0], nibble_carry, o, zf1
    );
    cla_4bit cla2 (
        x[7:4], y_mux[7:4], nibble_carry,
        z[7:4], c, v, zf2
    );

    assign zero = zf1 & zf2;

endmodule
