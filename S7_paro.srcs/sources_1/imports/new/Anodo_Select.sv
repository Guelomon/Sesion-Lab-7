`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2019 17:41:25
// Design Name: 
// Module Name: Anodo_Select
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


module Anodo_Select
    #(parameter n=3 ) //numero de bits al cual se quiere contar
    (   input logic [n-1:0]contador,
        output logic [7:0]AN  ); //pines del anodo comun display
        
    always_comb begin
        case(contador)  //solo un anodo se prende a la vez , el contador lo elije
            3'd0 : AN = 8'b1111_1110; //se prende el anodo 0
            3'd1 : AN = 8'b1111_1101; //se prende el anodo 1
            3'd2 : AN = 8'b1111_1011; //se prende el anodo 2
            3'd3 : AN = 8'b1111_0111; //se prende el anodo 3
            3'd4 : AN = 8'b1110_1111; //se prende el anodo 4
            3'd5 : AN = 8'b1101_1111; //se prende el anodo 5
            3'd6 : AN = 8'b1011_1111; //se prende el anodo 6
            3'd7 : AN = 8'b0111_1111; //se prende el anodo 7
            default AN = 8'b1111_1111; 
        endcase
    end  
endmodule
