/*
* Arithmetic Logic Unit
*/

module alu(
    input logic [7:0] opcode, value, mdr, ac,
    output logic [7:0] z,
    output logic zflag, nflag
);

assign zflag = ac == 0;
assign nflag = ac[7] == 0;

// Always latch might be 
always_latch begin
    case (opcode)
        // 'h00 - NOP (caught in default)
        'h01 : z = mdr;
        'h02 : z = value;
        // 'h03 - STORE
        'h04 : z = 0;
        'h05 : z = ac + mdr;
        'h06 : z = ac + value;
        'h07 : z = ac - mdr;
        'h08 : z = ac - value;
        'h09 : z = 0 - mdr;
        'h0A : z = ~mdr;
        'h0B : z = ac & mdr;
        'h0C : z = ac | mdr;
        'h0D : z = ac ^ mdr;
        'h0E : z = ac << value;
        'h0F : z = ac >> value;
        // 'h10-'h14 are jump commands controlled by control unit
    endcase
end

endmodule
