//==============================================================================
//
// Self-timed rings (STR) based true random number generator core
// 
//==============================================================================

module strng_core (
    clk,
    rstn,
    rnd_data
);


//------------------------------------------------------------------------------
// Parameters
//------------------------------------------------------------------------------
// The number of stages that compose the STR. Each
// stage can be initialized either to 0 or 1.
parameter STR_LEN = 8;

// A stage contains a token if its output
// Cn is not equal to the output Cn+1. Conversely, a stage
// contains a bubble if its output Cn is equal to the output
// Cn+1. For example, 01010000 - TTTTBBBB
parameter STR_INIT = 8'b01010000;


//------------------------------------------------------------------------------
// Ports declaration
//------------------------------------------------------------------------------
// Clock and reset
input  clk;      // Sample clock
input  rstn;     // Active low reset
// Functional
output [STR_LEN-1:0] rnd_data; // Random data bus


//------------------------------------------------------------------------------
// Local signal declarations
//------------------------------------------------------------------------------
//STR outputs
wire [STR_LEN-1:0] stra_sout;
wire [STR_LEN-1:0] strb_sout;
//Sample submodule
reg  [STR_LEN-1:0] sout_sample0;
reg  [STR_LEN-1:0] sout_sample1;
reg  [STR_LEN-1:0] sout_sample2;
reg  [STR_LEN-1:0] sout_sample3;
wire [STR_LEN-1:0] sout_sample_xor;


//------------------------------------------------------------------------------
//
// STR
//
//------------------------------------------------------------------------------
strng_str
    #(
        .LEN    (STR_LEN),
        .INIT   (STR_INIT)
    )
    stra
    (
        .rstn   (rstn),
        .sout   (stra_sout)
    );

strng_str
    #(
        .LEN    (STR_LEN),
        .INIT   (STR_INIT)
    )
    strb
    (
        .rstn   (rstn),
        .sout   (strb_sout)
    );


//------------------------------------------------------------------------------
//
// Sample submodule
//
//------------------------------------------------------------------------------
generate
genvar i;
    for (i=0; i<STR_LEN; i=i+1) 
    begin : sout_sample
        // Sample stage 0
        always @(posedge strb_sout[i] or negedge rstn)
        begin
            if (~rstn)
                sout_sample0[i] <= 0;
            else
                sout_sample0[i] <= stra_sout[i];
        end

        // Sample stage 0 and 1 glue logic
        assign sout_sample_xor[i] = sout_sample0[i] ^ sout_sample1[i];

        // Sample 1 stage
        always @(posedge strb_sout[i] or negedge rstn)
        begin
            if (~rstn)
                sout_sample1[i] <= 0;
            else
                sout_sample1[i] <= sout_sample_xor[i];
        end

        // Sample 2 stage
        always @(posedge sout_sample0[i] or negedge rstn)
        begin
            if (~rstn)
                sout_sample2[i] <= 0;
            else
                sout_sample2[i] <= sout_sample1[i];
        end

        // Sample 3 stage
        always @(posedge clk or negedge rstn)
        begin
            if (~rstn)
                sout_sample3[i] <= 0;
            else
                sout_sample3[i] <= sout_sample2[i];
        end
    end
endgenerate


//------------------------------------------------------------------------------
// Outputs
//------------------------------------------------------------------------------
assign rnd_data = sout_sample3;


endmodule // strng_core
