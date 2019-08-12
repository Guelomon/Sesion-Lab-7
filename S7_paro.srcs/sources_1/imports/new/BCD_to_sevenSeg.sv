`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.04.2019 16:23:31
// Design Name: 
// Module Name: BCD_to_sevenSeg
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


module BCD_to_sevenSeg(
    input logic [3:0] BCD_in ,   //Se definen las entradas 4 bits (4 cables) Switch de la placa
    output logic [6:0] sevenSeg  //Se definen las salidas 7 bits 
    );
    
    always_comb begin          
        case(BCD_in)          //(gfed_cba)
            4'd0 : sevenSeg = 7'b1000_000 ; //0     // output  is abcdefg pero estan invertidos
            4'd1 : sevenSeg = 7'b1111_001 ; //1     //entonces los anotamos como gfedcba
            4'd2 : sevenSeg = 7'b0100_100 ; //2
            4'd3 : sevenSeg = 7'b0110_000 ; //3
            4'd4 : sevenSeg = 7'b0011_001 ; //4
            4'd5 : sevenSeg = 7'b0010_010 ; //5
            4'd6 : sevenSeg = 7'b0000_010 ; //6
            4'd7 : sevenSeg = 7'b1111_000 ; //7
            4'd8 : sevenSeg = 7'b0000_000 ; //8
            4'd9 : sevenSeg = 7'b0010_000 ; //9
            4'd10 : sevenSeg = 7'b0001_000; //A
            4'd11 : sevenSeg = 7'b0000_011; //B
            4'd12 : sevenSeg = 7'b1000_110; //C
            4'd13 : sevenSeg = 7'b0100_001; //D
            4'd14 : sevenSeg = 7'b0000_110; //E
            4'd15 : sevenSeg = 7'b0001_110; //F
              
            default : sevenSeg = 7'b0111_111 ;   //se escogieron al azar para ver algo en el 7segmento
        endcase
    end
             
endmodule
