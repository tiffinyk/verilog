module UDL_Count(clk, rst, up, down, load, in, rs, rd, r3, r2, r1, r0) ;
  parameter n = 4 ;
  input clk, rst, up, down, load ;
  input [n-1:0] in ;
  input [1:0] rs, rd;
  output [n-1:0] r3, r2, r1, r0;
  reg [n-1:0] n3, n2, n1, n0, out;
  wire [n-1:0] next, outpm1 ;
  
  DFF #(n) cnt0(clk, n0, r0) ;
  DFF #(n) cnt1(clk, n1, r1) ;
  DFF #(n) cnt2(clk, n2, r2) ;
  DFF #(n) cnt3(clk, n3, r3) ; //???4?cnt
  
  always@(*)begin
   case(rs)
    2'b00: out=r0;
    2'b01: out=r1;
    2'b10: out=r2;
    2'b11: out=r3;
    default: out=4'b0;
   endcase
  end

  always@(*)begin
   case(rd)
    2'b00: {n3, n2, n1, n0} = {r3,   r2,   r1,   next};
    2'b01: {n3, n2, n1, n0} = {r3,   r2,   next, r0  };
    2'b10: {n3, n2, n1, n0} = {r3,   next, r1,   r0  };
    2'b11: {n3, n2, n1, n0} = {next, r2,   r1,   r0  };
    default: {n3, n2, n1, n0} = {4'b0, 4'b0, 4'b0, 4'b0};
   endcase
  end
  assign outpm1 = out + {{n-1{down}},1'b1} ; // down ? -1 : 1
  
  Mux4 #(n) mux(out, in, outpm1, {n{1'b0}},
                {(~rst & ~up & ~down & ~load),
                 (~rst & load),
                 (~rst & (up | down)),
                 rst},
                next);
endmodule
