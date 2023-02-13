`include "circular_buffer.v"

module tb();
	reg clk, rst, wr, rd, fifo;
	reg [31 : 0] in;
	wire full, empty;
	wire [31 : 0] out;
	wire [1 : 0] cap;

	buffer #(32,4)circular_buffer (clk, rst, wr, rd, fifo, in, full, empty, out, cap);
	

	initial begin
		$dumpfile("test");
		$dumpvars;
	
			rst <= 1;
			clk <= 0;
			fifo <= 1;
			wr <= 0;
			rd <= 0;
		#2	rst <= 0;
		#2	in <= 'h69;
			wr <= 1;
		#2	in <= 'h420;
		#2	in <= 'h260;
		#2	in <= 'h124;
		#2	fifo <= 0;
			wr <= 0;
			rd <= 1;
		#2;
		#2;
		#2;
		#2;
			rst <= 1;
			clk <= 0;
			fifo <= 0;
			wr <= 0;
			rd <= 0;
		#2	rst <= 0;
		#2	in <= 'h69;
			wr <= 1;
		#2	in <= 'h420;
		#2	in <= 'h260;
		#2	in <= 'h124;
		#2	wr <= 0;
			rd <= 1;
		#2;
		#2;
		#2;
		#2;
			rst <= 1;
			clk <= 0;
			fifo <= 0;
			wr <= 0;
			rd <= 0;
		#2	rst <= 0;
		#2	in <= 'h69;
			wr <= 1;
		#2	in <= 'h420;
			fifo <= 1;
		#2	in <= 'h260;
		#2	in <= 'h124;
		#2	fifo <= 0;
			wr <= 0;
			rd <= 1;
		#2;
		#2;
		#2;
		#2	$finish;
	end

	always #1 clk = !clk;
	
	always @(negedge clk) begin
		if (wr == 1) $display("write-> data: %h, fifo: %b | empty: %h, full: %h, cap: %d", in, fifo, empty, full, cap);
	 	if (rd == 1) $display("read -> data: %h, empty: %h, full: %h, cap: %d", out, empty, full, cap);
	end
endmodule
