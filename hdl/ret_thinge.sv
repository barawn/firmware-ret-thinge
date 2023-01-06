`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/06/2023 03:08:08 PM
// Design Name: 
// Module Name: ret-thinge
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


// Just hook up SC_RX/SC_TX to FP_SC_TX and FP_SC_RX_3V3

// NOTE NOTE NOTE:
// The TE0714 connectors are hermaphroditic (same connector connects to itself) so the
// pins SWAP SIDES (odds<->evens) between the two schematics (FPGA and THINGE).
module ret_thinge(
        // These are from FPGA perspective
        input FP_SC_RX_3V3,     // pin 22 JM2 = pin 21 JM2 on FPGA board = B15_L2_P = D9
        output FP_SC_TX,        // pin 28 JM2 = pin 27 JM2 on FPGA board = B15_L11_P = D13
        // These are from LaunchPad perspective (RX=output, TX=input)
        output SC_RX,           // pin 9 JM2 = pin 10 JM2 on FPGA board = B15_L10_P = B14
        input SC_TX,             // pin 5 JM2 = pin 6 JM2 on FPGA board = B15_L8_P = A13
        
        // Set to 1 to enable receiver and drive outputs
        output RCVA_12_EN,      // pin 20 JM2 = pin 19 JM2 on FPGA board = B15_L2_N = C9
        output DRA_12_EN,       // pin 32 JM2 = pin 31 JM2 on FPGA board = B15_L12_P = E13
        
        // these are from FPGA perspective
        input RXD0_P,           // pin 63 JM1 = pin 64 JM1 on FPGA board = B34_L17_N = T3
        input RXD0_N,           // pin 65 JM1 = pin 66 JM1 on FPGA board = B34_L17_P = T4
        // FPGA perspective
        input RXD1_P,           // pin 79 JM1 = pin 80 JM1 on FPGA board = B34_L23_N = V6
        input RXD1_N,           // pin 81 JM1 = pin 82 JM1 on FPGA board = B34_L23_P = U7
        // FPGA perspective
        output PPSTXD0,         // pin 76 JM2 = pin 75 JM2 on FPGA board = B14_L11_P = P15
        output PPSTXD1,         // pin 80 JM2 = pin 79 JM2 on FPGA board = B14_L14_P = R16
        // Drive the panel outputs
        output DRV_PANELS,      // pin 82 JM2 = pin 81 JM2 on FPGA board = B14_L12_P = P14
        
        // these are from LaunchPad perspective (RX=output, TX=input)
        input P1_TX,            // pin 93 JM2 = pin 94 JM2 on FPGA board = B14_L20_P = U14
        output P1_RX,           // pin 95 JM2 = pin 96 JM2 on FPGA board = B14_L20_N = V14
        input P0_TX,            // pin 99 JM2 = pin 100 JM2 on FPGA board = B14_L0 = L14
        output P0_RX,           // pin 97 JM2 = pin 98 JM2 on FPGA board = B14_L25 = U10
        
        input CLK25M,           // B14_L13_P = T14
        output LED              // K18
    );

    wire clk25;
    BUFG u_clk25(.I(CLK25M),.O(clk25));
        
    assign RCVA_12_EN = 1'b1;
    assign DRA_12_EN = 1'b1;
    assign DRV_PANELS = 1'b1;
    
    // Just pass through the FPGA for now.
    assign SC_RX = FP_SC_RX_3V3;
    assign FP_SC_TX = SC_TX;    

    assign PPSTXD0 = P0_TX;
    assign PPSTXD1 = P1_TX;
    
    // These are connected inverted at the FPGA (P<->N are swapped)
    // So we hook them up backwards and use the inverted output.
    IBUFDS_DIFF_OUT u_rxd0(.I(RXD0_N),.IB(RXD0_P),.O(),.OB(P0_RX));
    IBUFDS_DIFF_OUT u_rxd1(.I(RXD1_N),.IB(RXD1_P),.O(),.OB(P1_RX));

    // blink LED
    wire toggle_led;
    reg led_reg = 0;
    dsp_counter_terminal_count #(.FIXED_TCOUNT("TRUE"),
                                 .FIXED_TCOUNT_VALUE(25000000))
                                 u_counter(.clk_i(clk25),
                                           .rst_i(1'b0),
                                           .count_i(1'b1),
                                           .tcount_reached_o(toggle_led));
    always @(posedge clk25) if (toggle_led) led_reg <= ~led_reg;

    assign LED = led_reg;
        
endmodule
