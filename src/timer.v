module timer (
  input        clk,
  input        increment_enable,
  input        decrement_enable,
  input  [1:0] mode_select,
  input        enable_1hz,
  input        enable_5hz,
  output [5:0] hour_out,
  output [5:0] minute_out,
  output [5:0] second_out
  );

  reg [5:0] hour_reg;
  reg [5:0] minute_reg;
  reg [5:0] second_reg;
  
  // Second 
  always @(posedge clk) begin
    if (enable_1hz) begin
      if (second_reg == 6'd59) second_reg <= 6'd0;
	  else second_reg <= second_reg + 6'd1;
    end else if ((mode_select == 2'b01) && (enable_5hz)) begin
      if (~increment_enable) begin
	    if (second_reg == 6'd59) second_reg <= 6'd0;
	    else second_reg <= second_reg + 6'd1; 
	  end else if (~decrement_enable) begin
	    if (second_reg == 6'd0) second_reg <= 6'd59;
	    else second_reg <= second_reg - 6'd1;
	  end 
	end
  end 
  
  // Minute
  always @(posedge clk) begin
    if ((enable_1hz) && (second_reg == 6'd59)) begin
	  if (minute_reg == 6'd59) minute_reg <= 6'd0;
	  else minute_reg <= minute_reg + 6'd1;
	end else if ((mode_select == 2'b10) && (enable_5hz)) begin
	  if (~increment_enable) begin
	    if (minute_reg == 6'd59) minute_reg <= 6'd0;
		else minute_reg <= minute_reg + 6'd1;
	  end else if (~decrement_enable) begin
	    if (minute_reg == 6'd0) minute_reg <= 6'd59;
		else minute_reg <= minute_reg - 6'd1;
	  end 
	end 
  end 
  
  // Hour 
  always @(posedge clk) begin
    if ((enable_1hz) && (second_reg == 6'd59) && (minute_reg == 6'd59)) begin
	  if (hour_reg == 6'd23) hour_reg <= 6'd0;
	  else hour_reg <= hour_reg + 6'd1;
	end else if ((mode_select == 2'b11) && (enable_5hz)) begin
	  if (~increment_enable) begin
	    if (hour_reg == 6'd23) hour_reg <= 6'd0;
		else hour_reg <= hour_reg + 6'd1;
	  end else if (~decrement_enable) begin
	    if (hour_reg == 6'd0) hour_reg <= 6'd23;
	    else hour_reg <= hour_reg - 6'd1;
	  end 
	end
  end 
  
  assign hour_out   = hour_reg;
  assign minute_out = minute_reg;
  assign second_out = second_reg;
  
endmodule 