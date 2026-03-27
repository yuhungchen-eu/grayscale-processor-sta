module grayscale_pipelined (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        in_valid,
    input  logic [7:0]  r,
    input  logic [7:0]  g,
    input  logic [7:0]  b,
    output logic        out_valid,
    output logic [7:0]  gray
);

    // Stage 1 registers for multiplication results
    logic [15:0] r_mul_s1;
    logic [15:0] g_mul_s1;
    logic [15:0] b_mul_s1;
    logic        valid_s1;

    // Stage 2 combinational sum
    logic [15:0] sum_s2;

    assign sum_s2 = r_mul_s1 + g_mul_s1 + b_mul_s1;

    // Stage 1: register multiplications
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            r_mul_s1 <= 16'd0;
            g_mul_s1 <= 16'd0;
            b_mul_s1 <= 16'd0;
            valid_s1 <= 1'b0;
        end else begin
            valid_s1 <= in_valid;
            if (in_valid) begin
                r_mul_s1 <= r * 8'd77;
                g_mul_s1 <= g * 8'd150;
                b_mul_s1 <= b * 8'd29;
            end
        end
    end

    // Stage 2: register final grayscale output
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            gray      <= 8'd0;
            out_valid <= 1'b0;
        end else begin
            out_valid <= valid_s1;
            if (valid_s1)
                gray <= sum_s2[15:8];
        end
    end

endmodule