module select_minimun_test;
  parameter n = 8;
  reg [n-1:0] a,b,c;
  wire [n-1:0] min;
  
  select_minimun slmn0(a,b,c,min);
  initial begin
    a=100;
    b=105;
    c=110;
    repeat(15)begin
      #100
      //$display("a=%8b  b=%8b  c=%8b  min=%8b",a,b,c,min);
      $display("a=%d  b=%d  c=%d  min=%d",a,b,c,min);
      a=a+1;
    end
  end 
endmodule


