`timescale 1ns/1ps

module alu_8bit (
    input signed [7:0] a, b,
    input [3:0] op,
    output reg signed [15:0] result,
    output reg carry, overflow, zero, div_by_zero
);

    // results
    wire signed [7:0] add_sub_res;
    wire signed [15:0] mul_res;
    wire signed [7:0] div_quo, div_rem;
    reg signed [7:0] logic_res;

    // flag
    wire add_sub_carry, add_sub_overflow, add_sub_zero;
    wire mul_zero;
    wire div_overflow, div_by_zero_w;

    // arithmetic modules
    adder_sub_8bit add_sub_unit (
        .x(a),
        .y(b),
        .sub(op == 4'h1),
        .z(add_sub_res),
        .c(add_sub_carry),
        .v(add_sub_overflow),
        .zero(add_sub_zero)
    );

    multiplier_8bit mul_unit (
        .multiplier(a),
        .multiplicand(b),
        .product(mul_res),
        .zero(mul_zero)
    );

    divider_8bit div_unit (
        .dividend(a),
        .divisor(b),
        .quotient(div_quo),
        .remainder(div_rem),
        .div_by_zero(div_by_zero_w),
        .overflow(div_overflow)
    );

    // operation result
    always @(*) begin
        // default values
        result = 16'b0;
        carry = 0;
        overflow = 0;
        zero = 0;
        div_by_zero = 0;

        case(op)
            4'h0, 4'h1: begin             // a + b, a - b
                result = {{8{add_sub_res[7]}}, add_sub_res};
                carry = add_sub_carry;
                overflow = add_sub_overflow;
                zero = add_sub_zero;
            end

            4'h2: begin                   // a * b
                result = mul_res;
                zero = mul_zero;
            end

            4'h3: begin                   // a / b
                result = {{8{div_quo[7]}}, div_quo};
                div_by_zero = div_by_zero_w;
                overflow = div_overflow;
                zero = ~|div_quo;
            end

            4'h4: begin                   // a and b
                logic_res = a & b;
                result = {{8{logic_res[7]}}, logic_res};
                zero = ~|logic_res;
            end

            4'h5: begin                   // a or b
                logic_res = a | b;
                result = {{8{logic_res[7]}}, logic_res};
                zero = ~|logic_res;
            end

            4'h6: begin                   // a xor b
                logic_res = a ^ b;
                result = {{8{logic_res[7]}}, logic_res};
                zero = ~|logic_res;
            end

            4'h7: begin                   // not a
                logic_res = ~a;
                result = {{8{logic_res[7]}}, logic_res};
                zero = ~|logic_res;
            end

            4'hE: begin                   // pass a
                result = {{8{a[7]}}, a};
                zero = ~|a;
            end

            4'hF: begin                   // pass b
                result = {{8{b[7]}}, b};
                zero = ~|b;
            end

            default: ;
        endcase
    end

endmodule
