//==============================================================================
//
// True random number generator on self-timed rings (STR) defines
// 
//==============================================================================

// The number of stages that compose the STR. Each
// stage can be initialized either to 0 or 1.
`define STR_LEN     8

// A stage contains a token if its output
// Cn is not equal to the output Cn+1. Conversely, a stage
// contains a bubble if its output Cn is equal to the output
// Cn+1. For example, 01010000 - TTTTBBBB
`define  STR_INIT   8'b01010000