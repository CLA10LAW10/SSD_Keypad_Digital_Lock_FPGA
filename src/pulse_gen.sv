`timescale 1ns / 1ps

module pulse_gen(
    input clk,
    input rst,
    output pulse
);

logic [18:0] counter;
logic pulse_reg;
always_ff @(posedge clk, posedge rst) begin
    if (rst == 1) begin
        counter <= 0;
        pulse_reg <= 0;
    end
    else begin
        counter <= counter + 1;
        if (counter == 0) begin
            pulse_reg <= 1;
        end
        else begin
            pulse_reg <= 0;
        end
    end
end

assign pulse = pulse_reg;

endmodule

// `timescale 1ns / 1ps

// module pulse_gen(
//     input clk,
//     input rst,
//     output pulse25,
//     output pulse50
// );

// logic [23:0] counter25; // Roughly 25Hz
// logic [18:0] counter50; // Roughly 50Hz
// logic pulse_reg25;
// logic pulse_reg50;

// // Roughly 25 Hz Pulse Generator
// always_ff @(posedge clk, posedge rst) begin
//     if (rst == 1) begin
//         counter25 <= 0;
//         pulse_reg25 <= 0;
//     end
//     else begin
//         counter25 <= counter25 + 1;
//         if (counter25 == 0) begin
//             pulse_reg25 <= 1;
//         end
//         else begin
//             pulse_reg25 <= 0;
//         end
//     end
// end

// // Roughly 50 Hz Pulse Generator
// always_ff @(posedge clk, posedge rst) begin
//     if (rst == 1) begin
//         counter50 <= 0;
//         pulse_reg50 <= 0;
//     end
//     else begin
//         counter50 <= counter50 + 1;
//         if (counter50 == 0) begin
//             pulse_reg50 <= 1;
//         end
//         else begin
//             pulse_reg50 <= 0;
//         end
//     end
// end

// assign pulse25 = pulse_reg25;
// assign pulse50 = pulse_reg50;

// endmodule