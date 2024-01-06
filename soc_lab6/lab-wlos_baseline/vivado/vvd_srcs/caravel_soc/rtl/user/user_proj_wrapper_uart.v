// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype wire
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32,
    parameter DELAYS = 1
) (
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

/*--------------------------------------*/
/* User project is instantiated  here   */
/*--------------------------------------*/

// Assuming LA probes [65:64] are for controlling the count clk & reset  
//assign clk = (~la_oenb[64]) ? la_data_in[64]: wb_clk_i;
//assign rst = (~la_oenb[65]) ? la_data_in[65]: wb_rst_i;

// IO
//assign io_out = count;
//assign io_oeb = {(`MPRJ_IO_PADS-1){rst}};

// IRQ
//assign irq = 3'b000;	// Unused
// LA
//assign la_data_out = {{(127-BITS){1'b0}}, count};
// Assuming LA probes [63:32] are for controlling the count register  
//assign la_write = ~la_oenb[63:32] & ~{BITS{valid}};

// request signal
wire request_user_uart;
assign request_user_uart = (wbs_stb_i & wbs_cyc_i &(wbs_adr_i[31:20] == 12'h300)) ? 1 : 0;
       
wire request_user_bram;
assign request_user_bram = (wbs_stb_i & wbs_cyc_i &(wbs_adr_i[31:20] == 12'h380)) ? 1 : 0;


assign wbs_ack_o = user_bram_ack_o | user_uart_ack_o ;

assign wbs_dat_o = 	(user_bram_ack_o)  ? user_bram_o :
			(user_uart_ack_o ) ? user_uart_o : 0;

assign io_out	=	uart_io_out ;
			
assign io_oeb	=	uart_io_oeb ;			
			
assign user_irq =	uart_irq ;			

// inputs to ram
wire [31:0] ram_address;
wire [31:0] ram_data;
wire [3:0] ram_wren;
wire ram_en;

// select data to on-chip ram only when request = '1'
// otherwise wren will be '0', so that no data will be
// written into onchip ram by mistake.
assign ram_address 	= (request_user_bram)? wbs_adr_i:0;
assign ram_data    	= (request_user_bram)? wbs_dat_i:0;
assign ram_wren 	= (request_user_bram)? (wbs_sel_i & {4{wbs_we_i}}):4'b0;
assign ram_en   	= (request_user_bram)? 1:0;

reg user_bram_ack_o;
reg [3:0] delay_count;
// register wb_ack output, because onchip ram0 uses registered output
always @ (posedge clk) begin
    if (rst) begin
        user_bram_ack_o <= 0;
        delay_count <= 0;
    end
    else if(request_user_bram == 1'b1) begin
        if(delay_count == DELAYS) begin
            delay_count <= 0;
            user_bram_ack_o <= 1;
        end
        else begin
            delay_count <= delay_count + 1;
            user_bram_ack_o <= 0;
        end
    end
    else begin
        delay_count <= 0;
        user_bram_ack_o <= 0;
    end

end

wire clk;
wire rst;
assign clk = wb_clk_i;
assign rst = wb_rst_i;

wire [31:0] user_bram_o;

bram user_bram (
         .CLK(clk),
         .WE0(ram_wren),
         .EN0(ram_en),
         .Di0(ram_data),
         .Do0(user_bram_o),
         .A0(ram_address)
     );



// inputs to uart
// Wishbone Slave ports (WB MI A)
wire [31:0] uart_address;
wire [31:0] uart_data;
wire uart_we,uart_stb, uart_cyc;
wire [3:0]uart_sel;
assign uart_stb = (request_user_uart)? wbs_stb_i:32'b0;
assign uart_cyc = (request_user_uart)? wbs_cyc_i:32'b0;
assign uart_we  = (request_user_uart)? wbs_we_i:0;
assign uart_sel = (request_user_uart)? wbs_sel_i:0;
assign uart_data = (request_user_uart)? wbs_dat_i:32'b0;
assign uart_address = (request_user_uart)? wbs_adr_i:32'b0;


wire user_uart_ack_o;
wire [31:0] user_uart_o;

// Logic Analyzer Signals
wire  [`MPRJ_IO_PADS-1:0] uart_io_in;
wire  [`MPRJ_IO_PADS-1:0] uart_io_out;
wire  [`MPRJ_IO_PADS-1:0] uart_io_oeb;
assign uart_io_in	= io_in;

// User maskable interrupt signals
wire[2:0] uart_irq;

uart uart (
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),

    // MGMT SoC Wishbone Slave

    .wbs_stb_i(uart_stb),
    .wbs_cyc_i(uart_cyc),
    .wbs_we_i(uart_we),
    .wbs_sel_i(uart_sel),
    .wbs_dat_i(uart_data),
    .wbs_adr_i(uart_address),
    .wbs_ack_o(user_uart_ack_o),
    .wbs_dat_o(user_uart_o),

    // IO ports
    .io_in  (uart_io_in      ),
    .io_out (uart_io_out     ),
    .io_oeb (uart_io_oeb     ),

    // irq
    .user_irq (uart_irq)
);

endmodule	// user_project_wrapper

`default_nettype wire
