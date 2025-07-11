module mode_selector ( 
  input        clk,
  input        rst_n,
  input        btn,
  output [1:0] mode
  );
  
  wire         btn_debounced;
  wire         btn_rising_edge;
  
  debounce debounce (
   .clk     (clk)  
  ,.rst_n   (rst_n)
  ,.btn     (btn)
  ,.db_tick (btn_debounced)
  );
  
  pulse_narrower pulse_narrower (
   .clk       (clk)
  ,.pulse_in  (btn_debounced)
  ,.pulse_out (btn_rising_edge)
  );
  
  counter_2bit counter_2bit (
   .clk              (clk)
  ,.rst_n            (rst_n)
  ,.enable_debounced (btn_rising_edge)
  ,.count_out        (mode)
  );
  
endmodule 
