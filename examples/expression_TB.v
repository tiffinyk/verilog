module test;
  reg [2:0] count;
  wire f;
  
  Expression e0(count[0],count[1],count[2],f);
  initial begin
    count = 3'b000;
    repeat (8) begin
      #100
      $display("in = %b, f = %b",count,f);
      count = count + 3'b001;
    end
  end
endmodule
