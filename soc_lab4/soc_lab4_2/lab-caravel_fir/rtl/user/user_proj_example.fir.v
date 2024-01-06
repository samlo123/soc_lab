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


`ifndef __GLOBAL_DEFINE_H
        // Global parameters
`define __GLOBAL_DEFINE_H

`define MPRJ_IO_PADS_1 19	/* number of user GPIO pads on user1 side */
`define MPRJ_IO_PADS_2 19	/* number of user GPIO pads on user2 side */
`define MPRJ_IO_PADS (`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2)

`define MPRJ_PWR_PADS_1 2	/* vdda1, vccd1 enable/disable control */
`define MPRJ_PWR_PADS_2 2	/* vdda2, vccd2 enable/disable control */
`define MPRJ_PWR_PADS (`MPRJ_PWR_PADS_1 + `MPRJ_PWR_PADS_2)

        // Analog pads are only used by the "caravan" module and associated
        // modules such as user_analog_project_wrapper and chip_io_alt.

`define ANALOG_PADS_1 5
`define ANALOG_PADS_2 6

`define ANALOG_PADS (`ANALOG_PADS_1 + `ANALOG_PADS_2)

        // Size of soc_mem_synth

        // Type and size of soc_mem
        // `define USE_OPENRAM
`define USE_CUSTOM_DFFRAM
        // don't change the following without double checking addr widths
`define MEM_WORDS 256

        // Number of columns in the custom memory; takes one of three values:
        // 1 column : 1 KB, 2 column: 2 KB, 4 column: 4KB
`define DFFRAM_WSIZE 4
`define DFFRAM_USE_LATCH 0

        // not really parameterized but just to easily keep track of the number
        // of ram_block across different modules
`define RAM_BLOCKS 2

        // Clock divisor default value
`define CLK_DIV 3'b010

        // GPIO control default mode and enable for most I/Os
        // Most I/Os set to be user bidirectional pins on power-up.
`define MGMT_INIT 1'b0
`define OENB_INIT 1'b0
`define DM_INIT 3'b110

`endif // __GLOBAL_DEFINE_H

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
            parameter DELAYS=10,

            parameter pADDR_WIDTH = 12,
            parameter pDATA_WIDTH = 32
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

// Assuming LA probes [65:64] are for controlling the count clk & reset
//assign clk = (~la_oenb[64]) ? la_data_in[64]: wb_clk_i;
//assign rst = (~la_oenb[65]) ? la_data_in[65]: wb_rst_i;

wire clk;
wire rst;
assign clk = wb_clk_i;
assign rst = wb_rst_i;

