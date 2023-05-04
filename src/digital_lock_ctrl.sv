`timescale 1ns / 1ps

module digital_lock_ctrl(
    input clk,
    input [3:0] btn,
    input pulse25,
    input [3:0] ssd_0,
    input [3:0] ssd_1,
    input [3:0] ssd_2,
    input [3:0] ssd_3,
    input [3:0] led_status,
    input [2:0] rgb_status,
    output [3:0] led,
    output [2:0] rgb,
    output [15:0] password,
    output [3:0] re_enter,
    output [7:0] exit
  );

  // Logic for digital lock
  logic [15:0] password_reg;
  logic [3:0] re_enter_reg;
  logic [7:0] exit_reg;

  // logic is_a_key_pressed;
  logic [3:0] led_reg;
  // logic [3:0] led_lock;
  logic [3:0] led_toggle1;
  logic [3:0] led_toggle2;
  logic [2:0] rgb_reg;
  // logic [2:0] rgb_lock;
  logic [2:0] rgb_toggle1;
  logic [2:0] rgb_toggle2;

  always_ff @ (posedge clk, posedge rst)
  begin
    if (rst)
    begin
      led_reg <= 4'b0000;
      rgb_reg <= 4'b0000;
      led_toggle1 <= 4'b1010;
      led_toggle2 <= 4'b1111;
      rgb_toggle1 <= 3'b001;
      rgb_toggle2 <= 3'b010;
    end
    else
    begin
      if (pulse25)
      begin
        if (led_status == 4'b0101)
        begin
          led_toggle1 <= ~led_toggle1;
          led_reg <= led_toggle1;
        end
        else if (led_status == 4'b1111)
        begin
          led_toggle2 <= ~led_toggle2;
          led_reg <= led_toggle2;
        end
        else
        begin
          led_reg <= led_status;
        end

        if (rgb_status == 3'b001)
        begin
          rgb_toggle1 <= {~rgb_toggle1[2],rgb_toggle1[1],~rgb_toggle1[0]};
          rgb_reg <= rgb_toggle1;
        end
        else if (rgb_status == 3'b010)
        begin
          rgb_toggle2 <= {rgb_toggle2[2],~rgb_toggle2[1],rgb_toggle2[0]};
          rgb_reg <= rgb_toggle2;
        end
        else
        begin
          rgb_reg <= rgb_status;
        end

      end
      else
      begin
        led_reg <= led_reg;
        rgb_reg <= rgb_reg;
      end
    end
  end

  // Control the password, exit  condition, and re-enter value.
  always_ff @ (posedge clk, posedge rst)
  begin
    if (rst)
    begin
      password_reg <= 16'b0;
      re_enter_reg <=  4'b0;
      exit_reg <= 8'b0;
    end
    else
    begin
      if (btn[1])
      begin
        password_reg <= {ssd_3,ssd_2,ssd_1,ssd_0};
      end
      else if (btn[2])
      begin
        exit_reg <= {ssd_1,ssd_0};
      end
      else if (btn[3])
      begin
        re_enter_reg <= ssd_0;
      end
      else
      begin
        password_reg <= password_reg;
        exit_reg <= exit_reg;
        re_enter_reg <= re_enter_reg;
      end
    end
  end // End always password block

  assign rst = btn[0];
  assign password = password_reg;
  assign re_enter = re_enter_reg;
  assign exit = exit_reg;
  assign led = led_reg;
  assign rgb = rgb_reg;

endmodule
