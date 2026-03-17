`timescale 1ns/1ps

// 8-bit Booth multiplier
module multiplier_8bit (
    input [7:0] multiplier, multiplicand,
    output reg [15:0] product, 
    output reg zero
);

    integer i;
    reg last;

    always @(*) begin

        product = {8'b0, multiplier};
        last = 0;

        for (i=0; i<8; i=i+1) begin
            case ({product[0], last})
                2'b01: product[15:8] = product[15:8] + multiplicand;
                2'b10: product[15:8] = product[15:8] - multiplicand;
                default: ;
            endcase
            last = product[0];
            product = {product[15], product[15:1]}; // R-Shift
        end

        zero = ~|product;
    end

endmodule
