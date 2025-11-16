module moore(out,clk,rst,in);
input clk,rst,in;
output reg out;
reg[2:0]state,nxt;
parameter s0=3'b000; //begin
parameter s1=3'b001; //10 or 11
parameter s2=3'b010; //110 or 111
parameter s3=3'b011; //1110 or 1111
parameter s4=3'b100;//11100 or 11101

always @ (posedge clk,negedge rst)
begin
if(!rst)
state<=s0;
else
state<=nxt;
end

always @(state,in) begin
case(state)
s0: begin
nxt=in?s1:s0;
end
s1: begin
nxt=in?s2:s0;
end
s2: begin
nxt=in?s3:s0;
end
s3: begin
nxt=in?s3:s4;
end
s4: begin
nxt=in?s1:s0;
end
default: nxt=s0;
endcase
end

always @(state) begin
if(state==s4)
out <=1;
else
out<=0;
end
endmodule

////////////
module tb;
reg in;
reg rst,clk;
wire out;
moore ml(.out(out),.rst(rst),.clk(clk),.in(in));

initial begin
clk=0;
forever clk = #5 ~clk;
end

initial begin
rst=0;
in=0;
#10 rst=1;
#10 in=1;
#10 in=1;
#10 in=1;
#10 in=0;//seq_detec

#10 in=1;
#10 in=1;
#10 in=0;//no_seq

#10 in=1;
#10 in=1;
#10 in=1;
#10 in=0;//seq_detec

#10 $finish;

end

initial begin
$monitor($time,"clk=%b,in=%b,out=%b",clk,in,out);
end
endmodule
