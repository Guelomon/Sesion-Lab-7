`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2019 17:34:37
// Design Name: 
// Module Name: Contador_nBits
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


module Contador_nBits
    #(parameter n= 2)  //numero de bits al cual se quiere contar.
    (
    input logic clk  , reset ,
    output logic [n-1:0] count

    );
    always_ff @(posedge clk) begin 
        if (reset)
            count <= 4'b0;
        else if (count==n*n)
            count <= 4'b0;
        else 
        count <= count + 1 ;
        
    end
endmodule
