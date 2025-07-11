module freq_divider (
  input  clk,
  input  rst_n,
  output clk_1hz,
  output clk_5hz
  );
  
  localparam DIV_1HZ = 50_000_000;
  localparam DIV_5HZ = 10_000_000;
  
  reg        clk_1hz_reg;
  reg        clk_5hz_reg;
  reg [0:25] counter_1hz = 26'd0;
  reg [0:23] counter_5hz = 24'd0;
  
  // Frequency division from 50 MHz down to 1 Hz
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
	  counter_1hz <= 26'd0;
	  clk_1hz_reg <= 1'b0;
	end else if (counter_1hz == DIV_1HZ - 1) begin
	  counter_1hz <= 26'd0;
	  clk_1hz_reg <= 1'b1;
	end else begin
	  counter_1hz <= counter_1hz + 1;
	  clk_1hz_reg <= 1'b0;
	end 
  end
  
  // Frequency division from 50 MHz down to 5 MHz
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
	  counter_5hz <= 24'd0;
	  clk_5hz_reg <= 1'b0;
	end else if (counter_5hz == DIV_5HZ -1) begin
	  counter_5hz <= 24'd0;
	  clk_5hz_reg <= 1'b1;
	end else begin
	  counter_5hz <= counter_5hz + 1;
	  clk_5hz_reg <= 1'b0;
	end 
  end 
  
  assign clk_1hz = clk_1hz_reg;
  assign clk_5hz = clk_5hz_reg;
  
endmodule