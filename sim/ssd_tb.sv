`timescale 1ns / 1ps

module ssd_tb();

  logic pulse_50Mhz; // Input
  logic pulse_50Hz; // Input
  logic [3:0] btn; // Input
  logic [3:0] led; // Output
  logic led_g; // Output
  logic [6:0] seg0; // Output
  logic [6:0] seg1; // Output
  logic chip_sel0; // Output
  logic chip_sel1; // Output
  //wire  [7:0] keypad; // Inout - bidirectional signal from DUT
  logic [3:0] row;
  logic [3:0] col;

  parameter CP = 20;
  parameter toggle = 20_000_000;


  ssd_top ssd_uut (.*);

  // Process made to toggle the pulse_50Mhz every 10ns.
  always
  begin
    pulse_50Mhz <= 1'b1;
    #(CP/2);
    pulse_50Mhz <= 1'b0;
    #(CP/2);
  end

  // Process made to toggle the pulse_50Hz every 10_000_000ns.
  always
  begin
    pulse_50Hz <= 1'b1;
    #(toggle/2);
    pulse_50Hz <= 1'b0;
    #(toggle/2);
  end

  // Simulation inputs.
  initial
  begin
    // Set initial values
    row = 4'd0;
    btn = 4'd1;
    #CP;
    btn = 4'd0;

    // Hit a key, 1
    row = 4'b1011;
    col = 4'b1011;
    #(CP * 125_000);
    row = 4'b0000;

    // Hit a key, 2
    row = 4'b1011;
    #(CP * 125_000);
    row = 4'b0000;
    #(CP * 4_000_000);

    // Hit a key, 3
    row = 4'b1101;
    #(CP * 125_000);
    row = 4'b0000;    
    
    // Hit a key, 4
    row = 4'b1101;
    #(CP * 125_000);
    row = 4'b0000;

    // Let it cycle with the new four digits.
    #(CP * 4_000_000);

    $finish;

  end

endmodule
