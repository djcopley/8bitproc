//EE 310 Fundamentals of Computer Engineering
//Assignment: Lab 04
//Author: Daniel Copley
//Module Name: pc
//Module Function: Program Counter
//**************************************************************************************

//Module Declaration
module pc(
    input logic clk,
    input logic rst,
    input logic ld,
    input logic cnt,
    input logic [7:0]addr,
    output logic [7:0]pc
);

    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            pc <=  8'b0;
        end else begin
            if (cnt) begin
                pc <= pc + 1;
            end else if (ld) begin
                pc <= addr;
            end
        end
    end

endmodule
