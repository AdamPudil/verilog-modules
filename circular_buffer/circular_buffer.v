module buffer #(
		parameter word_size = 32,
		parameter capacity = 64
		) (
		input clk, rst, wr, rd, fifo, 
		input [word_size -1 : 0] data_in,
		output reg full, empty,
		output reg [word_size -1 : 0] data_out,
		output reg [$clog2(capacity) - 1 : 0] fullnes
		);

		reg [$clog2(capacity) - 1 : 0] start_a, end_a; 
		
		reg [word_size - 1 : 0] memory [capacity - 1 : 0];

		always @(posedge clk) begin
			if(rst) begin 
				start_a = 0;
				end_a = -1;
			end

			if(wr && !fifo) begin
				end_a = end_a + 1;
				memory [end_a] = data_in; 
			end

			if(wr && fifo) begin
				start_a = start_a - 1;
				memory [start_a] = data_in; 
			end
			
			if(rd) begin
				data_out = memory [start_a];
				start_a = start_a + 1;
			end
			fullnes = end_a - start_a + 1;
			full = fullnes == 3;
			empty = fullnes == 0;
		end
endmodule
