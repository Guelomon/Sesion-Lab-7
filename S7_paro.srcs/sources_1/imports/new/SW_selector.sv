`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2019 17:57:54
// Design Name: 
// Module Name: SW_selector
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


module SW_selector(
    input logic [3:0]nibble_1,nibble_2,nibble_3,nibble_4, //cada nibble respresenta un digito hexadecimal
                     nibble_5,nibble_6,nibble_7,nibble_8, 
    input logic [2:0]contador,
    output logic [3:0]BCD_in //salida del multiplexor (el valor BCD que quiero respresentar)
    );
    
    always_comb begin
        case(contador)
            2'd0 : BCD_in = nibble_1; //numero hexadecimal menos significativo (menos peso en cantidad)
            2'd1 : BCD_in = nibble_2;
            2'd2 : BCD_in = nibble_3;
            2'd3 : BCD_in = nibble_4;
            3'd4 : BCD_in = nibble_5;
            3'd5 : BCD_in = nibble_6;
            3'd6 : BCD_in = nibble_7;
            3'd7 : BCD_in = nibble_8; //numero hexadecimal mas significativo (mas peso en cantidad)
            default BCD_in =7'b0111_111;   
        endcase
    end 
endmodule
