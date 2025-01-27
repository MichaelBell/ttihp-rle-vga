`default_nettype none
`timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module tb ();

  // Wire up the inputs and outputs:
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

  wire spi_clk = uio_out[3];
  wire spi_cs = uio_out[0];
  wire spi_mosi = uio_out[1];
  reg [3:0] spi_miso;

  wire [5:0] colour = {uo_out[0], uo_out[4], uo_out[1], uo_out[5], uo_out[2], uo_out[6]};
  wire hsync = uo_out[7];
  wire vsync = uo_out[3];

  // Replace tt_um_example with your module name:
  tt_um_MichaelBell_rle_vga user_project (
      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      .uio_in ({2'b00, spi_miso[3:2], 1'b0, spi_miso[1:0], 1'b0}),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );

endmodule
