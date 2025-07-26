module controller(
    input [2:0] eqz,
    input clk, signal,
    input rst, // added reset input
    output reg c1, c2, ld1, ld2, ld4, ld5, ld6, ld7,
    output done
);

parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;

reg [2:0] state, n_state;

always @ (posedge clk or posedge rst) begin // added posedge rst
    if (rst) begin
        state <= S0; // reset to S0 when rst is high
    end else begin
        state <= n_state;
    end
end

always @ (*) begin
    case(state)
        S0: n_state = S1;
        S1: n_state = S2;
        S2: n_state = S3;
        S3: begin
                if(signal)
                    n_state = S4;
                else
                case (eqz)
                    3'b001: n_state = S1; // R5 > N
                    3'b100: n_state = S1; // R5 < N
                    3'b010: n_state = S4; // R5 == N
                    default: n_state = S1; // Catch-all for any other case
                endcase
        end
        default: n_state = S0;
    endcase
end

always @ (*) begin
    case(state)
        S0: {ld1, ld2, ld4, ld5, ld6, ld7, c1, c2} = 8'b11000000;
        S1: {ld1, ld2, ld4, ld5, ld6, ld7, c1, c2} = 8'b00101100;
        S2: {ld1, ld2, ld4, ld5, ld6, ld7, c1, c2} = 8'b00010000;
        S3: {ld1, ld2, ld4, ld5, ld6, ld7, c1, c2} = ((eqz == 3'b010))? 8'b00000000 : (eqz == 3'b100)? 8'b10000010 : 8'b01000001;
        S4: {ld1, ld2, ld4, ld5, ld6, ld7, c1, c2} = 8'b00000000;
        default: {ld1, ld2, ld4, ld5, ld6, ld7, c1, c2} = 8'b00000000;
    endcase
end

assign done = (state == S4);
endmodule
