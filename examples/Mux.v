module Mux(a, b, st, sml) ;
  parameter n = 8 ;
  input [n-1:0] a, b ; 
  input st ; 
  output[n-1:0] sml ;
  reg [n-1:0] sml;
  wire st;
  MagComp mc(a,b,st);
  always @(*) begin
    case(st)
      1: sml = a;
      0: sml = b;
      default: sml = {n{1'bx}};
    endcase
  end
endmodule
