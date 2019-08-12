`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2019 16:48:22
// Design Name: 
// Module Name: Uart_rx_control_dut
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


module Uart_rx_control_dut();

logic clk;
logic reset;
logic [7:0]dato_enviar;
logic dato_listo;
logic [15:0]op_1;
logic [15:0]op_2;
logic [1:0]alu_operacion;
logic [4:0]estado;
logic output_ready;



UART_RX_CTRL DUT_1 (.clock(clk),            
                    .reset(reset),            
                    .rx_data(dato_enviar),   
                    .rx_ready(dato_listo),       
                      .operando_1(op_1), 
                      .operando_2(op_2), 
                      .ALU_control(alu_operacion),
                      .guarda_bytes(estado),  
                      .salida_lista(output_ready)
                    );
                    
                    
always #5 clk = ~clk;

initial begin 
    clk = 0;
    reset =1;
    dato_listo = 0;
    #10
    reset= 0 ;
    #30
    dato_enviar = 7'd1;
    #10
    dato_listo = 1;
    #10
    dato_listo = 0;
    #10
    dato_enviar = 7'd0;
    #10
    dato_listo = 1;
    #10
    dato_listo = 0;
    #10
    dato_enviar = 7'd9;
    #10
    dato_listo = 1;
    #10
    dato_listo = 0;
    #10
    dato_enviar = 7'd2;
    #10
    dato_listo = 1;
    #10
    dato_listo = 0;
    #10
    dato_enviar = 7'd1;
    #10
    dato_listo = 1;
    #10
    dato_listo = 0;
   
end
endmodule