wire [1:0] decoded;
assign decoded = (wbs_adr_i[31:20] == 12'h380) ? 2'd2 :
       (wbs_adr_i[31:20] == 12'h300) ? 2'd1 : 0;

// request signal
wire user_bram_request;
assign user_bram_request = wbs_stb_i & wbs_cyc_i & (decoded == 2'd2);

wire user_fir_request;
assign user_fir_request = wbs_stb_i & wbs_cyc_i & (decoded == 2'd1);


wire user_fir_ack_o ;
assign user_fir_ack_o = (awready && wready) ? 1 :
			(control_in_request && awready) ?1 :
			(data_length_in_request && awready) ?1 : 
			(data_y_request) ?1 : 
			(rvalid) ? 1 :
			(sm_tvalid) ? 1 : 0;
			//(ss_tready) ? 1 : 0;
			//(sm_tvalid) ? 1 : 0;
			
			
assign wbs_ack_o = user_bram_ack_o | user_fir_ack_o ;

assign wbs_dat_o = (user_bram_ack_o)?user_bram_o:
		(data_y_request ) ? data_y:
		(user_fir_ack_o) ? sm_tdata : 0;

reg [(pDATA_WIDTH-1):0]data_y;
always@(posedge wb_clk_i)begin
	if(wb_rst_i) begin
		data_y <= 0;			
	end
	else if(sm_tvalid) data_y <= sm_tdata;	
end

//assign wbs_ack_o =1;


// IO
//assign io_out = count;
//assign io_oeb = {(`MPRJ_IO_PADS-1){rst}};
// IRQ
//assign irq = 3'b000;	// Unused
// LA
//assign la_data_out = {{(127-BITS){1'b0}}, count};
// Assuming LA probes [63:32] are for controlling the count register
//assign la_write = ~la_oenb[63:32] & ~{BITS{valid}};

wire                              awready;
wire                              wready;
wire                              awvalid;//i
wire        [(pADDR_WIDTH-1): 0]  awaddr;//i
wire                              wvalid;//i
wire signed [(pDATA_WIDTH-1): 0]  wdata;//i
wire                              arready;
wire                              rready;//i
wire                              arvalid;//i
wire        [(pADDR_WIDTH-1): 0]  araddr;//i
wire                              rvalid;
wire signed [(pDATA_WIDTH-1): 0]  rdata;
wire                              ss_tvalid;//i
wire signed [(pDATA_WIDTH-1): 0]  ss_tdata;//i
wire                              ss_tlast;//i
wire                              ss_tready;
wire                              sm_tready;//i
wire                              sm_tvalid;
wire signed [(pDATA_WIDTH-1): 0]  sm_tdata;
wire                              sm_tlast;
wire                              axis_clk;
wire                              axis_rst_n;


assign axis_clk = wb_clk_i;
assign axis_rst_n = !wb_rst_i;
/*
reg tap_in_request, x_in_request;
always@(*) begin
    if (user_fir_request) begin
        tap_in_request = (wbs_adr_i[19:0] >= 20'h40 && wbs_adr_i[19:0] <=20'h7f) ? 1: 0;
        x_in_request = (wbs_adr_i[19:0] >=20'h80 && wbs_adr_i[19:0] <=20'h84) ? 1: 0;
    end
end
*/

wire tap_in_request, x_in_request, control_in_request,data_length_in_request, data_y_request;
assign tap_in_request = (user_fir_request && wbs_adr_i[19:0] >= 20'h40 && wbs_adr_i[19:0] <=20'h7f) ? 1: 0;
assign control_in_request = (user_fir_request && wbs_adr_i[19:0] == 20'h00 ) ? 1: 0;
assign data_length_in_request = (user_fir_request && wbs_adr_i[19:0] == 20'h10 ) ? 1: 0;
assign x_in_request = (user_fir_request && wbs_adr_i[19:0] >=20'h80) ? 1: 0;
assign data_y_request = (user_fir_request && wbs_adr_i[19:0] >=20'h84) ? 1: 0;


assign awvalid   = ((tap_in_request || control_in_request || data_length_in_request) & wbs_we_i) ? 1 : 0;
assign awaddr    = ((tap_in_request || control_in_request || data_length_in_request) & wbs_we_i) ? wbs_adr_i : 0;

assign wvalid    = ((tap_in_request || control_in_request || data_length_in_request)  & wbs_we_i)? 1 : 0;
assign wdata     = ((tap_in_request || control_in_request || data_length_in_request)  & wbs_we_i) ? wbs_dat_i : 0;

assign rready    = (tap_in_request & !wbs_we_i) ? 1 : 0;
assign arvalid   = (tap_in_request & !wbs_we_i) ? 1 : 0;
assign araddr    = (tap_in_request & !wbs_we_i) ? wbs_adr_i : 0;


	


//assign ss_tlast  = (data_length_count==(data_length)) ? 1 : 0;

assign ss_tlast = ss_tlast_sig || ss_tlast_sig_hold;
wire ss_tlast_sig;
assign ss_tlast_sig = (data_length_count==(data_length-1) && ss_tready) ? 1 : 0;
reg ss_tlast_sig_hold;
always@(posedge wb_clk_i)begin
	if(wb_rst_i) ss_tlast_sig_hold  <= 0;
	else if (sm_tlast) ss_tlast_sig_hold  <= 0;
	else if(ss_tlast_sig)ss_tlast_sig_hold  <= 1;
end


assign ss_tvalid = (x_in_request & wbs_we_i) ? 1 : 0;
assign ss_tdata  = (x_in_request & wbs_we_i) ? wbs_dat_i : 0;


reg [(pDATA_WIDTH-1):0]data_length,data_length_count;
always@(posedge wb_clk_i)begin
	if(wb_rst_i) begin
		data_length <= 0;
		data_length_count <=0;		
	end
	else if(data_length_in_request) data_length <= wbs_dat_i;
	else if (sm_tlast) data_length_count <= 0;
	else if(ss_tready) data_length_count <= data_length_count+1;
end



assign sm_tready = (user_fir_request) ? 1 : 0;


// ram for tap
wire        [3:0]        tap_WE;
wire                     tap_EN;
wire [(pDATA_WIDTH-1):0] tap_Di;
wire [(pADDR_WIDTH-1):0] tap_A;
wire [(pDATA_WIDTH-1):0] tap_Do;


// ram for data
wire          [3:0]      data_WE;
wire                     data_EN;
wire [(pDATA_WIDTH-1):0] data_Di;
wire [(pADDR_WIDTH-1):0] data_A;
wire [(pDATA_WIDTH-1):0] data_Do;

wire [1:0] state;
wire ap_start_sig,ss_write_valid,ctrl_tap_valid,ctrl_tap_ready;

fir user_fir(
        .awready(awready), //o
        .wready(wready), //o
        .awvalid(awvalid),
        .awaddr(awaddr),
        .wvalid(wvalid),
        .wdata(wdata),
        .arready(arready), //o
        .rready(rready),
        .arvalid(arvalid),
        .araddr(araddr),
        .rvalid(rvalid), //o
        .rdata(rdata), //o
        .ss_tvalid(ss_tvalid),
        .ss_tdata(ss_tdata),
        .ss_tlast(ss_tlast),
        .ss_tready(ss_tready), //o
        .sm_tready(sm_tready),
        .sm_tvalid(sm_tvalid), //o
        .sm_tdata(sm_tdata), //o
        .sm_tlast(sm_tlast), //o

        // ram for tap
        .tap_WE(tap_WE), //o
        .tap_EN(tap_EN), //o
        .tap_Di(tap_Di), //o
        .tap_A(tap_A), //o
        .tap_Do(tap_Do),

        // ram for data
        .data_WE(data_WE), //o
        .data_EN(data_EN), //o
        .data_Di(data_Di), //o
        .data_A(data_A), //o
        .data_Do(data_Do),

        .axis_clk(axis_clk),
        .axis_rst_n(axis_rst_n),
        .state(state),
        .ss_write_valid(ss_write_valid),
        .ap_start_sig(ap_start_sig),
        .ctrl_tap_valid(ctrl_tap_valid),
        .ctrl_tap_ready(ctrl_tap_ready)

    );

// RAM for tap
bram11 tap_RAM (
           .CLK(axis_clk),
           .WE(tap_WE),
           .EN(tap_EN),
           .Di(tap_Di),
           .A(tap_A),
           .Do(tap_Do)
       );

// RAM for data: choose bram11 or bram12
bram11 data_RAM(
           .CLK(axis_clk),
           .WE(data_WE),
           .EN(data_EN),
           .Di(data_Di),
           .A(data_A),
           .Do(data_Do)
       );




// inputs to ram
wire [31:0] ram_address;
wire [31:0] ram_data;
wire [3:0] ram_wren;
wire ram_en;

// select data to on-chip ram only when request = '1'
// otherwise wren will be '0', so that no data will be
// written into onchip ram by mistake.
assign ram_address = (user_bram_request == 1'b1)? wbs_adr_i:31'b0;
assign ram_data    = (user_bram_request == 1'b1)? wbs_dat_i:32'b0;
assign ram_wren = (user_bram_request == 1'b1)? (wbs_sel_i & {4{wbs_we_i}}):4'b0;
assign ram_en   = (user_bram_request == 1'b1)? 1'b1:1'b0;

reg user_bram_ack_o;
reg [3:0] delay_count;
// register wb_ack output, because onchip ram0 uses registered output
always @ (posedge clk) begin
    if (rst) begin
        user_bram_ack_o <= 0;
        delay_count <= 0;
    end
    else if(user_bram_request == 1'b1) begin
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


wire [31:0] user_bram_o;

bram user_bram (
         .CLK(clk),
         .WE0(ram_wren),
         .EN0(ram_en),
         .Di0(wbs_dat_i),
         .Do0(user_bram_o),
         .A0(wbs_adr_i)
     );


endmodule

`default_nettype wire
















