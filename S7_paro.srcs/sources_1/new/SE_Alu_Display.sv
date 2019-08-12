`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.08.2019 18:56:33
// Design Name: 
// Module Name: SE_Alu_Display
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


module SE_Alu_Display(  input logic clock,
                        input logic reset,
                        input logic UART_TXD_IN,    //RX
                        //output logic UART_RXD_OUT,  //TX
                        output logic [6:0]sevenSeg,
                        output logic [7:0]AN,
                        output logic [4:0]LED,    
                        output logic salida_lista                 
                      );    
    //UART        
    logic [7:0]rx_data;   //dato proveniende de la uart
    logic rx_ready1;       //señal de recepcion completa de la uart
    logic salida_ready;
    
    //ALU
    logic [15:0] OP1,OP2,salida_alu; //Operandos y resultado
    logic [1:0] operacion_control;   //operancion a realizar
    
    //otras conexiones
    logic [31:0]numero_mostar; //numero que mando al double dabble
    logic [31:0]BCD_32b;
    logic idle;   //indica si la conversion de binario a bcd esta lista! (unsigned_to_bcd)
    logic [3:0]info_estado;
   
   //UART
    Uart_rx_se Uart_basic_se (.clk(clock),
                              .reset(reset),
                              .rx(UART_TXD_IN),
                              .rx_data(rx_data),
                              .rx_ready(rx_ready1)
                              );
                        
     //RECEPCION DE DATOS QUE ENVIA LA UART                   
    UART_RX_CTRL Control_recepcion (.clock(clock),            
                                    .reset(reset),            
                                    .rx_data(rx_data),   
                                    .rx_ready(rx_ready1),       
                                    .operando_1(OP1), 
                                    .operando_2(OP2), 
                                    .ALU_control(operacion_control), 
                                    .guarda_bytes(info_estado),
                                    .salida_lista(salida_ready)  
                                    );
                                    
    //ALU
    ALU_generalizado #(16) ALU (.operando_A(OP1),
                                .operando_B(OP2),
                                .operacion(operacion_control), 
                                .resultado(salida_alu)
                                );
   //logica que quiero mostar  
    Logica_mostrar Que_mandar (.estado_actual(info_estado), 
                               .operando_A(OP1),   
                               .operando_B(OP2),   
                               .salida_alu(salida_alu),           
                               .Numero_listo(numero_mostar) 
                               );
   
                              
    //CONVERTIR DE BINARIO A DECIMAL
    unsigned_to_bcd u32_to_bcd_inst (.clk(clock),
                                     .trigger('b1),
                                     .in(numero_mostar),
                                     .bcd(BCD_32b), 
                                     .idle(idle));
                                     
    //Codificador display , para mostrar en los displays.
    
    Codificador_display_32bits CD_32b (.clk(clock),
                                       .reset(reset),
                                       .SW(BCD_32b),
                                       .sevenSeg(sevenSeg),
                                       .AN(AN));
assign LED = info_estado;
assign salida_lista = salida_ready;
endmodule
