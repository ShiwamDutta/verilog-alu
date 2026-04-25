`timescale 1ns/1ps

module divider_unsigned_8bit_tb;

    reg  [7:0] d, m;
    wire [7:0] q, r;
    wire div_by_zero;

    divider_unsigned #(8) uut (d, m, q, r, div_by_zero);

    initial begin
        $dumpfile("waves/divider.vcd");
        $dumpvars(0, uut);

        $monitor("%d = %d * %d + %d", d, m, q, r);
        d =  25; m =  5; #10;
        d =  99; m =  7; #10;
        d = 120; m =  8; #10;
        d = 255; m = 15; #10;
        d = 110; m = 13; #10;
        d =  17; m =  4; #10;
        d =  64; m =  3; #10;
        d = 100; m =  0; #10;

        $finish;

    end

endmodule
