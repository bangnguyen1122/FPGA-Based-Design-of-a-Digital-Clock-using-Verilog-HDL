module debounce (
  input  clk,
  input  rst_n,
  input  btn,
  output db_tick
  );
  
  parameter CLOCK_FREQ      = 50_000_000;
  parameter STABLE_TIME_MS  = 10;
  localparam COUNTER_MAX    = (CLOCK_FREQ * STABLE_TIME_MS) / 1000;
  
  reg [1:0]  btn_sync;
  reg        db_state;
  reg [23:0] debounce_counter;
  wire       btn_changed;
  wire       counter_done; 
  
  // Metastability protection
  always @(posedge clk or negedge rst_n) begin 
    if (~rst_n) btn_sync <= 2'd0;
	else btn_sync[1:0] <= {btn_sync[0], btn};
  end 
  
  // Counter logic
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) debounce_counter <= 24'd0;
	else if (btn_changed || counter_done) debounce_counter <= 24'd0;
	else debounce_counter <= debounce_counter + 24'd1;
  end 

  // Output logic
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) db_state <= 1'd0;
	else if (counter_done) db_state <= btn_sync[1];
  end 
  
  assign btn_changed = ^btn_sync;
  assign counter_done = (debounce_counter == COUNTER_MAX);
  assign db_tick = db_state;
  
endmodule 


