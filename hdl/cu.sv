// Control Unit


module cu(
    input logic clk, rst, zflag, nflag,
    input logic [7:0] opcode,
    output logic load_pc, incr_pc, load_ac, load_iru, load_irl, fetch, store_mem,
    output logic [3:0] state
);

typedef enum logic [3:0] {START, PREP_U, FETCH_U, PREP_L, FETCH_L, EXECUTE_1, EXECUTE_2, EXECUTE_3A, EXECUTE_3B, EXECUTE_4, EXECUTE_5} statetype;
statetype current_state, next_state;

assign state = current_state;


// Function returns the class of an opcode
function [7:0] opclass;
    input [7:0] _opcode;
begin
    case (_opcode)
        'h00, 'h04 : opclass = 1;
        'h02, 'h06, 'h08, 'h0E, 'h0F : opclass = 2;
        'h01, 'h05, 'h07, 'h09, 'h0A, 'h0B, 'h0C, 'h0D : opclass = 3;
        'h03 : opclass = 4;
        'h10, 'h11, 'h12, 'h13, 'h14 : opclass = 5;
        default : opclass = 0;
    endcase
end
endfunction


integer optest;
assign optest = opclass(opcode);


// Current state driver
always @(negedge clk, posedge rst) begin
    if (rst) begin
        current_state <= START;
    end else begin
        current_state <= next_state;
    end
end


// Next state driver
always_comb begin
    case (current_state)
        START : next_state = PREP_U;
        PREP_U : next_state = FETCH_U;
        FETCH_U : begin
            if (opclass(opcode) == 1) begin
                next_state = EXECUTE_1;
            end else begin
                next_state = PREP_L;
            end
        end
        PREP_L : next_state = FETCH_L;
        FETCH_L : begin
            case (opclass(opcode))
                2 : next_state = EXECUTE_2;
                3 : next_state = EXECUTE_3A;
                4 : next_state = EXECUTE_4;
                5 : next_state = EXECUTE_5;
                // Error! Should not happen.
                default : next_state = PREP_U;
            endcase
        end
        EXECUTE_1, EXECUTE_2, EXECUTE_3B, EXECUTE_4, EXECUTE_5 : next_state = PREP_U;
        EXECUTE_3A : next_state = EXECUTE_3B;
    endcase
end


// Output driver
always_comb begin
    // All outputs should be 0 by default
    load_pc = 0;
    incr_pc = 0;
    load_ac = 0;
    load_iru = 0;
    load_irl = 0;
    fetch = 1;
    store_mem = 0;

    case (state)
        PREP_U : begin
            // Wait for MDR to update
        end
        FETCH_U : begin
            incr_pc = 1;
            load_iru = 1;
        end
        PREP_L : begin
            // Wait for MDR to update
        end
        FETCH_L : begin
            incr_pc = 1;
            load_irl = 1;
        end
        EXECUTE_1 : begin
            load_ac = 1;
        end
        EXECUTE_2 : begin
            load_ac = 1;
            store_mem = 1;
        end
        EXECUTE_3A : begin
            fetch = 0;
        end
        EXECUTE_3B : begin
            fetch = 0;
            load_ac = 1;
            store_mem = 1;
        end
        EXECUTE_4 : begin
            fetch = 0;
            store_mem = 1;
        end
        EXECUTE_5 : begin
            case (opcode)
                'h10 : load_pc = 1;
                'h11 : load_pc = nflag;
                'h12 : load_pc = zflag & ~nflag;
                'h13 : load_pc = zflag;
                'h14 : load_pc = ~zflag;
            endcase
        end
    endcase
end

endmodule
