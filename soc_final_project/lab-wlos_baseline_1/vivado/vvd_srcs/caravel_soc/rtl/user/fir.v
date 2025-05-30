module fir_ctrl
    #(
        parameter ADDR_W = 12
    )(
        input                     i_clk,
        input                     i_rst_n,
        input                     i_ready,
        output                    o_valid,
        output      [ADDR_W-1:0]  o_data_addr,
        output      [ADDR_W-1:0]  o_tap_addr,
        output                    muxsel,
        output                    ffen,
        output      [3:0]         count
    );

wire en;
reg o_valid_r, ffen_r;
reg [ADDR_W-1:0]o_data_addr_r, o_tap_addr_r;


assign o_valid = o_valid_r;
assign o_data_addr = o_data_addr_r;
assign o_tap_addr = o_tap_addr_r;
assign ffen = ffen_r;
assign muxsel = ~ffen ;
assign en = i_ready & o_valid;

//wire[3:0] count;
reg[3:0] count_r;
assign count = count_r;

reg [ADDR_W-1:0]tap_last_addr_r;

always@(posedge i_clk) begin
    if (!i_rst_n) begin
        o_data_addr_r <= 0;
        o_tap_addr_r <= 12'd40;
        ffen_r <= 0;
        o_valid_r <= 0;
        count_r <= 0;
    end
    else if(en) begin
        o_valid_r <= (count == 4'd10) ? 0 : 1;

        o_data_addr_r <= (count == 4'd10)? 0:o_data_addr_r + 4;

        o_tap_addr_r <= (count == 4'd10) ? tap_last_addr_r :
                     (o_tap_addr == 12'd40) ? 0 : o_tap_addr + 4;

        tap_last_addr_r <= (count == 0 && o_tap_addr == 0) ? 12'd40 :
                        (count == 0) ? o_tap_addr - 4 : tap_last_addr_r;

        count_r <= (count == 4'd10) ? 0 :count + 1;

        ffen_r <= 1;
    end
    else begin
        o_valid_r <= 1;
        ffen_r <= 0;
    end
end
endmodule


module fir
    #(  parameter pADDR_WIDTH = 12,
        parameter pDATA_WIDTH = 32,
        parameter Tape_Num    = 11
     )
    (
        output  wire                     awready,
        output  wire                     wready,
        input   wire                     awvalid,
        input   wire [(pADDR_WIDTH-1):0] awaddr,
        input   wire                     wvalid,
        input   wire [(pDATA_WIDTH-1):0] wdata,
        output  wire                     arready,
        input   wire                     rready,
        input   wire                     arvalid,
        input   wire [(pADDR_WIDTH-1):0] araddr,
        output  wire                     rvalid,
        output  wire [(pDATA_WIDTH-1):0] rdata,
        input   wire                     ss_tvalid,
        input   wire [(pDATA_WIDTH-1):0] ss_tdata,
        input   wire                     ss_tlast,
        output  wire                     ss_tready,
        input   wire                     sm_tready,
        output  wire                     sm_tvalid,
        output  wire [(pDATA_WIDTH-1):0] sm_tdata,
        output  wire                     sm_tlast,

        // bram for tap RAM
        output  wire           [3:0]     tap_WE,
        output  wire                     tap_EN,
        output  wire [(pDATA_WIDTH-1):0] tap_Di,
        output  wire [(pADDR_WIDTH-1):0] tap_A,
        input   wire [(pDATA_WIDTH-1):0] tap_Do,

        // bram for data RAM
        output  wire            [3:0]    data_WE,
        output  wire                     data_EN,
        output  wire [(pDATA_WIDTH-1):0] data_Di,
        output  wire [(pADDR_WIDTH-1):0] data_A,
        input   wire [(pDATA_WIDTH-1):0] data_Do,

        input   wire                     axis_clk,
        input   wire                     axis_rst_n,
        output  [1:0]state,
        output ss_write_valid,
        output ap_start_sig,
        output ctrl_tap_valid,
        output ctrl_tap_ready
    );
// write your code here!

//state
parameter ap_idle = 0;
//parameter ap_idle = 1;
parameter ap_start = 1;
parameter ap_done = 2'd2;

reg [1:0] state;
wire stream_prepared;
reg ap_start_sig;
reg     sm_tlast_r;
//reg     final_process_r;
//wire    final_process;
//assign  final_process = final_process_r;

reg ctrl_rst_n;



//state
always @( posedge axis_clk ) begin
    if ( !axis_rst_n ) begin
        state <= ap_idle;
        ctrl_rst_n <= 0;
    end
    else begin
        case(state)
            ap_idle: begin
                if(stream_prepared && ap_start_sig) begin
                    state <= ap_start;
                    ctrl_rst_n <= 1;
                end
                sm_tlast_r <= 0;
            end

            ap_start: begin
                if(ss_tlast&& sm_tlast)
                    state <= ap_done;

                if(ss_tlast  && !ctrl_tap_valid)
                    sm_tlast_r <= 1;
                else
                    sm_tlast_r <= 0;

            end

            ap_done: begin
                sm_tlast_r <= 0;
                state <= ap_idle;
                ctrl_rst_n <= 0;

            end
            default:
                state <= ap_idle;

        endcase
    end
end


//AXI4_Stream write
reg ss_tready_r;
assign ss_tready = ss_tready_r;


reg [pADDR_WIDTH-1:0] data_WA_r;
//reg [pDATA_WIDTH-1:0] data_Di_r;
reg [3:0]             data_WE_r;

assign data_WE = data_WE_r ;
wire [pADDR_WIDTH-1:0] data_WA;
assign data_WA = data_WA_r;
//assign data_Di = data_Di_r;
assign data_Di = (state == ap_start) ? ss_tdata : 0;

wire [3:0]             ss_count;
reg [3:0]              ss_count_r;
assign ss_count = ss_count_r;

reg stream_prepared_r;

assign stream_prepared = stream_prepared_r;

reg     ss_read_valid_r;
wire    ss_read_valid;
assign  ss_read_valid = ss_read_valid_r;




//AXI4_Stream write
reg data_EN_sw_r,data_EN_sr_r ,data_EN_r_d;
wire    ss_write_valid;

always @( posedge axis_clk ) begin
    if ( !axis_rst_n ) begin
        ss_tready_r <= 0;
        //final_process_r <= 0;

        data_WA_r <= 0;
        ss_count_r <= 0;
        stream_prepared_r <= 0;

        ss_read_valid_r <= 0;
    end
    else begin
        if (!ss_tready && ss_tvalid) begin
            case(state)
                ap_idle: begin
                    ss_read_valid_r <= 0;
                 
                    if((ss_count <= Tape_Num - 1) && !stream_prepared) begin
                        data_WE_r <= 4'b1111;
                        data_EN_sw_r <= 1;

                        data_WA_r <= (ss_count == 0) ? 0:data_WA_r + 4;
                        ss_count_r <= ss_count_r + 1;
                        //data_Di_r <= 0;

                    end
                    else begin
                        stream_prepared_r <= 1;
                        ss_count_r <= 4'd10;

                        data_EN_sw_r <= 0;
                        data_WE_r <= 0;
                    end

                end

                ap_start: begin

                    if(ss_write_valid ) begin
                        ss_tready_r <= 1;
                        data_WE_r <= 4'b1111;
                        data_EN_sw_r <= 1;

                        data_WA_r <= (ss_count == 4'd10) ? 0 :data_WA_r + 4;
                        ss_count_r <=(ss_count == 4'd10) ? 0 :ss_count_r + 1;
                        //data_Di_r <= ss_tdata;

                        ss_read_valid_r <= 1;

                    end
                    else if (sm_tvalid)
                        ss_read_valid_r <= 0;
                    else begin
                        data_WE_r <= 0;
                        ss_tready_r <= 0;

                    end
                    
                    //if(ss_tlast && sm_tvalid)
                        //final_process_r <= 1;
                end

                ap_done: begin


                end
            endcase
        end
        else begin
            data_WE_r <= 4'b0;
            data_EN_sw_r <= 0;
            ss_tready_r <= 0;
            

            case(state)
                ap_start: begin
                    
            		if (sm_tvalid)
                        ss_read_valid_r <= 0;
                
                end
                
                ap_done: begin
                    stream_prepared_r <= 0;
                    ss_count_r <= 0;
                    //final_process_r <= 0;
                end
                
            endcase


        end

    end

end

//AXI4_Stream read
//reg [pADDR_WIDTH-1:0] data_RA_r;
wire [pADDR_WIDTH-1:0] data_RA;
//assign data_RA = data_RA_r;
assign data_RA = ctrl_data_addr;



assign data_EN = data_EN_sw_r | data_EN_r_d;

always@(posedge axis_clk) begin
    data_EN_r_d <= data_EN_sr_r;
end


assign data_A =(data_EN_sw_r) ? data_WA :
       (data_EN_sr_r) ? data_RA : 0;

reg sm_tvalid_r;
assign sm_tvalid = sm_tvalid_r;

reg  [pDATA_WIDTH-1:0]  sm_tdata_r;
assign  sm_tdata = sm_tdata_r;


assign  sm_tlast = sm_tlast_r;


assign ss_write_valid = ~ ss_read_valid;



//AXI4_Stream read




reg [pADDR_WIDTH-1:0] tap_RA_lr_r, tap_RA_sr_r;
wire [pADDR_WIDTH-1:0]  ctrl_tap_addr, ctrl_data_addr;


reg ctrl_tap_ready_r, tap_EN_sr_r, tap_EN_r_d;
wire ctrl_tap_ready, muxsel, ffen;
//reg [pADDR_WIDTH-1:0] tap_RA_lr_r, tap_RA_sr_r;
wire [pADDR_WIDTH-1:0] tap_RA_lr, tap_RA_sr;
assign tap_RA_lr = (araddr-12'h40);
assign tap_RA_sr = ctrl_tap_addr;

always @( posedge axis_clk ) begin
    if ( !axis_rst_n ) begin
        sm_tvalid_r <= 0;

        ctrl_tap_ready_r <= 0;

        data_EN_sr_r <= 0;
        tap_EN_sr_r <= 0;
    end
    else begin
        if (sm_tready && !sm_tvalid) begin
            case(state)
                ap_idle: begin
                    sm_tvalid_r <= 0;
                end

                ap_start: begin
                    if(ss_read_valid && ctrl_tap_valid) begin
                        sm_tvalid_r <= 0;
                        data_EN_sr_r <= 1;
                        tap_EN_sr_r <= 1;

                        //data_RA_r <= ctrl_data_addr;
                        //tap_RA_sr_r <= ctrl_tap_addr;

                        ctrl_tap_ready_r <= 1;

                    end
                    else if (ss_read_valid && !ctrl_tap_valid && ctrl_tap_ready) begin
                        sm_tvalid_r <= 1;
                        ctrl_tap_ready_r <= 0 ;

                    end
                end

            
            endcase
        end
        else begin
        	if (ss_read_valid && !ctrl_tap_valid && ctrl_tap_ready) begin
                        sm_tvalid_r <= 1;
                        ctrl_tap_ready_r <= 0 ;
                end
            	else sm_tvalid_r <= 0;
        end
    end
end


//caculate fir


//reg ffen_d;

wire  [pDATA_WIDTH-1:0] o_ram_data, o_cof_data;

always@(posedge axis_clk) begin
    //ffen_d <= ffen;

    if(!axis_rst_n)
        sm_tdata_r<=0;
    else if(sm_tvalid)
        sm_tdata_r<=0;
    else if(ffen)
        sm_tdata_r <= sm_tdata_r +(o_ram_data*o_cof_data);

end

//caculate fir


reg [pDATA_WIDTH-1:0] old_ram_data_r, old_cof_data_r;
wire [pDATA_WIDTH-1:0] old_ram_data, old_cof_data;
wire [pDATA_WIDTH-1:0] new_ram_data, new_cof_data;

assign o_ram_data = muxsel ?  old_ram_data : new_ram_data;
assign o_cof_data = muxsel ?  old_cof_data : new_cof_data;
assign old_ram_data = old_ram_data_r;
assign old_cof_data = old_cof_data_r;

assign new_cof_data = tap_Do;
assign new_ram_data = data_Do;

//caculate fir
always@(posedge axis_clk) begin
    if(ffen) begin
        old_ram_data_r <= new_ram_data;
        old_cof_data_r <= new_cof_data;
    end
end





assign ctrl_tap_ready = ctrl_tap_ready_r;

wire [3:0] ctrl_count;

//caculate fir
fir_ctrl#(
        .ADDR_W(pADDR_WIDTH)
    )fir_ctrl_tap (
        .i_clk(axis_clk),
        .i_rst_n(ctrl_rst_n),
        .i_ready(ctrl_tap_ready),
        .o_valid(ctrl_tap_valid),
        .o_data_addr(ctrl_data_addr),
        .o_tap_addr(ctrl_tap_addr),
        .muxsel(muxsel),
        .ffen(ffen),
        .count(ctrl_count)
    );


//AXI4_Lite write
reg awready_r, wready_r;
assign awready = awready_r;
assign wready = wready_r;

//reg [pADDR_WIDTH-1:0] tap_WA_r;
//reg [pDATA_WIDTH-1:0] tap_Di_r;
//assign tap_WE = {4{awready & wready}};
assign tap_WE = (awaddr>=12'h40 && awaddr<=12'h7f)?{4{awvalid & wvalid}}:0;
wire [pADDR_WIDTH-1:0] tap_WA;
//assign tap_WA = tap_WA_r;
assign tap_WA= (awaddr-12'h40);
//assign tap_Di = tap_Di_r;
assign tap_Di = wdata;

reg [pDATA_WIDTH-1:0] data_length;


//AXI4_Lite write
always @( posedge axis_clk ) begin
    if ( !axis_rst_n ) begin
        awready_r <= 0;
        wready_r <= 0;
        ap_start_sig <= 0;
    end
    else begin
        if (!awready && awvalid) begin
        	awready_r <= 1;
            if(awaddr>=12'h40 && awaddr<=12'h7f) 
                awready_r <= 1;
            else if (awaddr==0 && wdata==1)
                awready_r <= 1;
                //tap_WA_r <= awaddr-12'h40;
            //end

            
        end
        else begin
            awready_r <= 0;
        end

        if (!wready && wvalid) begin
            
            if(awaddr>=12'h40 && awaddr<=12'h7f) begin
                //tap_Di_r <= wdata;
                wready_r <= 1;
            end
            else if (awaddr==12'h10)
                data_length <= wdata;
            else if(awaddr==0 && wdata==1)
                ap_start_sig <= 1;

        end
        else begin
            wready_r <= 0;
            if(stream_prepared)
                ap_start_sig <= 0;
        end

    end
end

//AXI4_Lite read
reg arready_r, rvalid_r;

assign arready = arready_r;
assign rvalid = rvalid_r;
reg [pDATA_WIDTH-1:0] rdata_r;
assign rdata = rdata_r ;

wire [pADDR_WIDTH-1:0] tap_RA;
//assign tap_RA = (tap_EN_sr_r) ? tap_RA_sr_r : tap_RA_lr_r;
assign tap_RA = (tap_EN_sr_r) ? tap_RA_sr : tap_RA_lr;
assign tap_EN = {awvalid & wvalid} | tap_EN_r_d ;
always @( posedge axis_clk ) begin
    tap_EN_r_d <= {arvalid & arready} | tap_EN_sr_r;
end
assign tap_A = ({awvalid & wvalid}) ? tap_WA :
       ({arvalid & arready} | tap_EN_sr_r) ? tap_RA : 0;


//AXI4_Lite read

always@(*) begin

    case(state)

        ap_idle: begin
            if(araddr==0 && rvalid)
                rdata_r =32'h04;
            else if(araddr==0 && rvalid && ap_start_sig)
                rdata_r =32'h01;
            else
                rdata_r = tap_Do;


        end

        ap_start: begin
            if(araddr==0 && rvalid)
                rdata_r =32'h00;
            else if(awaddr==12'h10 && rvalid)
                rdata_r = data_length;
            else
                rdata_r = tap_Do;

        end

        ap_done: begin
            if(araddr==0 && rvalid)
                rdata_r =32'h06;
            else
                rdata_r = tap_Do;
        end
        default:
            rdata_r = 0;
    endcase
end

//AXI4_Lite read
always @( posedge axis_clk ) begin
    if ( !axis_rst_n ) begin
        arready_r <= 0;
        rvalid_r <= 0;
    end
    else begin
        if(!arready && arvalid && !rvalid) begin
            if(araddr>=12'h40 && araddr<=12'h7f) begin
                arready_r <= 1;
                //tap_RA_lr_r <= araddr-12'h20;
            end
            else if(araddr==0) begin
                arready_r <= 1;
            end
            else if (awaddr==12'h10)
                arready_r <= 1;
            else
                arready_r <= 0;

        end
        else if(arready && arvalid && !rvalid) begin
            arready_r <= 0;
            rvalid_r <= 1;
        end
        else begin
            arready_r <= 0;
            rvalid_r <= 0;
        end
    end
end
endmodule
