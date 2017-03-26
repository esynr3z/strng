//==============================================================================
//
// Muller C-gate (Muller gate, c-element)
// Original 2-inputs C-gate defined by equation:
// Qn = A*B + Qn-1*A + Qn-1*B (Qn is a new value, Qn-1 - previous).
// Logic table:
// | A | B | Qn   |
// | 0 | 0 | 0    |
// | 0 | 1 | Qn-1 |
// | 1 | 0 | Qn-1 |
// | 1 | 1 | 1    |
// 
// This implementation have a bit different naming, one of the inputs - inverted
// and have clear and set signals to setup output with defined value at start:
// Cn = ~CLR*(~R*F + F*Cn-1 + ~R*Cn-1) + SET
// Logic table (x - doesnt matter):
// | F | R |CLR|SET| Cn   |
// | 0 | 0 | 0 | 0 | Cn-1 |
// | 0 | 1 | 0 | 0 | 0    |
// | 1 | 0 | 0 | 0 | 1    |
// | 1 | 1 | 0 | 0 | Cn-1 |
// | x | x | 1 | 0 | 0    |
// | x | x | 0 | 1 | 1    |
// | x | x | 1 | 1 | 1    |
//             
//==============================================================================

module trng_cmuller(
    f,
    r,
    clr,
    set,
    c
);


//------------------------------------------------------------------------------
// Ports declaration
//------------------------------------------------------------------------------
input   f;      // forward input
input   r;      // reverse input
input   set;    // set input
input   clr;    // clear input
output  c;      // c-gate output


//------------------------------------------------------------------------------
//
// Muller C-gate main logic
//
//------------------------------------------------------------------------------
// This only used to in test purposes, i.e. generate LUT5 init value, 
// otherwise - LUT hard macro should be used.
/*
wire r_n = ~r;
wire clr_n = ~clr;
assign c = clr_n&(f&c | r_n&c | f&r_n)|set;
*/

//TODO: If several families will be used - wrap this and simmilar code to prepocessor defines
LUT5 //LUT5 from Xilinx Spartan6 family
    #(
        //O = ((!I0 * I2 * !I3) + (!I0 * I1 * I2) + I4 + (!I0 * I1 * !I3));
        .INIT(32'hFFFF4054)
    )
    LUT5_u (
        .O  (c),    // LUT general output
        .I0 (clr),  // LUT input 0
        .I1 (f),    // LUT input 1
        .I2 (c),    // LUT input 2
        .I3 (r),    // LUT input 3
        .I4 (set)   // LUT input 4
    );

endmodule // cmuller
