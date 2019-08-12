`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.07.2019 20:44:29
// Design Name: 
// Module Name: UART_RX_CTRL
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


module UART_RX_CTRL( input logic clock,
                     input logic reset,
                     input logic rx_ready, //indica si la uart ya recibio el byte
                     input logic [7:0]rx_data , // byte que se transmitio desde el Maestro!
                     output logic [15:0]operando_1,
                     output logic [15:0]operando_2,
                     output logic [1:0]ALU_control,
                     output logic [3:0]guarda_bytes,//para indicar si ya llegaron 2 bytes o 1 bystes del alu_control
                     output logic salida_lista
                    );
                    
//Se definen los estados posibles de la FSM
enum logic [3:0] {Wait_OP1_LSB,   //0  
                  Store_OP1_LSB,  //1
                  Wait_OP1_MSB,   //2
                  Store_OP1_MSB,  //3
                  Wait_OP2_LSB,   //4
                  Store_OP2_LSB,  //5
                  Wait_OP2_MSB,   //6
                  Store_OP2_MSB,  //7
                  Wait_CMD,       //8
                  Store_CMD,      //9 
                  Delay_1_cycle,  //10
                  Trigger_TX_result /*11*/  } state, next_state;
                                 
    always_comb begin
        next_state = state;
        salida_lista = 0;
    
        
        case(state)
         Wait_OP1_LSB: begin
                       if(rx_ready) begin
                        next_state = Store_OP1_LSB;
                                    end
                       else
                        next_state = Wait_OP1_LSB;
                       end
         Store_OP1_LSB: begin
                        next_state = Wait_OP1_MSB;
                        end
         Wait_OP1_MSB: begin
                       if(rx_ready) begin
                        next_state = Store_OP1_MSB;
                                    end               
                       else
                        next_state = Wait_OP1_MSB;
                       end
         Store_OP1_MSB: begin
                        next_state = Wait_OP2_LSB;
                        end
         Wait_OP2_LSB: begin
                       if(rx_ready) begin
                        next_state = Store_OP2_LSB;
                                    end
                       else
                        next_state = Wait_OP2_LSB;
                       end
         Store_OP2_LSB: begin
                        next_state = Wait_OP2_MSB;
                        end
         Wait_OP2_MSB: begin
                       if(rx_ready) begin
                        next_state = Store_OP2_MSB;
                                    end                       
                       else
                        next_state = Wait_OP2_MSB;
                       end
         Store_OP2_MSB: begin
                        next_state = Wait_CMD;
                        end
         Wait_CMD: begin
                   if(rx_ready) begin
                    next_state = Store_CMD;
                                end
                   else 
                    next_state = Wait_CMD;
                   end
        Store_CMD: begin
                   next_state = Delay_1_cycle;
                   end
        Delay_1_cycle: begin
                       next_state = Trigger_TX_result; 
                       end
        Trigger_TX_result: begin
                            salida_lista = 1;
                           end
       default begin
               end
        endcase
    end   
    
//se define el flip flop para ir trascisionando entre estados!
    always_ff @(posedge clock) begin
        if(reset)begin
            state <= Wait_OP1_LSB;
            operando_1 <= 'd0;
            operando_2 <= 'd0;
            ALU_control <= 'd0;
                 end
        else begin
            state <= next_state;
            if(state == Store_OP1_LSB)
                 operando_1[7:0] <= rx_data;
            if(state == Store_OP1_MSB)
                operando_1[15:8] <= rx_data;
            if(state == Store_OP2_LSB)
                operando_2[7:0] <= rx_data;
            if(state == Store_OP2_MSB)
                operando_2[15:8] <= rx_data;
            if(state == Store_CMD)
                ALU_control <= {rx_data[1],rx_data[0]};
                
             end
                               end
assign guarda_bytes = state;
                                                                            
endmodule
