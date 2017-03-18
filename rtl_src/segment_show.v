module segment_show(
		clk,
		rst_n,
		SEG
	);
  
	input clk;
	input rst_n;
	output [7:0] SEG;
	
	reg [24:0] cnt;
	always @ (negedge rst_n or posedge clk)
	begin
		if(!rst_n)
			cnt <= 25'd0;
		else if(cnt != 25'd2499999)
			cnt <= cnt + 1'b1;
		else
			cnt <= 25'd0;
	end
	
	reg add_en;
	always @ (negedge rst_n or posedge clk)
	begin
		if(!rst_n)
			add_en <= 1'b0;
		else if(cnt == 25'd2499999)
			add_en <= 1'b1;
		else
			add_en <= 1'b0;
	end
	
	reg [4:0] data;
	always @ (negedge rst_n or posedge clk)
	begin
		if(!rst_n)
			data <= 5'b0;
		else if(add_en)
			data <= data + 1'b1;
	end
	
	SEG_static u_SEG_static(
		.data(data[3:0]),
		.SEG(SEG[6:0])
	);
	
	assign SEG[7] = data[4];
	
endmodule 