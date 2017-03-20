//==============================================================================
//
// FPGA global clock buffer with clock enable
//             
//==============================================================================

module clk_buf(
    in,
    out,
    ce
);

input   in;     // clock input
input   ce;     // clock enable
output  out;    // clock output


//TODO: If several families/vendors will be used - wrap this and simmilar code to prepocessor defines
BUFGCE //BUFGCE from Xilinx Spartan6 family
    BUFGCE_u (
        .O  (out),
        .I  (in),
        .CE (ce) 
    );

endmodule // clk_buf
