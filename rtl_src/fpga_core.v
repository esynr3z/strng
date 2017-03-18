//==============================================================================
//
// Top level of XC6SLX9 FPGA on demoboard.  
// Contents only connections between internal peripheral 
// and external "on-board" peripheral and connectors.   
// 
//==============================================================================


module fpga_core (
//    clk24m,
    clk50m,
    rst_n,
    io_a1,
    io_a2,
    io_a3,
    io_a4,
    io_a5,
    io_a6,
    io_a7,
    io_a8,
    io_a9,
    io_a10,
//    io_a11,
//    io_a12,
//    io_a13,
//    io_a14,
//    io_a15,
//    io_a16,
//    io_a17,
//    io_a18,
//    io_a19,
//    io_a20,
//    io_a21,
//    io_a22,
//    io_a23,
//    io_a24,
//    io_a25,
//    io_a26,
//    io_a27,
//    io_a28,
//    io_a29,
//    io_a30,
//    io_a31,
//    io_a32,
//    io_a33,
//    io_a34,
//    io_a35,
//    io_a36,
//    io_a37,
//    io_a38,
//    io_b2,
//    io_b3,
//    io_b4,
//    io_b5,
//    io_b6,
//    io_b7,
//    io_b8,
//    io_b9,
//    io_b10,
//    io_b11,
    io_b12
//    sdram_clk,
//    sdram_cke,
//    sdram_cs_n,
//    sdram_ras_n,
//    sdram_cas_n,
//    sdram_we_n,
//    sdram_dqm,
//    sdram_ba,
//    sdram_addr,
//    sdram_dq
);


//------------------------------------------------------------------------------
// Parameters
//------------------------------------------------------------------------------
    parameter        SDRAM_COL_WIDTH  = 9;          //2^9 = 512 addresses in each colum
    parameter        SDRAM_ROW_WIDTH  = 13;         //2^13 = 8192 addresses in each bank
    parameter        SDRAM_BANK_WIDTH = 2;          //2^2 = 4 banks in a single chip
    parameter        SDRAM_DQ_WIDTH   = 16;         //16 bit Data Bus for one chip
    parameter [12:0] SDRAM_SDRAM_MR   = 13'h0037;   //Full Page Burst,Latency=3,Burst Read and Burst Write,Standard mode


//------------------------------------------------------------------------------
// Port declarations
//------------------------------------------------------------------------------
// Clock and resets
//input clk24m;       // Input clock 24MHz (board: not implemented)
input clk50m;       // Input clock 50MHz
input rst_n;        // Active low reset (board: KEY1, B1)

// IO port A
output  io_a1;       // IO port A pin (board: A1)
output  io_a2;       // IO port A pin (board: A2)
output  io_a3;       // IO port A pin (board: A3)
output  io_a4;       // IO port A pin (board: A4)
output  io_a5;       // IO port A pin (board: A5)
output  io_a6;       // IO port A pin (board: A6)
output  io_a7;       // IO port A pin (board: A7)
output  io_a8;       // IO port A pin (board: A8)
output  io_a9;       // IO port A pin (board: A9)
output  io_a10;      // IO port A pin (board: A10)
//input  io_a11;      // IO port A pin (board: A11)
//input  io_a12;      // IO port A pin (board: A12)
//input  io_a13;      // IO port A pin (board: A13)
//input  io_a14;      // IO port A pin (board: A14)
//input  io_a15;      // IO port A pin (board: A15)
//input  io_a16;      // IO port A pin (board: A16)
//input  io_a17;      // IO port A pin (board: A17)
//input  io_a18;      // IO port A pin (board: A18)
//input  io_a19;      // IO port A pin (board: A19)
//input  io_a20;      // IO port A pin (board: A20)
//input  io_a21;      // IO port A pin (board: A21)
//input  io_a22;      // IO port A pin (board: A22)
//input  io_a23;      // IO port A pin (board: A23)
//input  io_a24;      // IO port A pin (board: A24)
//input  io_a25;      // IO port A pin (board: A25)
//input  io_a26;      // IO port A pin (board: A26)
//input  io_a27;      // IO port A pin (board: A27)
//input  io_a28;      // IO port A pin (board: A28)
//input  io_a29;      // IO port A pin (board: A29)
//input  io_a30;      // IO port A pin (board: A30)
//input  io_a31;      // IO port A pin (board: A31)
//input  io_a32;      // IO port A pin (board: A32)
//input  io_a33;      // IO port A pin (board: A33)
//input  io_a34;      // IO port A pin (board: A34)
//input  io_a35;      // IO port A pin (board: A35)
//input  io_a36;      // IO port A pin (board: A36)
//input  io_a37;      // IO port A pin (board: A37)
//input  io_a38;      // IO port A pin (board: A38)

// IO port B
//input  io_b2;       // IO port B pin (board: B2,  LCD_RS, KEY0)
//input  io_b3;       // IO port B pin (board: B3,  LCD_RW, LED0)
//input  io_b4;       // IO port B pin (board: B4,  LCD_E,  LED1)
//output io_b5;       // IO port B pin (board: B5,  LCD_D0, SEG0)
//output io_b6;       // IO port B pin (board: B6,  LCD_D1, SEG1)
//output io_b7;       // IO port B pin (board: B7,  LCD_D2, SEG2)
//output io_b8;       // IO port B pin (board: B8,  LCD_D3, SEG3)
//output io_b9;       // IO port B pin (board: B9,  LCD_D4, SEG4)
//output io_b10;      // IO port B pin (board: B10, LCD_D5, SEG5)
//output io_b11;      // IO port B pin (board: B11, LCD_D6, SEG6)
output io_b12;      // IO port B pin (board: B12, LCD_D7, SEG7)

