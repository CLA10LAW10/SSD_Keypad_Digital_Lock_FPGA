`timescale 1ns / 1ps

module digital_lock_top
  #(clk_freq = 50_000_000,
    stable_time = 10)
   (
     input clk,
     input [3:0] btn,
     input [3:0] sw,
     output [3:0] led,
     output [2:0] rgb,
     output [6:0] seg0,
     output chip_sel0,
     input [3:0] row,
     output logic [3:0] col,
     output servo
   );

  logic rst;

  // Digital lock logic
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
  logic reset_state;

  // Pulse Genetator Logic
  //Control LED/RGB
  logic pulse_25Hz;

  // Digital lock controller logic
  logic [3:0] btn_db;
  logic [3:0] btn_pulse;
  logic [3:0] btn_pass;

  // SSD / Keyboard Logic
  logic pulse_50Mhz;
  logic [3:0] user_input;
  logic [3:0] ssd_0;
  logic [3:0] ssd_1;
  logic [3:0] ssd_2;
  logic [3:0] ssd_3;

  // Servo Controller Logic
  logic servo_reg;

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

  pulse_gen25Hz pg_25Hz(.clk(clk),.rst(rst),.pulse(pulse_25Hz)); // Need to fix to be ~25 Hz

  digital_lock lock_FSM (.clk(clk), .rst(rst), .password(password), .re_enter(re_enter), .exit(exit),
  .is_a_key_pressed(is_a_key_pressed), .btn(user_input), .led(led_lock), .rgb(rgb_lock),.reset_state(reset_state));

  digital_lock_ctrl lock_control (.clk(clk),.btn(btn_pass),.pulse25(pulse_25Hz),
  .ssd_0(ssd_0),.ssd_1(ssd_1),.ssd_2(ssd_2),.ssd_3(ssd_3),
  .led_status(led_lock),.rgb_status(rgb_lock),.led(led_reg),.rgb(rgb_reg),
  .password(password),.re_enter(re_enter),.exit(exit));

  // clk_wiz_0 Clk_wiz_50MHz (.sysclk(clk), .pulse_50Mhz(pulse_50Mhz));
  
  ssd_top SSD_Keypad (.pulse_50Mhz(clk),.btn(btn_pass),.sw(sw),.reset_state(reset_state),
  .seg0(seg0),.chip_sel0(chip_sel0),
  .keypad_value(user_input),.keypress(is_a_key_pressed),.row(row),.col(col),
  .ssd_0(ssd_0),.ssd_1(ssd_1),.ssd_2(ssd_2),.ssd_3(ssd_3));

  servo_ctrl servo_controller (.clk(clk),.reset(rst),.led_status(led_lock),.servo(servo_reg));
  
  assign btn_pass = {btn_pulse[3:1],btn[0]};

  assign servo = servo_reg;
  assign rst = btn[0];
  assign led = led_reg;
  assign rgb = rgb_reg;

endmodule
