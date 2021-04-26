module PriorityEncoder83(r, p, b) ;
  input [7:0] r ;
  input [7:0] p ;
  output [2:0] b ;
  wire [7:0] g ;
  ProgPriArb #(8) a(r, p, g) ;
  Enc83 e(g, b) ;
endmodule
