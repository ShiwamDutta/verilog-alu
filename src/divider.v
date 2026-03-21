`timescale 1ns/1ps

module divider_8bit (
    input  signed [7:0] dividend, divisor,
    output signed [7:0] quotient, remainder,
    output div_by_zero, overflow
);

    localparam MIN_INT = 8'h80;
    localparam NEG_ONE = 8'hFF;
    localparam MAX_INT = 8'h7F;

    wire sign_d, sign_m, sign_q, sign_r;

    assign sign_d = dividend[7];
    assign sign_m = divisor[7];
    assign sign_q = sign_d ^ sign_m;
    assign sign_r = sign_d;

    wire [7:0] abs_d, abs_m;
    wire [7:0] abs_q, abs_r;

    // absolute values
    assign abs_d = sign_d ? (~dividend + 1) : dividend;
    assign abs_m = sign_m ? (~divisor + 1) : divisor;

    assign overflow = (dividend == MIN_INT) && (divisor == NEG_ONE);
    wire [7:0] div_d = overflow ? MAX_INT : abs_d;
    wire [7:0] div_m = overflow ? 8'h01 : abs_m;

    // unsigned divider
    divider_unsigned_8bit divide (
        .dividend(div_d),
        .divisor(div_m),
        .quotient(abs_q),
        .remainder(abs_r),
        .div_by_zero(div_by_zero)
    );

    // sign correction
    assign quotient = div_by_zero ? abs_q :
                    (sign_q ? (~abs_q + 1) : abs_q);

    assign remainder = div_by_zero ? abs_r :
                    (sign_r ? (~abs_r + 1) : abs_r);

endmodule
