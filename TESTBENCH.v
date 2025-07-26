`include "top_file.v"
module testbench;

reg [7:0] N;
reg clk;
reg rst;
wire [3:0]op;

top_file dut(
    .N(N),
    .clk(clk),
    .rst(rst),
    .op(op)
);

initial begin

    clk = 0;
    rst = 1;
    N = 8'd101;
    #2 rst = 0;
end

always #10 clk = ~clk;

initial begin
    $dumpfile("testbench.vcd");
    $dumpvars(0, testbench);
    $monitor("Time: %t, output : %d \n", $time, op);

    #400; 
    $finish;
end

endmodule
