`timescale 1ns / 1ns
`include "top.v"

module top_tb;
    reg clk_i, rst_i, ps2_clk_i, ps2_data_i;
    wire [7:0] led7_seg_o, led7_an_o;

    top uut(clk_i, rst_i, ps2_clk_i, ps2_data_i, led7_seg_o, led7_an_o);

    task tx;
        input [7:0] key;

        begin
            ps2_clk_i = 1;
            ps2_data_i = 0;

            #5  ps2_clk_i = 1;
                ps2_data_i = 0;
            #5  ps2_clk_i = 0;;

            for(integer i = 0; i < 8; i = i + 1) begin
                #5  ps2_clk_i = 1;
                    ps2_data_i = key[i];
                #5  ps2_clk_i = 0;
            end

            #5  ps2_clk_i = 1;
                ps2_data_i = ^key;
            #5  ps2_clk_i = 0;

            #5  ps2_clk_i = 1;
                ps2_data_i = 1;
            #5  ps2_clk_i = 0;

            #5  ps2_clk_i = 1;
        end
    endtask

    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, clk_i, rst_i, ps2_clk_i, ps2_data_i, led7_an_o, led7_seg_o, uut.dig1, uut.dig10, uut.dig100, uut.dig1000);

        clk_i = 0;
        rst_i = 0;
        ps2_clk_i = 1;
        ps2_data_i = 0;

        #1  rst_i = 1;
        #1  rst_i = 0;

        tx(8'h46);
        #100
        tx(8'h46);
        #100
        tx(8'h16);

        #100
        tx(8'h7B);

        #100
        tx(8'h16);
        #100
        tx(8'h1e);
        #100
        tx(8'h26);

        #100
        tx(8'h55);

        #100
        tx(8'h76);

        #200 $finish;
    end

    always #1 clk_i = ~clk_i;
endmodule