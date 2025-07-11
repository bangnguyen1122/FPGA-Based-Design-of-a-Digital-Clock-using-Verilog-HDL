module bin2bcd (
  input  [5:0] binary_in,
  output [3:0] bcd_units,
  output [3:0] bcd_tens
  );
    
  reg [13:0] shift_reg;
  integer   i;
  
  always @(*) begin
    shift_reg = {8'b0000_0000, binary_in};
	for (i = 0; i < 5; i = i + 1) begin
	  shift_reg = {shift_reg[12:0], 1'b0};
	  if (shift_reg[9:6] > 4'd4) shift_reg[9:6] = shift_reg[9:6] + 3'b011;
	end 
	shift_reg = {shift_reg[12:0], 1'b0};
  end 
   
  assign bcd_units = shift_reg[9:6 ];
  assign bcd_tens  = shift_reg[13:0];

endmodule 
