module UART_tx_control_wrapper
#(	parameter INTER_BYTE_DELAY = 1000000,
    parameter WAIT_FOR_REGISTER_DELAY = 100
)(
	input  logic           clock,
    input  logic           reset,
    input  logic           PB,     //señal que gatilla que la salida esta lista.... salida_lista
    input  logic [15:0]    SW,     //resultado que quiero mandar devuelta!, Numero_listo de logica a mostar! (resultado)
    output logic [7:0]     tx_data, 
    output logic           tx_start, //para iniciar trasmision por la uart
    output logic [1:0]     stateID  
    );

logic send16, busy;

TX_control 
#(  .INTER_BYTE_DELAY (INTER_BYTE_DELAY),
    .WAIT_FOR_REGISTER_DELAY (WAIT_FOR_REGISTER_DELAY)
)TX_control_inst0
(
	.clock (clock),
	.reset (reset),
	.PB (PB),     
	.send16 ('d1), //1 0 2 bytes indica cuanto quiero trasmitir
	.dataIn16 (SW),   //datos que quiero trasmitir de 16 bits
	.tx_data (tx_data),  //datos entregados al uart para transmision 
	.tx_start (tx_start), //pulso para iniciar transmision por la uart
	.busy (busy)          //si esta en 1 transmision en proceso
    );

endmodule