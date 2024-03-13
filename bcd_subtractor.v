`timescale 1ns / 1ns

module bcd_subtractor(input [3:0] a_i, input [3:0] b_i, output reg [3:0] diff_o, input borrow_i, output reg borrow_o);
    always @* begin
        if(a_i >= b_i + borrow_i) begin
            diff_o <= a_i - b_i - borrow_i;
            borrow_o <= 0;
        end
        else begin
            diff_o <= a_i - b_i - borrow_i + 5'd10;
            borrow_o <= 1;
        end      
    end
endmodule