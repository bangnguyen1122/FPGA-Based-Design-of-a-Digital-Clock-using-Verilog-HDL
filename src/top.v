module top (
  input        clk,
  input        rst_n,
  input        btn_mode,
  input        btn_increment_enable,
  input        btn_decrement_enable,
  output [6:0] second_units,
  output [6:0] second_tens,
  output [6:0] minute_units,
  output [6:0] minute_tens,
  output [6:0] hour_units,
  output [6:0] hour_tens 
  );
  
  wire       enable_1hz_wire;
  wire       enable_5hz_wire;
  wire [1:0] mode_wire;
  wire       increment_debounce_enable;
  wire       decrement_debounce_enable;
  wire [5:0] hour_out_wire;
  wire [5:0] minute_out_wire;
  wire [5:0] second_out_wire;
  wire [3:0] bcd_hour_tens_wire;
  wire [3:0] bcd_hour_units_wire;
  wire [3:0] bcd_minute_tens_wire;
  wire [3:0] bcd_minute_units_wire;
  wire [3:0] bcd_seconds_tens_wire;
  wire [3:0] bcd_seconds_units_wire;

  freq_divider freq_divider (
   .clk     (clk)
  ,.rst_n   (rst_n)
  ,.clk_1hz (enable_1hz_wire)
  ,.clk_5hz (enable_5hz_wire)
  );

  mode_selector mode_selector (
   .clk   (clk)
  ,.rst_n (rst_n)
  ,.btn   (btn_mode)
  ,.mode  (mode_wire)
  );
  
  debounce increment_debounce (
   .clk     (clk)
  ,.rst_n   (rst_n)
  ,.btn     (btn_increment_debounce)
  ,.db_tick (increment_debounce_enable)
  );

  debounce decrement_enable (
   .clk     (clk)
  ,.rst_n   (rst_n)
  ,.btn     (btn_decrement_enable)
  ,.db_tick (decrement_debounce_enable)
  );

  timer timer (
   .clk              (clk)
  ,.increment_enable (increment_debounce_enable)
  ,.decrement_enable (decrement_debounce_enable)
  ,.mode_select      (mode_wire)
  ,.enable_1hz       (enable_1hz_wire)
  ,.enable_5hz       (enable_5hz_wire)
  ,.hour_out         (hour_out_wire)
  ,.minute_out       (minute_out_wire)
  ,.second_out       (second_out_wire)
  );
  
  bin2bcd hour_bin2bcd (
   .binary_in (hour_out_wire)
  ,.bcd_units (bcd_hour_units_wire)
  ,.bcd_tens  (bcd_hour_tens_wire)
  );
  
  bin2bcd minute_bin2bcd (
   .binary_in (minute_out_wire)
  ,.bcd_units (bcd_minute_units_wire)
  ,.bcd_tens  (bcd_minute_tens_wire)
  );
  
  bin2bcd second_bin2bcd (
   .binary_in (second_out_wire)
  ,.bcd_units (bcd_seconds_units_wire)
  ,.bcd_tens  (bcd_seconds_tens_wire)
  );
  
  seven_seg_display hour_tens_display (
   .digit    (bcd_hour_tens_wire)
  ,.segments (hour_tens)
  );
  
  seven_seg_display hour_units_display (
   .digit    (bcd_hour_units_wire)
  ,.segments (hour_units)
  );
  
  seven_seg_display minute_tens_display (
   .digit    (bcd_minute_tens_wire)
  ,.segments (minute_tens)
  );

  seven_seg_display minute_units_display (
   .digit    (bcd_minute_units_wire)
  ,.segments (minute_units)
  );
  
  seven_seg_display second_tens_display (
   .digit    (bcd_seconds_tens_wire)
  ,.segments (second_tens)
  );

  seven_seg_display second_units_display (
   .digit    (bcd_seconds_units_wire)
  ,.segments (second_units)
  );

endmodule 