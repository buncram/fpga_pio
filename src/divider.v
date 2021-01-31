`default_nettype none
module divider (
  input         clk,
  input         reset,
  input [23:0]  div,
  output reg    penable
);

  reg [31:0] div_counter;

  always @(posedge clk) begin
    if (reset) begin
      div_counter <= 0;
      penable <= 1;
    end else begin
      if (div <= 23'h100) // normal clock if divider 1 or less
        penable <= 1;
      else begin
        div_counter <= div_counter + 256;
        if (div_counter >= div -1)
          div_counter <= 0;
        penable <= div_counter < (div >> 1);
      end
    end
  end

endmodule
 