// SDRAM
//output                        sdram_clk;    // SDRAM clock (board: CLK port of SDRAM)
//output                        sdram_cke;    // SDRAM clock enable (board: CKE port of SDRAM)
//output                        sdram_cs_n;   // SDRAM chip select (board: CS_n port of SDRAM)
//output                        sdram_ras_n;  // SDRAM row active select (board: RAS_n port of SDRAM)
//output                        sdram_cas_n;  // SDRAM column active select (board: CAS_n port of SDRAM)
//output                        sdram_we_n;   // SDRAM write enable (board: WE_n port of SDRAM)
//output [SDRAM_DQ_WIDTH/8-1:0] sdram_dqm;    // SDRAM data mask (board: DQM port of SDRAM)
//output [SDRAM_BANK_WIDTH-1:0] sdram_ba;     // SDRAM bank active select (board: BA port of SDRAM)
//output [SDRAM_ROW_WIDTH-1:0]  sdram_addr;   // SDRAM address(board: ADDR port of SDRAM)
//inout  [SDRAM_DQ_WIDTH-1:0]   sdram_dq;     // SDRAM data (board: DQ port of SDRAM)


//------------------------------------------------------------------------------
// Local signal declarations
//------------------------------------------------------------------------------
// Reset generator
reg [7:0] rst_n_r;
reg       rst_n_buf;

// Clock
wire clk;
reg [8:0] clk_counter;
wire clk100k;

// LED 7-segment tester    
wire [7:0] seg_data;

genvar i;


//------------------------------------------------------------------------------
//
// Clocks
//
//------------------------------------------------------------------------------
assign clk = clk50m;

always @ (posedge clk)
begin
    if (clk_counter == 499)
        clk_counter <= 0;
    else
        clk_counter <= clk_counter+1;
end  

assign clk100k = (clk_counter == 499) ? 1'b1 : 1'b0;

assign io_a10 = clk;

//------------------------------------------------------------------------------
//
// Reset generator
//
//------------------------------------------------------------------------------
// Reset registering stage
always @ (posedge clk100k)
begin
    rst_n_r <= {rst_n_r[6:0],rst_n};
end   

// Reset pulse generator 
// Minimal reset active pulse lengh = 8*T_clk
always @ (posedge clk100k)
begin
    if(rst_n_r==8'hFF)
        rst_n_buf <= 1'b1;
    else
        rst_n_buf <= 1'b0;
end

assign io_a9 = rst_n_buf;

//------------------------------------------------------------------------------
//
// STR
//
//------------------------------------------------------------------------------
// The number of stages that compose the STR. Each
// stage can be initialized either to 0 or 1.
parameter LEN = 8;
// A stage contains a token if its output
// Cn is not equal to the output Cn+1. Conversely, a stage
// contains a bubble if its output Cn is equal to the output
// Cn+1. For example, 01010000 - TTTTBBBB
parameter INIT = 8'b01010000;

wire [7:0] s_a;
wire [7:0] s_b;

str
    #(
        .LEN(LEN),
        .INIT(INIT)
    )
    str_a
    (
        .rst_n (rst_n_buf),
        .s (s_a)
    );

str
    #(
        .LEN(LEN),
        .INIT(INIT)
    )
    str_b
    (
        .rst_n (rst_n_buf),
        .s (s_b)
    );

reg  [LEN-1:0] s_sample0;
reg  [LEN-1:0] s_sample1;
reg  [LEN-1:0] s_sample2;
reg  [LEN-1:0] s_sample3;
wire [LEN-1:0] s_sample_xor;
wire [LEN-1:0] trnd_byte;

generate
    for (i=0; i<LEN; i=i+1) 
    begin : s_sample_gen
        // Sample 0 stage
        always @ (posedge s_b[i] or negedge rst_n_buf)
        begin
            if (~rst_n_buf)
                s_sample0[i] <= 0;
            else
                s_sample0[i] <= s_a[i];
        end

        assign s_sample_xor[i] = s_sample0[i] ^ s_sample1[i];

        // Sample 1 stage
        always @ (posedge s_b[i] or negedge rst_n_buf)
        begin
            if (~rst_n_buf)
                s_sample1[i] <= 0;
            else
                s_sample1[i] <= s_sample_xor[i];
        end

        // Sample 2 stage
        always @ (posedge s_sample0[i] or negedge rst_n_buf)
        begin
            if (~rst_n_buf)
                s_sample2[i] <= 0;
            else
                s_sample2[i] <= s_sample1[i];
        end

        // Sample 3 stage
        always @ (posedge clk or negedge rst_n_buf)
        begin
            if (~rst_n_buf)
                s_sample3[i] <= 0;
            else
                s_sample3[i] <= s_sample2[i];
        end
    end
endgenerate

assign trnd_byte = s_sample3;

assign io_a8 = trnd_byte[7];
assign io_a7 = trnd_byte[6];
assign io_a6 = trnd_byte[5];
assign io_a5 = trnd_byte[4];
assign io_a4 = trnd_byte[3];
assign io_a3 = trnd_byte[2];
assign io_a2 = trnd_byte[1];
assign io_a1 = trnd_byte[0];

//------------------------------------------------------------------------------
//
// Led
//
//------------------------------------------------------------------------------
// LED 7-segment tester
segment_show
    segment_show_u
    (
        .clk    (clk),          // i: Clock
        .rst_n  (rst_n_buf),    // i: Active low reset
        .SEG    (seg_data)      // o: Segment data 8-width bus
    );
assign io_b12 = seg_data[7];

endmodule //fpga_core