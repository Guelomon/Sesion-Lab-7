`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2019 16:15:19
// Design Name: 
// Module Name: ALU_generalizado
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

// n , parametro para decir el numero de bits de la ALU , este es modificable al
// momento de instanciar el modulo.

module ALU_generalizado #(parameter n=8)( input logic [n-1:0]operando_A, 
                                          input logic [n-1:0]operando_B,
                                          input logic [1:0]operacion,  //elije que hacer , antes debe pasar por un mux , para saber que realizar!
                                          output logic[n-1:0]resultado );
                                          
    always_comb begin
        case(operacion)
            2'd0: resultado = operando_A + operando_B;           //suma
            2'd1: resultado = operando_A + (~operando_B + 'd1);  //resta
            2'd2: resultado = operando_A & operando_B;           // and 
            2'd3: resultado = operando_A | operando_B;           //or
            default resultado = 'd0;
         endcase
    end
endmodule
