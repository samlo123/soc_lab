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

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_proj_example
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */

module user_proj_example #(
           parameter BITS = 32,
           parameter DELAYS = 10
       )(
`ifdef USE_POWER_PINS
           inout vccd1,	// User area 1 1.8V supply
           inout vssd1,	// User area 1 digital ground
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

           // IRQ
           output [2:0] irq
       );

wire clk;
wire rst;
// Assuming LA probes [65:64] are for controlling the count clk & reset  
//assign clk = (~la_oenb[64]) ? la_data_in[64]: wb_clk_i;
//assign rst = (~la_oenb[65]) ? la_data_in[65]: wb_rst_i;

assign clk = wb_clk_i;
assign rst = wb_rst_i;

//wire decoded;
//assign decoded = wbs_adr_i[31:20] == 12'h380 ? 1'b1 : 1'b0;

wire [1:0] decoded;
assign decoded = (wbs_adr_i[31:20] == 12'h380) ? 2'd2 :
       (wbs_adr_i[31:20] == 12'h300) ? 2'd1 : 0;

// IO
//assign io_out = count;
//assign io_oeb = {(`MPRJ_IO_PADS-1){rst}};

// IRQ
//assign irq = 3'b000;	// Unused
// LA
//assign la_data_out = {{(127-BITS){1'b0}}, count};
// Assuming LA probes [63:32] are for controlling the count register  
//assign la_write = ~la_oenb[63:32] & ~{BITS{valid}};

bram user_bram (
         .CLK(clk),
         .WE0(ram_wren),
         .EN0(ram_en),
         .Di0(wbs_dat_i),
         .Do0(wbs_dat_o),
         .A0(wbs_adr_i)
     );

// request signal
wire request;
assign request = wbs_stb_i & wbs_cyc_i & (decoded ==2'd2);

// inputs to ram
wire [31:0] ram_address;
wire [31:0] ram_data;
wire [3:0] ram_wren;
wire ram_en;

// select data to on-chip ram only when request = '1'
// otherwise wren will be '0', so that no data will be
// written into onchip ram by mistake.
assign ram_address = (request == 1'b1)? wbs_adr_i:31'b0;
assign ram_data    = (request == 1'b1)? wbs_dat_i:32'b0;
assign ram_wren = (request == 1'b1)? (wbs_sel_i & {4{wbs_we_i}}):4'b0;
assign ram_en   = (request == 1'b1)? 1'b1:1'b0;

reg wbs_ack_o;
reg [3:0] delay_count;
// register wb_ack output, because onchip ram0 uses registered output
always @ (posedge clk) begin
    if (rst) begin
        wbs_ack_o <= 0;
        delay_count <= 0;
    end
    else if(request == 1'b1) begin
        if(delay_count == DELAYS) begin
            delay_count <= 0;
            wbs_ack_o <= 1;
        end
        else begin
            delay_count <= delay_count + 1;
            wbs_ack_o <= 0;
        end
    end
    else begin
        //delay_count <= 0;
        wbs_ack_o <= 0;
    end

end

endmodule

`default_nettype wire
