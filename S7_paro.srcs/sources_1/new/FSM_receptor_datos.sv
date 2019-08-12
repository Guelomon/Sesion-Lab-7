`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2019 02:57:00
// Design Name: 
// Module Name: FSM_receptor_datos
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


module FSM_receptor_datos(input logic clock,
                          input logic reset,
                          input logic UART_TXD_IN,    //RX
                          //output logic UART_RXD_OUT,  //TX
                          output logic [4:0]LED,    
                          output logic salida_lista   
                          );
//UART        
    logic [7:0]rx_data;   //dato proveniende de la uart
    logic rx_ready1;       //señal de recepcion completa de la uart
    logic salida_ready;

//UART
    Uart_rx_se Uart_basic_se (.clk(clock),
                              .reset(reset),
                              .rx(UART_TXD_IN),
                              .rx_data(rx_data),
                              .rx_ready(rx_ready1)
                              );
//UART_RX_control
logic [3:0]info_estado;

     //RECEPCION DE DATOS QUE ENVIA LA UART                   
    UART_RX_CTRL Control_recepcion (.clock(clock),            
                                    .reset(reset),            
                                    .rx_data(rx_data),   
                                    .rx_ready(rx_ready1),       
                                    .operando_1(), 
                                    .operando_2(), 
                                    .ALU_control(), 
                                    .guarda_bytes(info_estado),
                                    .salida_lista(salida_ready)  
                                    );
                                                                        
assign LED = info_estado;
assign salida_lista = salida_ready;
endmodule
