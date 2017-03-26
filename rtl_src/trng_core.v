//==============================================================================
//
// True random number generator on self-timed rings (STR) core
// 
//==============================================================================
`include "trng_defs.vh"

module trng_core (
    clk,
    rstn,
    rnddata
);


//------------------------------------------------------------------------------
// Ports declaration
//------------------------------------------------------------------------------
input   clk;                    // Sample clock
input   rstn;                   // Active low reset
output  [`STR_LEN-1:0] rnddata; // Random data bus


//------------------------------------------------------------------------------
// Local signal declarations
//------------------------------------------------------------------------------
//STR outputs
wire [`STR_LEN-1:0] stra_sout;
wire [`STR_LEN-1:0] strb_sout;
//Sample submodule
reg  [`STR_LEN-1:0] sout_sample0;
reg  [`STR_LEN-1:0] sout_sample1;
reg  [`STR_LEN-1:0] sout_sample2;
reg  [`STR_LEN-1:0] sout_sample3;
wire [`STR_LEN-1:0] sout_sample_xor;


//------------------------------------------------------------------------------
// STR
//------------------------------------------------------------------------------
trng_str
    #(
        .LEN    (`STR_LEN),
        .INIT   (`STR_INIT)
    )
    stra
    (
        .rstn   (rstn),
        .sout   (stra_sout)
    );

trng_str
    #(
        .LEN    (`STR_LEN),
        .INIT   (`STR_INIT)
    )
    strb
    (
        .rstn   (rstn),
        .sout   (strb_sout)
    );

//------------------------------------------------------------------------------
// Sample submodule
//------------------------------------------------------------------------------
generate
genvar i;
    for (i=0; i<`STR_LEN; i=i+1) 
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
assign rnddata = sout_sample3;


endmodule // trng_core
