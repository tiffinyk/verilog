module ProgPriArb(r, p, g) ;
  parameter n=8 ;
  input [n-1:0] r ;
  input [n-1:0] p ;
  output [n-1:0] g ;
  wire [2*n-1:0] c ;
  wire [n-1:0] g ;
  //assign c = {{n{1'b0}},p} | ({~r[n-1:1], ~r, ~r[0]} & {c[2*n-1:1],1'b0});
  //assign c = {p,{n{1'b0}}} | ({~r[n-1:1], ~r, ~r[0]} & {1'b0,c[2*n-1:1]});
  //assign c = {{n{1'b0}},p} | ({~r[n-1:1], ~r, ~r[0]} & {1'b0,c[2*n-1:1]});
  assign c[2*n-1:0] = ({~r[0],~r,~r[n-1:1]}&{1'b0,c[2*n-1:1]})|{p,{n{1'b0}}};
  assign g = r & (c[2*n-1:n] | c[n-1:0]) ;
endmodule
