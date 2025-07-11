module counter_2bit (
  input        clk,
  input        rst_n,
  input        enable_debounced,
  output [1:0] count_out
  );
  
  reg [1:0] count_reg;
  
  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) count_reg <= 2'b00;
    else begin
      if (enable_debounced) count_reg <= count_reg + 1;
	  else count_reg <= count_reg;
    end 	
  end   
  
  assign count_out = count_reg;
  
endmodule 





