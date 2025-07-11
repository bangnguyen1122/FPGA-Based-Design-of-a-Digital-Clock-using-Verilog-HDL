module pulse_narrower (
  input  clk,
  input  pulse_in,
  output pulse_out
  );
  
  reg pulse_in_dly;
  
  always @(posedge clk) begin
    pulse_in_dly <= pulse_in;
  end 
  
  assign pulse_out = pulse_in & ~pulse_in_dly;
  
endmodule 