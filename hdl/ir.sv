//EE 310 Fundamentals of Computer Engineering
//Assignment: Lab 04
//Author: Daniel Copley
//Module Name: ir
//Module Function: Instruction Register
//**************************************************************************************

//Module Declaration
module ir(
    input logic clk,
    input logic rst,
    input logic iru_en,
    input logic irl_en,
    input logic [7:0]mdr,
    output logic [7:0]opcode,
    output logic [7:0]value

);

    // Instruction register upper and lower byte
    logic [7:0]iru;
    logic [7:0]irl;

    assign opcode = iru;
    assign value = irl;

    always_ff @(posedge clk, posedge rst) begin

        if (rst) begin
            
            iru <= 8'b0;
            irl <= 8'b0;

        end else if (iru_en != irl_en) begin

            if (iru_en) begin
                iru <= mdr;
            end else if (irl_en) begin
                irl <= mdr;
            end

        end

    end

endmodule
