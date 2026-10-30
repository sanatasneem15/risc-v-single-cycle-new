
module if_stage (
    input  logic        clk,
    input  logic        reset,
    input  logic        stall,
    input  logic        and_out,
    input  logic [31:0] pc_signed_offset,

    output logic [31:0] address,
    output logic [31:0] pc_new
);

    // Program Counter register
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            address <= 32'h8000_0000;
        else if (!stall)
            address <= pc_new;
    end

    // Next PC calculation
    always_comb begin
        pc_new = address + 32'd4;

        if (and_out)
            pc_new = pc_signed_offset;
    end

endmodule
