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
                //.clr(rst_n | INIT[0]),
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
/*
cmuller 
    stage0 
    (
        .f  (f[0]),
        .r  (r[0]),
        .clr((~rst_n) & (~INIT[0])),
        //.clr(rst_n | INIT[0]),
        .set((~rst_n) &  INIT[0]),
        .c  (c[0])
    );
assign f[0] = c[7];
assign r[0] = c[1];

cmuller 
    stage1 
    (
        .f  (f[1]),
        .r  (r[1]),
        .clr((~rst_n) & (~INIT[1])),
        //.clr(rst_n | INIT[1]),
        .set((~rst_n) &  INIT[1]),
        .c  (c[1])
    );
assign f[1] = c[0];
assign r[1] = c[2];

cmuller 
    stage2 
    (
        .f  (f[2]),
        .r  (r[2]),
        .clr((~rst_n) & (~INIT[2])),
        //.clr(rst_n | INIT[2]),
        .set((~rst_n) &  INIT[2]),
        .c  (c[2])
    );
assign f[2] = c[1];
assign r[2] = c[3];

cmuller 
    stage3 
    (
        .f  (f[3]),
        .r  (r[3]),
        .clr((~rst_n) & (~INIT[3])),
        //.clr(rst_n | INIT[3]),
        .set((~rst_n) & INIT[3]),
        .c  (c[3])
    );
assign f[3] = c[2];
assign r[3] = c[4];

cmuller 
    stage4 
    (
        .f  (f[4]),
        .r  (r[4]),
        .clr((~rst_n) & (~INIT[4])),
        //.clr(rst_n | INIT[4]),
        .set((~rst_n) & INIT[4]),
        .c  (c[4])
    );
assign f[4] = c[3];
assign r[4] = c[5];

cmuller 
    stage5 
    (
        .f      (f[5]),
        .r    (r[5]),
        .clr  ((~rst_n) & (~INIT[5])),
        //.clr(rst_n | INIT[5]),
        .set    ((~rst_n) & INIT[5]),
        .c      (c[5])
    );
assign f[5] = c[4];
assign r[5] = c[6];

cmuller 
    stage6 
    (
        .f      (f[6]),
        .r    (r[6]),
        .clr  ((~rst_n) & (~INIT[6])),
        //.clr(rst_n | INIT[6]),
        .set    ((~rst_n) & INIT[6]),
        .c      (c[6])
    );
assign f[6] = c[5];
assign r[6] = c[7];

cmuller 
    stage7 
    (
        .f      (f[7]),
        .r    (r[7]),
        .clr  ((~rst_n) & (~INIT[7])),
        //.clr(rst_n | INIT[7]),
        .set    ((~rst_n) & INIT[7]),
        .c      (c[7])
    );
assign f[7] = c[6];
assign r[7] = c[0];
*/
endmodule // str