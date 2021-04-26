module gry2bin(Gry,Bin);
  parameter length = 4;
  input [length-1:0] Gry;
  output [length-1:0] Bin;
  reg [length-1:0] Bin;
  integer i;
  always @ (Gry)begin       
  Bin[length-1]=Gry[length-1];       
  for(i=length-2;i>=0;i=i-1)               
    Bin[i]=Bin[i+1]^Gry[i];
  end
endmodule
