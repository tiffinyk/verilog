module Multiple_of_5_bit(in, remin, remout) ;
  input in ;
  input [2:0] remin ;
  output [2:0] remout ;
  reg [2:0] remout ;
  always @(*) begin
    case({remin, in})
    4'd0: remout = 0 ;
    4'd1: remout = 1 ;
    4'd2: remout = 2 ;
    4'd3: remout = 3 ;
    4'd4: remout = 4 ;
    4'd5: remout = 0 ;
    4'd6: remout = 1 ;
    4'd7: remout = 2 ;
    4'd8: remout = 3 ;
    4'd9: remout = 4 ;
    4'd10: remout = 0 ;
    4'd11: remout = 1 ;
    4'd12: remout = 2 ;
    4'd13: remout = 3 ;
    4'd14: remout = 4 ;
    4'd15: remout = 0 ;
    default: remout = 3'hx;
    endcase
  end
endmodule
