`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2019 13:34:32
// Design Name: 
// Module Name: Codificador_display_32bits
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


module Codificador_display_32bits(
    input logic clk ,
    input logic reset , 
    input logic [31:0]SW , //entrada de 32 bits , numero que queremos mostrar
    output logic [7:0]AN,
    output logic [6:0]sevenSeg);
    
    logic [2:0]cuenta;
    logic [3:0]digito;
    logic clk_out;
    
    
    logic [3:0]bus_1,bus_2,bus_3,bus_4,bus_5,bus_6,bus_7,bus_8;
    
    assign bus_1 = SW[3:0]; //menos significativo
    assign bus_2 = SW[7:4];
    assign bus_3 = SW[11:8];
    assign bus_4 = SW[15:12];
    assign bus_5 = SW[19:16];
    assign bus_6 = SW[23:20];
    assign bus_7 = SW[27:24];
    assign bus_8 = SW[31:28]; //mas significativo
    
    clock_divider #(50000) Divisor_frec (.clk(clk),.reset(reset),.clk_out(clk_out));
    //se escogio 50000 en el contador , para que la frecuencia de muestreo sea 10 HZ
    
    Contador_nBits #(3) Contador_3bits (.clk(clk_out),
                                        .reset(reset),
                                        .count(cuenta));
    
    SW_selector Selector_Sw  (.nibble_1(bus_1),
                              .nibble_2(bus_2),
                              .nibble_3(bus_3),
                              .nibble_4(bus_4),
                              .nibble_5(bus_5),
                              .nibble_6(bus_6),
                              .nibble_7(bus_7),
                              .nibble_8(bus_8),
                              .contador(cuenta),
                              .BCD_in(digito));
 
    Anodo_Select Eligir_anodo (.contador(cuenta),
                               .AN(AN));
                               
   BCD_to_sevenSeg bits4_display (.BCD_in(digito),
                                  .sevenSeg(sevenSeg));
                   
                 
endmodule