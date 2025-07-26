module datapath(
    input [7:0] N,
    input ld1, ld2, ld4, ld5, ld6, ld7, c1, c2,
    input clk,
    output reg [2:0] eqz,
    output [3:0]value,
    output reg signal
);

reg [3:0] R1, R2, R4, R6, R7, R1_next, R2_next, R4_next, R6_next, R7_next; // 4-bit registers
reg [7:0] R5, R5_next; // 8-bit register for R5

always @ (posedge clk) begin
    R1 <= R1_next;
    R2 <= R2_next;
    R4 <= R4_next;
    R5 <= R5_next;
    R6 <= R6_next;
    R7 <= R7_next;
end

always @ (*) begin
    R1_next = ld1 ? (c1 ? R6 : 4'd0) : R1;
    R2_next = ld2 ? (c2 ? R7 : 4'd15) : R2;
    R4_next = ld4 ? divider_out : R4;
    R5_next = ld5 ? mult_out : R5;
    R6_next = ld6 ? adder2_out: R6_next;
    R7_next = ld7 ? sub_out: R7_next;
end

wire [7:0] mult_out;
wire [3:0] divider_out, adder2_out, sub_out; // Changed to 4-bit wires
wire great, less, equal;
wire [4:0] adder1_out;


assign adder1_out = R1 + R2;
assign divider_out[3:0] = adder1_out[4:1];
assign adder2_out = R4 + 1;
assign sub_out = R4 - 1;
assign mult_out = R4 * R4; // Assuming R4 can be treated as 8-bit here for multiplication
assign great = R5 > N;
assign less = R5 < N;
assign equal = R5 == N;
always @ (*)
    eqz = {less, equal, great};

wire [3:0]interim;

assign interim = (R1 * R1 <= N)? R1 : R1 - 1;
assign value = signal? interim: R4;

always @ (posedge clk) signal = R1 == R2;



endmodule
