module SEG_static(
		data,
		SEG
	);
  
	input [3:0] data;
	output [6:0] SEG;
	
	reg [6:0] SEG_buf;
	always @ (data)
	begin
		case(data)
			4'h0: SEG_buf <= 7'b0111111;
			4'h1: SEG_buf <= 7'b0000110;
			4'h2: SEG_buf <= 7'b1011011;
			4'h3: SEG_buf <= 7'b1001111;
			4'h4: SEG_buf <= 7'b1100110;
			4'h5: SEG_buf <= 7'b1101101;
			4'h6: SEG_buf <= 7'b1111101;
			4'h7: SEG_buf <= 7'b0000111;
			4'h8: SEG_buf <= 7'b1111111;
			4'h9: SEG_buf <= 7'b1101111;
			4'hA: SEG_buf <= 7'b1110111;
			4'hB: SEG_buf <= 7'b1111100;
			4'hC: SEG_buf <= 7'b0111001;
			4'hD: SEG_buf <= 7'b1011110;
			4'hE: SEG_buf <= 7'b1111001;
			4'hF: SEG_buf <= 7'b1110001;
			default: SEG_buf <= 7'b0111111;
		endcase
	end 
  
  assign SEG = SEG_buf;

endmodule 