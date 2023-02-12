module buffer #(
		parameter word_size = 32,
		parameter capacity = 64
		) (
		input clk, rst, wr, rd, fifo, 
		input [word_size -1 : 0] data_in,
		output full, empty,
		output reg [word_size -1 : 0] data_out 
		);

		reg [$clog2(capacity) : 0] start_a, end_a; 
		
		reg [word_size - 1 : 0] memory [capacity - 1 : 0];

		assign full = (start_a - 1 == end_a);
		assign empty = (start_a == end_a);

		always @(clk) begin
			if(rst) begin 
				start_a = 0;
				end_a = 0;
			end

			if(wr && !fifo) begin
				memory [end_a] = data_in; 
				end_a = end_a + 1;
			end

			if(wr && fifo) begin
				memory [start_a] = data_in; 
				start_a = start_a - 1;
			end
			
			if(rd) begin
				data_out = memory [start_a];
				start_a = start_a + 1;
			end
		end

endmodule
