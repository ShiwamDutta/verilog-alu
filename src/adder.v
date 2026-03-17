`timescale 1ns/1ps

module adder_8bit (
    input  [7:0] x,
    input  [7:0] y,
    output [7:0] z,
    output c, v, zero
);

    wire nc, zf1, zf2, o;
    wire c_in = 1'b0;

    cla_4bit cla1 (
        x[3:0], y[3:0], c_in, 
        z[3:0], nc, o, zf1
    );
    cla_4bit cla2 (
        x[7:4], y[7:4], nc,
        z[7:4], c, v, zf2
    );

    assign zero = zf1 & zf2;

endmodule
