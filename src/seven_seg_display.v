module seven_seg_display (
  input  [3:0] digit,
  output [6:0] segments
  );
  
  reg [6:0] segments_reg;
  
  // 7-segments LED display with common anode  
  always @(*) begin
    case (digit) 
      4'd0: segments_reg = 7'b100_0000;
	  4'd1: segments_reg = 7'b111_1001;
	  4'd2: segments_reg = 7'b010_0100;
	  4'd3: segments_reg = 7'b011_0000;
	  4'd4: segments_reg = 7'b001_1001;
	  4'd5: segments_reg = 7'b001_0010;
	  4'd6: segments_reg = 7'b000_0010;
	  4'd7: segments_reg = 7'b111_1000;
	  4'd8: segments_reg = 7'b000_0000;
	  4'd9: segments_reg = 7'b001_0000;
	  default: segments_reg = 7'b111_1111;   
    endcase
  end
  
  assign segments = segments_reg;

endmodule