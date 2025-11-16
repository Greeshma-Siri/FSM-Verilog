module mealy(in,out,rst,clk);
input in;
input rst,clk;
output reg out;
reg[1:0]state,nxt;
parameter s0=2'b00; //begin
parameter s1=2'b01; //10 or 11
parameter s2=2'b10; //110 or 111
parameter s3=2'b11; //1110 or 1111

always @(posedge clk or negedge rst)
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
nxt=in?s3:s0;
end
default: nxt=s0;
endcase
end

always @(state,in) begin
if((state==s3)&&(in==0))
out<=1;
else
out<=0;
end
endmodule
////////////////
module tb;
reg in;
reg rst,clk;
wire out;
mealy ml(.in(in),.out(out),.rst(rst),.clk(clk));

initial begin
clk=0;
forever #5 clk = ~clk;
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
