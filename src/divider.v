`timescale 1ns/1ps

module divider #(
    parameter WIDTH = 8
) (
    input  signed [WIDTH - 1 : 0] dividend, divisor,
    output signed [WIDTH - 1 : 0] quotient, remainder,
    output div_by_zero, overflow
);

    localparam MAX_INT = {1'b0, {(WIDTH - 1){1'b1}}}; // 011...1
    localparam MIN_INT = {1'b1, {(WIDTH - 1){1'b0}}}; // 100...0
    localparam POS_ONE = {{(WIDTH - 1){1'b0}}, 1'b1};   // 000...1
    localparam NEG_ONE = {WIDTH{1'b1}};               // 111...1

    wire sign_d, sign_m, sign_q, sign_r;

    // signs of values
    assign sign_d = dividend[WIDTH - 1];
    assign sign_m = divisor[WIDTH - 1];
    assign sign_q = sign_d ^ sign_m;
    assign sign_r = sign_d;

    wire [WIDTH - 1 : 0] abs_d, abs_m;
    wire [WIDTH - 1 : 0] abs_q, abs_r;

    // absolute values (2's complement if negative)
    assign abs_d = sign_d ? (~dividend + 1) : dividend;
    assign abs_m = sign_m ? (~divisor + 1) : divisor;

    // check overflow
    // if true, adapt dividend and divisor
    // so that quotient is MAX_INT and remainder is ZERO
    assign overflow = (dividend == MIN_INT) && (divisor == NEG_ONE);
    wire [WIDTH - 1 : 0] div_d = overflow ? MAX_INT : abs_d;
    wire [WIDTH - 1 : 0] div_m = overflow ? POS_ONE : abs_m;

    // unsigned divider
    divider_unsigned #(.WIDTH(WIDTH)) divide (
        .dividend(div_d),
        .divisor(div_m),
        .quotient(abs_q),
        .remainder(abs_r),
        .div_by_zero(div_by_zero)
    );

    // div_by_zero is handled in divider_unsigned
    // as ZERO for quotient and dividend for remainder
    // sign correction
    // as result of divider_unsigned is absolute values
    assign quotient = div_by_zero ? abs_q :
                    (sign_q ? (~abs_q + 1) : abs_q);

    assign remainder = div_by_zero ? abs_r :
                    (sign_r ? (~abs_r + 1) : abs_r);

endmodule
