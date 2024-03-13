`timescale 1ns / 1ns
`include "bcd_subtractor.v"

module adder_tb;
    wire [3:0] sum_o;
    reg [3:0] a_i, b_i;

    wire borrow_o;
    reg borrow_i;

    bcd_subtractor subtractor(a_i, b_i, sum_o, borrow_i, borrow_o);

    initial begin
        $dumpfile("subtractor_tb.vcd");
        $dumpvars(0, a_i, b_i, borrow_i, sum_o, borrow_o);

        a_i = 0;
        b_i = 0;
        borrow_i = 0;

        for(integer i = 0; i < 200; i = i + 1) begin
            #1
            if(i < 100) begin
                a_i = i / 10;
                b_i = i % 10;
                borrow_i = 0;
            end
            else begin
                a_i = (i - 100) / 10;
                b_i = (i - 100) % 10;
                borrow_i = 1;
            end
        end

        $finish;
    end
endmodule