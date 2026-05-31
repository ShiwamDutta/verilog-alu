`timescale 1ns/1ps

module multiplier_tb_16bit;
    localparam WIDTH = 16;

    reg  signed [WIDTH-1:0] a, b;
    wire signed [2*WIDTH-1:0] product;
    wire zero;

    multiplier #(WIDTH) uut(a, b, product, zero);

    initial begin
        $dumpfile("waves/multiplier_16bit.vcd");
        $dumpvars(0, uut);

        $monitor("%d * %d = %d", a, b, product);
        a =    512; b =    228;  #10;
        a =   -515; b =    346;  #10;  // one negative
        a =   -515; b =   -346;  #10;  // both negative
        a =    245; b =      0;  #10;  // zero
        a =  32767; b =  32767;  #10;  // MAX * MAX
        a =  32767; b = -32768;  #10;  // MAX * MIN
        a = -32768; b = -32768;  #10;  // MIN * MIN

        $finish;
    end

endmodule
