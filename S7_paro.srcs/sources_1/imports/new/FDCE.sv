`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2019 16:48:21
// Design Name: 
// Module Name: FDCE
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

// FDCE es un flip-flop tipo D con reloj y reset asincronico (limpiador) 
// cuando reatin es 0 y RST_BTN_n es 1 ,leds va a tomar el valor de switches cuando le llegue el canto de reloj de clk
// Cuando RST_BTN_n es 0 , implica que reset = 1 , implicando que Q se borre y vuelva a ser 0 (vuelve al valor por defecto.
// cuando retain es 1 se ignora todo y la salida tiene el mismo valor de antes. 

module FDCE #(parameter N=8)
(	input  logic           clk,
	input  logic           RST_BTN_n,
	input  logic   [N-1:0] switches,
	input  logic           retain,
	output logic   [N-1:0] leds
);

    logic [N-1:0] Q, Q_next;
    logic reset;
    
    assign reset = ~RST_BTN_n;
    assign leds = Q;

	always_ff @(posedge clk) begin
	   if (reset) begin
	       Q <= 2'd0;
	   end else begin
	       Q <= Q_next;
	   end
	end

	always_comb begin
        Q_next = Q;
 
		case (retain)
		  1'b0: 	  Q_next = switches;
		  1'b1: 	  ;
        endcase
	end

endmodule
