module Arbiter(r, g) ;
  parameter n=8 ;
  input [n-1:0] r ;
  output [n-1:0] g ;
  wire [n-1:0] c ;
  wire [n-1:0] g ;
  assign c = {1'b1, (~r[n-1:1] & c[n-1:1])} ;
  assign g = r & c ;
endmodule

module Encoder83(g,bin);
 input[7:0] g;
 output[2:0] bin;
 reg[2:0] bin;
 always@(g)
 begin
   case(g)
     8'b00000001: bin=3'b000;
     8'b00000010: bin=3'b001;
     8'b00000100: bin=3'b010;
     8'b00001000: bin=3'b011;
     8'b00010000: bin=3'b100;
     8'b00100000: bin=3'b101;
     8'b01000000: bin=3'b110;
     8'b10000000: bin=3'b111;
     default: bin=3'b000;
   endcase
 end
endmodule
