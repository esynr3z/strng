//==============================================================================
//
// Self-timed ring (STR) implements an asynchronous handshake protocol 
// that assures an even distribution of events through the different stages. 
// The STR architecture implements a micropipeline (ripple FIFO) introduced by 
// Sutherland in “Micropipelines”.
//
//==============================================================================

module trng_str(
    rstn,
    sout
);


//------------------------------------------------------------------------------
// Parameters
//------------------------------------------------------------------------------
parameter LEN = 8;
parameter INIT = 8'b01010000;


//------------------------------------------------------------------------------
// Ports declaration
//------------------------------------------------------------------------------
input            rstn;  // Active low reset
output [LEN-1:0] sout;  // Stage value


//------------------------------------------------------------------------------
// Local signal declarations
//------------------------------------------------------------------------------
genvar i;
wire [LEN-1:0] f;
wire [LEN-1:0] r;
wire [LEN-1:0] c;


//------------------------------------------------------------------------------
//
// STR main logic
//
//------------------------------------------------------------------------------
generate
    for (i=0; i<LEN; i=i+1) 
    begin : stage_inst
        trng_cmuller
            cmuller 
            (
                .f  (f[i]),
                .r  (r[i]),
                .clr((~rstn) & (~INIT[i])),
                .set((~rstn) &  INIT[i]),
                .c  (c[i])
            );
    end
endgenerate

generate
    for (i=0; i<LEN; i=i+1) 
    begin : stage_connect
        if (i == 0)
        begin
            assign f[i] = c[LEN-1];
            assign r[i] = c[i+1];   
        end
        else if (i == (LEN-1))
        begin
            assign f[i] = c[i-1];
            assign r[i] = c[0];
        end
        else
        begin
            assign f[i] = c[i-1];
            assign r[i] = c[i+1];
        end      
    end
endgenerate


//------------------------------------------------------------------------------
// Outputs
//------------------------------------------------------------------------------
assign sout = c;


endmodule // trng_str
