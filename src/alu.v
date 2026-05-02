`timescale 1ns/1ps

module alu #(
    parameter WIDTH = 8
) (
    input signed [WIDTH-1:0] a, b,
    input [3:0] op,
    output reg signed [2*WIDTH-1:0] result,
    output reg carry, overflow, zero, div_by_zero
);

    // results
    wire signed [WIDTH-1:0] add_sub_res;
    wire signed [2*WIDTH-1:0] mul_res;
    wire signed [WIDTH-1:0] div_quo, div_rem;
    reg signed [WIDTH-1:0] logic_res;

    // flag
    wire add_sub_carry, add_sub_overflow, add_sub_zero;
    wire mul_zero;
    wire div_overflow, div_by_zero_w;

    // function to extend results from modules by two times
    function [2*WIDTH-1:0] ext_val;
        input [WIDTH-1:0] val;
        begin
            ext_val = {{WIDTH{val[WIDTH-1]}}, val};
        end
    endfunction

    // arithmetic modules
    adder_sub #(WIDTH) add_sub_unit (
        .x(a),
        .y(b),
        .sub(op == 4'h1),
        .z(add_sub_res),
        .c(add_sub_carry),
        .v(add_sub_overflow),
        .zero(add_sub_zero)
    );

    multiplier #(WIDTH) mul_unit (
        .multiplier(a),
        .multiplicand(b),
        .product(mul_res),
        .zero(mul_zero)
    );

    divider #(WIDTH) div_unit (
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
        result = {WIDTH{1'b0}};
        carry = 0;
        overflow = 0;
        zero = 0;
        div_by_zero = 0;

        case(op)
            4'h0, 4'h1: begin             // a + b, a - b
                result = ext_val(add_sub_res);
                carry = add_sub_carry;
                overflow = add_sub_overflow;
                zero = add_sub_zero;
            end

            4'h2: begin                   // a * b
                result = mul_res;
                zero = mul_zero;
            end

            4'h3: begin                   // a / b
                result = ext_val(div_quo);
                div_by_zero = div_by_zero_w;
                overflow = div_overflow;
                zero = ~|div_quo;
            end

            4'h4: begin                   // a and b
                logic_res = a & b;
                result = ext_val(logic_res);
                zero = ~|logic_res;
            end

            4'h5: begin                   // a or b
                logic_res = a | b;
                result = ext_val(logic_res);
                zero = ~|logic_res;
            end

            4'h6: begin                   // a xor b
                logic_res = a ^ b;
                result = ext_val(logic_res);
                zero = ~|logic_res;
            end

            4'h7: begin                   // not a
                logic_res = ~a;
                result = ext_val(logic_res);
                zero = ~|logic_res;
            end

            4'hE: begin                   // pass a
                result = ext_val(a);
                zero = ~|a;
            end

            4'hF: begin                   // pass b
                result = ext_val(b);
                zero = ~|b;
            end

            default: ;
        endcase
    end

endmodule
