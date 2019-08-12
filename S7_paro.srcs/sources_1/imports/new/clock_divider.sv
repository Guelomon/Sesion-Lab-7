`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2019 16:36:07
// Design Name: 
// Module Name: clock_divider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clock_divider
    #(parameter COUNTER_MAX = 1000)
     (  input logic clk,
        input logic  reset,
        output logic clk_out);
        
    localparam DELAY_WIDTH = $clog2(COUNTER_MAX);
    logic [DELAY_WIDTH-1:0] counter = 'd0;
    
    // Resetea el contador e invierte el valor del reloj de salida 
    // Cada vez que el contador llega  a su valor maximo
    
    always_ff @(posedge clk) begin
        if (reset == 1'b1) begin
            //Reset sincornico , setea el contador y la salida a un valor conocido 
            counter <= 'd0;
            clk_out <= 0;
            end 
        else if (counter == COUNTER_MAX-1) begin
            //Se resetea el contador y se invierte la salida 
            counter <= 'd0;
            clk_out <= ~clk_out;
            end
        else begin
            //Se incrementa el contador y se mantiene la salida en su valor anterior
            counter <= counter + 'd1;
            clk_out <= clk_out;
            end
    end
endmodule
    
    