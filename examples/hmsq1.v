module detect_serial_fsm(
    input               clk_i,
    input               rst_i,
    input               signal_i,
    output  reg         detected_o,
    output  [4:0]       curent_state_o //????????????????

);
parameter length = 5; //??????????

parameter [length-1 : 0]                         //one-hot code
                S_IDLE   = 5'b00001,
                S_State1 = 5'b00010,
                S_State2 = 5'b00100,
                S_State3 = 5'b01000,
                S_State4 = 5'b10000;

reg [length-1 : 0] c_state;
reg [length-1 : 0] n_state;
//????????????????
assign curent_state_o = c_state;
//??????
always @(posedge clk_i or negedge rst_i) begin
    if (!rst_i) begin
        c_state <= S_IDLE; // reset?????        
    end
    else begin
        c_state <= n_state; //next state logic
    end
end

always @(*) begin   //state register
    case(c_state)
        S_IDLE   : 
          if (signal_i)
            n_state = S_State1;
          else 
            n_state = S_IDLE;
        S_State1 :
          if (signal_i)
            n_state = S_State1;
          else 
            n_state = S_State2;
        S_State2 :
          if (signal_i)
            n_state = S_State3;
          else  
            n_state = S_IDLE;
        S_State3 :
          if (signal_i)
            n_state = S_State4;
          else 
            n_state = S_State2;
        S_State4 :
          if (signal_i)
            n_state = S_State1;
          else 
            n_state = S_State2; 
        default :
            n_state = S_IDLE;
    endcase 
end

always @ (*) begin   //output logic
    case(c_state)
        S_IDLE   : detected_o = 1'b0;
        S_State1 : detected_o = 1'b0;
        S_State2 : detected_o = 1'b0;
        S_State3 : detected_o = 1'b0;
        S_State4 : detected_o = 1'b1;
        default  : detected_o = 1'b0;
    endcase
end

endmodule
