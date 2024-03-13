`timescale 1ns / 1ns
`include "ps2.v"

module ps2_tb;
    reg clk_i, rst_i, ps2_clk_i, ps2_data_i;
    wire [3:0] digit_o;

    wire new_data_o;

    ps2 uut(clk_i, rst_i, ps2_clk_i, ps2_data_i, digit_o, new_data_o);

    initial begin
        $dumpfile("ps2_tb.vcd");
        $dumpvars(0, clk_i, rst_i, ps2_clk_i, ps2_data_i, digit_o, new_data_o);

        clk_i = 0;
        rst_i = 0;
        ps2_clk_i = 1;
        ps2_data_i = 0;

        #1  rst_i = 1;
        #1  rst_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 0;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 0;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 0;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 1;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 1;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 0;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 1;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 1;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 0;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 0;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 1;
        #5  ps2_clk_i = 0;

        #500

        #5  ps2_clk_i = 1;
            ps2_data_i = 0;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 0;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 1;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 0;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 1;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 0;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 1;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 0;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 1;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 0;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;
            ps2_data_i = 1;
        #5  ps2_clk_i = 0;

        #5  ps2_clk_i = 1;

        #200 $finish;
    end

    always #1 clk_i = ~clk_i;
endmodule