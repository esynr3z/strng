//==============================================================================
//
// Self-timed ring (STR) implements an asynchronous handshake protocol 
// that assures an even distribution of events through the different stages. 
// The STR architecture implements a micropipeline (ripple FIFO) introduced by 
// Sutherland in “Micropipelines”.
//
//==============================================================================

module str(
    rst_n,
    s
);

// The number of stages that compose the STR. Each
// stage can be initialized either to 0 or 1.
parameter LEN = 8;
// A stage contains a token if its output
// Cn is not equal to the output Cn+1. Conversely, a stage
// contains a bubble if its output Cn is equal to the output
// Cn+1. For example, 01010000 - TTTTBBBB
parameter INIT = 8'b01010000;

input            rst_n; // Active low reset
output [LEN-1:0] s;     // Stage value

genvar i;

wire [LEN-1:0] f;
wire [LEN-1:0] r;
wire [LEN-1:0] c;

assign s = c;

generate
    for (i=0; i<LEN; i=i+1) 
    begin : stage_inst
        cmuller 
            cmuller_u 
            (
                .f  (f[i]),
                .r  (r[i]),
                .clr((~rst_n) & (~INIT[i])),
                .set((~rst_n) &  INIT[i]),
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

endmodule // str
