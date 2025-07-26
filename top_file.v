`include "controller.v"
`include "datapath.v"

module top_file(
    input [7:0] N,
    input clk,
    input rst,
    output [3:0]op
);

wire ld1, ld2, ld4, ld5, ld6, ld7, c1, c2, done;
wire [2:0] eqz;
wire [3:0] int;
wire signal;

controller ctrl(
    .eqz(eqz),
    .clk(clk),
    .rst(rst),
    .c1(c1),
    .c2(c2),
    .ld1(ld1),
    .ld2(ld2),
    .ld4(ld4),
    .ld5(ld5),
    .ld6(ld6),
    .ld7(ld7),
    .done(done),
    .signal(signal)
);

datapath dp(
    .N(N),
    .ld1(ld1),
    .ld2(ld2),
    .ld4(ld4),
    .ld5(ld5),
    .ld6(ld6),
    .ld7(ld7),
    .c1(c1),
    .c2(c2),
    .clk(clk),
    .eqz(eqz),
    .value(int),
    .signal(signal)
);


assign op = (done)? int: 4'b0;

endmodule
