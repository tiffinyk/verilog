module multiple_of_3(in, out);
  input [3:0] in;
  output out;
  assign out = (~in[3]&~in[2]&in[1]&in[0])|
               (~in[3]&in[2]&in[1]&~in[0])|
               (in[3]&~in[2]&~in[1]&in[0])|
               (in[3]&in[2]&~in[1]&~in[0])|
               (in[3]&in[2]&in[1]&in[0]);
endmodule
