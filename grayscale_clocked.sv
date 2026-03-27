module grayscale_clocked (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        in_valid,
    input  logic [7:0]  r,
    input  logic [7:0]  g,
    input  logic [7:0]  b,
    output logic        out_valid,
    output logic [7:0]  gray
);

    logic [15:0] temp_sum;

    // Combinational grayscale math
    always_comb begin
        temp_sum = (r * 8'd77) + (g * 8'd150) + (b * 8'd29);
    end

    // Register output
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            gray      <= 8'd0;
            out_valid <= 1'b0;
        end else begin
            out_valid <= in_valid;
            if (in_valid)
                gray <= temp_sum[15:8];
        end
    end

endmodule