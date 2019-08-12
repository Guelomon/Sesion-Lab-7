`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.08.2019 16:57:51
// Design Name: 
// Module Name: Logica_mostrar
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


module Logica_mostrar( input logic [3:0]estado_actual, 
                       input logic [15:0]operando_A,
                       input logic [15:0]operando_B,
                       input logic [15:0]salida_alu,
                       output logic [31:0]Numero_listo  //el que va al unsign_to_bcd
                      );
                      
                   
    always_comb begin
        case(estado_actual)
            5'd4: Numero_listo = {16'd0,operando_A};
                    
            5'd8: Numero_listo = {16'd0,operando_B};
             
            5'd11:Numero_listo = {16'd0,salida_alu};
            default 
                 Numero_listo = 'd0;
        
        endcase
             end
endmodule
