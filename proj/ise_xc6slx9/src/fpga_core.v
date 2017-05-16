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
    io_a11,
    io_a12,
    io_a13,
    io_a14,
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
//    io_b12
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
// Defines
//------------------------------------------------------------------------------
// Divider compare values for several clocks
`define SAMPLE_CLK_50MHZ_DIV_VAL 0
`define SAMPLE_CLK_25MHZ_DIV_VAL 1
`define SAMPLE_CLK_10MHZ_DIV_VAL 4
`define SAMPLE_CLK_5MHZ_DIV_VAL  9
`define SAMPLE_CLK_2MHZ_DIV_VAL  24
`define SAMPLE_CLK_1MHZ_DIV_VAL  49
`define SAMPLE_CLK_05MHZ_DIV_VAL 99
// Choosen clock
`define SAMPLE_CLK_DIV_VAL  `SAMPLE_CLK_05MHZ_DIV_VAL

//------------------------------------------------------------------------------
// Parameters
//------------------------------------------------------------------------------
//parameter        SDRAM_COL_WIDTH  = 9;          //2^9 = 512 addresses in each colum
//parameter        SDRAM_ROW_WIDTH  = 13;         //2^13 = 8192 addresses in each bank
//parameter        SDRAM_BANK_WIDTH = 2;          //2^2 = 4 banks in a single chip
//parameter        SDRAM_DQ_WIDTH   = 16;         //16 bit Data Bus for one chip
//parameter [12:0] SDRAM_SDRAM_MR   = 13'h0037;   //Full Page Burst,Latency=3,Burst Read and Burst Write,Standard mode


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
output  io_a11;      // IO port A pin (board: A11)
output  io_a12;      // IO port A pin (board: A12)
output  io_a13;      // IO port A pin (board: A13)
output  io_a14;      // IO port A pin (board: A14)
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
//output io_b12;      // IO port B pin (board: B12, LCD_D7, SEG7)

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
reg [8:0] rst_clkdiv_counter;
wire      rst_clkdiv_en;
reg [7:0] rst_n_r;
reg       rst_n_buf;
wire      sysrstn;
// Clock
reg [7:0] sample_clk_div_counter;
wire      sample_clk_en;
wire      sample_clk;
wire      sysclk;

// TRNG
wire [7:0] rnd_data;


//------------------------------------------------------------------------------
//
// Clocks and reset
//
//------------------------------------------------------------------------------
assign sysclk = clk50m;

// 100kHz pulse generator
always @ (posedge sysclk)
begin
    if (rst_clkdiv_counter == 499)
        rst_clkdiv_counter <= 0;
    else
        rst_clkdiv_counter <= rst_clkdiv_counter+1;
end  

assign rst_clkdiv_en = (rst_clkdiv_counter == 499) ? 1'b1 : 1'b0;

// Reset registering stage
always @ (posedge sysclk)
begin
    if (rst_clkdiv_en)
        rst_n_r <= {rst_n_r[6:0],rst_n};
end   

// Reset pulse generator 
// Minimal reset active pulse lengh = 8*T_clkdiv
always @ (posedge sysclk)
begin
    if(rst_n_r==8'hFF)
        rst_n_buf <= 1'b1;
    else
        rst_n_buf <= 1'b0;
end
assign sysrstn = rst_n_buf; 

// System clock divider
always @ (posedge sysclk)
begin
    if (sample_clk_div_counter == `SAMPLE_CLK_DIV_VAL)
        sample_clk_div_counter <= 0;
    else
        sample_clk_div_counter <= sample_clk_div_counter+1;
end  

assign sample_clk = (sample_clk_div_counter == `SAMPLE_CLK_DIV_VAL) ? clk50m : 1'b0;
assign clkout     = (sample_clk_div_counter == ((`SAMPLE_CLK_DIV_VAL+1)/2 - 1)) ? clk50m : 1'b0;

assign io_a10 = clkout;
assign io_a9 = sysrstn;

//------------------------------------------------------------------------------
//
// STR true random number generator
//
//------------------------------------------------------------------------------
strng_core 
    strng
    (
        .clk        (sample_clk),
        .rstn       (sysrstn),
        .rnd_data   (rnd_data)
    );

assign io_a8 = rnd_data[7];
assign io_a7 = rnd_data[6];
assign io_a6 = rnd_data[5];
assign io_a5 = rnd_data[4];
assign io_a4 = rnd_data[3];
assign io_a3 = rnd_data[2];
assign io_a2 = rnd_data[1];
assign io_a1 = rnd_data[0];


assign io_a14 = rnd_data[5] ^ rnd_data[7];
assign io_a13 = rnd_data[4] ^ rnd_data[6];
assign io_a12 = rnd_data[1] ^ rnd_data[3];
assign io_a11 = rnd_data[0] ^ rnd_data[2];


endmodule // fpga_core
