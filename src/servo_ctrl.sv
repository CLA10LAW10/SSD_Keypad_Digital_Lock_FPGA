`timescale 1ns / 1ns

module servo_ctrl (
    input logic clk,
    input logic reset,
    input logic [3:0] led_status,
    output logic servo
  );

  parameter resolution = 8;
  parameter grad_thresh = 2_499_999;
  logic servo_reg;
  logic [31:0] dvsr = 'd1954;
  logic [resolution:0] duty; // Use to assign a single dim value = 'd25;

  integer counter;
  logic gradient_pulse;
  logic [resolution:0] duty_reg;

  pwm_enhanced #(.R(resolution)) pwm_controller(.clk(clk),.reset(rst),.dvsr(dvsr),.duty(duty),.pwm_out(servo_reg));

  always_ff @ (posedge clk, posedge reset)
  begin
    if (reset)
    begin
      counter <= 0;
      duty_reg <= 95;
    end
    else
    begin
      if (counter < grad_thresh)
      begin
        counter <= counter + 1;
        gradient_pulse <= 0;
      end
      else
      begin
        counter <= 0;
        gradient_pulse <= 1;
      end

      if (led_status == 4'b1111)
      begin
        if (gradient_pulse == 1)
        begin
            if (duty_reg < 255) begin
                duty_reg <= duty_reg + 1;
            end else begin
                duty_reg <= duty_reg;
            end
        end
      end
      else
      begin
        duty_reg <= 95;
      end
    end
  end

  assign duty = duty_reg;

  assign servo = servo_reg;

endmodule
