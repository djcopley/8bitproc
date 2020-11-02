// Processor Micro-Architecture


module cpu(
    input logic clk, rst
);

// Internal logic signals
logic load_pc, incr_pc, load_ac, load_iru, load_irl, fetch, store_mem, zflag, nflag;
logic [3:0] state;
logic [7:0] mdr_bus, ac_bus, pc_bus, addr_bus, iru_bus, irl_bus, z_bus;

// Control unit
cu cu0(
    .clk(clk), .rst(rst), .zflag(zflag), .nflag(nflag), .opcode(iru_bus), .load_pc(load_pc), .incr_pc(incr_pc), 
    .load_ac(load_ac), .load_iru(load_iru), .load_irl(load_irl), .fetch(fetch), .store_mem(store_mem), .state(state)
);

// CPU Linking
ramlp ramlp0(.clock(clk), .wren(store_mem), .address(addr_bus), .data(ac_bus), .q(mdr_bus));
ir ir0(.clk(clk), .rst(rst), .iru_en(load_iru), .irl_en(load_irl), .mdr(mdr_bus), .opcode(iru_bus), .value(irl_bus));
ac ac0(.clk(clk), .en(load_ac), .d(z_bus), .q(ac_bus));
pc pc0(.clk(clk), .rst(rst), .ld(load_pc), .cnt(incr_pc), .addr(irl_bus), .pc(pc_bus));
alu alu0(.opcode(iru_bus), .value(irl_bus), .mdr(mdr_bus), .ac(ac_bus), .z(z_bus), .zflag(zflag), .nflag(nflag));

// Mux fetch select
assign addr_bus = fetch ? pc_bus : irl_bus;

endmodule
