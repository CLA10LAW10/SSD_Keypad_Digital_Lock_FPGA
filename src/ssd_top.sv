`timescale 1ns / 1ps

module ssd_top(
    input pulse_50Mhz,
    input [3:0] btn,
    input pulse_50Hz,
    output [6:0] seg0,
    output [6:0] seg1,
    output chip_sel0,
    output chip_sel1,
    input [3:0] row, // Used for simulation
    output logic [3:0] col // Used for sim
    // inout [7:0] keypad
  );

  parameter clk_freq = 50_000_000;
  parameter stable_time = 10; // ms

  logic [7:0] keypad; // Used for simulation
  assign keypad = {row,col}; // Used for simulation

  logic rst;

  logic c_sel_pulse;
  assign c_sel_pulse = pulse_50Hz;

  logic [7:0] keypad_w;
  logic c_sel;
  logic is_a_key_pressed;
  logic is_a_key_pressed_db;
  logic is_a_key_pressed_pulse;
  logic [1:0] key_press;
  logic [3:0] decode_out;

  // SSD Instantiations
  logic [3:0] decode0;
  logic [3:0] decode1;
  logic [3:0] decode2;
  logic [3:0] decode3;

  logic [6:0] output_ssd0;
  logic [6:0] output_ssd1;
  logic [6:0] output_ssd2;
  logic [6:0] output_ssd3;

  logic [6:0] seg_reg0;
  logic [6:0] seg_reg1;

  keypad_decoder de_inst1(
                   .clk(clk),
                   .rst(rst),
                   .row(keypad[7:4]),
                   .col(keypad[3:0]),
                   .decode_out(decode_out), // Pass to SSD Controller
                   .is_a_key_pressed(is_a_key_pressed));

  disp_ctrl ssd0(
              .disp_val(decode0),
              .seg_out(output_ssd0));

  disp_ctrl ssd1(
              .disp_val(decode1),
              .seg_out(output_ssd1));

  disp_ctrl ssd2(
              .disp_val(decode2),
              .seg_out(output_ssd2));

  disp_ctrl ssd3(
              .disp_val(decode3),
              .seg_out(output_ssd3));

  debounce  #(
              .clk_freq(clk_freq),
              .stable_time(stable_time)
            )
            db_inst_2
            (
              .clk(clk),
              .rst(rst),
              .button(is_a_key_pressed),
              .result(is_a_key_pressed_db));

  single_pulse_detector #(
                          .detect_type(2'b0)
                        )
                        pls_inst_2 (
                          .clk(clk),
                          .rst(rst),
                          .input_signal(is_a_key_pressed_db),
                          .output_pulse(is_a_key_pressed_pulse));

  pulse_gen pg_inst1(
              .clk(clk),
              .rst(rst),
              .pulse(c_sel_pulse)
            );

  always_ff @ (posedge clk, posedge rst)
  begin
    if (rst == 1)
    begin
      key_press = 2'b0;
      decode1 = 4'b0;
      decode2 = 4'b0;
      c_sel = 1'b0;
    end
    else
    begin

      seg_reg0 = c_sel ? output_ssd1 : output_ssd0;
      seg_reg1 = c_sel ? output_ssd3 : output_ssd2;

      if (c_sel_pulse)
      begin
        c_sel = ~c_sel;
      end

      if (is_a_key_pressed_pulse)
      begin
        if (key_press == 2'b00)
        begin
          decode0 = decode_out;
          key_press = 2'b01;
        end
        else if (key_press == 2'b01)
        begin
          decode1 = decode_out;
          key_press = 2'b10;
        end
        else if (key_press == 2'b10)
        begin
          decode2 = decode_out;
          key_press = 2'b11;
        end
        else if (key_press == 2'b11)
        begin
          decode3 = decode_out;
          key_press = 2'b00;
        end
        else 
        begin
          decode0 = decode_out;
          key_press = 2'b00;
        end
      end // End of is a key pulse pressed decoder
    end // End of synchronous clock else
  end // End of always ff

  assign seg0 = seg_reg0;
  assign seg1 = seg_reg1;
  assign rst = btn[0];
  assign chip_sel = c_sel;

endmodule
