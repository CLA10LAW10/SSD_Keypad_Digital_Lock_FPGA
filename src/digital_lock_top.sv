`timescale 1ns / 1ps

module digital_lock_top
  #(clk_freq = 125_000_000,
    stable_time = 10)
   (
     input clk,
     input [3:0] btn,
     input [3:0] sw,
     output [3:0] led,
     output [2:0] rgb
   );

  logic rst;

  logic [3:0] btn_db;
  logic [3:0] btn_pulse;

  // Logic for digital lock
  logic [15:0] password;
  logic [3:0] re_enter;
  logic [7:0] exit;
  logic is_a_key_pressed;
  logic [3:0] led_reg;
  logic [3:0] led_lock;
  logic [3:0] led_toggle1;
  logic [3:0] led_toggle2;
  logic [2:0] rgb_reg;
  logic [2:0] rgb_lock;
  logic [2:0] rgb_toggle1;
  logic [2:0] rgb_toggle2;

  // Move to input?
  logic pulse_25Hz;

  // The for-loop creates 16 assign statements
  genvar i;
  generate
    for (i=0; i < 4; i++)
    begin : debounce_generator
      debounce  #(.clk_freq(clk_freq), .stable_time(stable_time))
                db_inst (.clk(clk), .rst(rst), .button(btn[i]), .result(btn_db[i]));
    end
  endgenerate

  genvar j;
  generate
    for (j=0; j < 4; j++)
    begin : pulse_generator
      single_pulse_detector #(.detect_type(2'b0))
                            pls_inst_1 (.clk(clk), .rst(rst), .input_signal(btn_db[j]), .output_pulse(btn_pulse[j]));
    end
  endgenerate

  pulse_gen pulse_25 (.clk(clk), .rst(rst), .pulse25(pulse_25Hz), .pulse50(pulse_50Hz));

  digital_lock lock_uut(.clk(clk), .rst(rst), .password(password), .re_enter(re_enter), .exit(exit),.is_a_key_pressed(is_a_key_pressed), .btn(btn_pulse), .led(led_lock), .rgb(rgb_lock));

  // Add Digital Lock Control instantiation.

  assign rst = btn[0];
  assign led = led_reg;
  assign rgb = rgb_reg;

endmodule