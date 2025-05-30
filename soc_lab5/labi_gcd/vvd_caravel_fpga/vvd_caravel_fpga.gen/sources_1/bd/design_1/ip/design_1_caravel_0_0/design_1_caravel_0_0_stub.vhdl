-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
-- Date        : Wed Nov 22 03:23:17 2023
-- Host        : ubuntu2004 running 64-bit Ubuntu 20.04.4 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/ubuntu/Desktop/labi/vvd_caravel_fpga/vvd_caravel_fpga.gen/sources_1/bd/design_1/ip/design_1_caravel_0_0/design_1_caravel_0_0_stub.vhdl
-- Design      : design_1_caravel_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_caravel_0_0 is
  Port ( 
    gpio : inout STD_LOGIC;
    mprj_i : in STD_LOGIC_VECTOR ( 37 downto 0 );
    mprj_o : out STD_LOGIC_VECTOR ( 37 downto 0 );
    mprj_en : out STD_LOGIC_VECTOR ( 37 downto 0 );
    clock : in STD_LOGIC;
    resetb : in STD_LOGIC;
    flash_csb : out STD_LOGIC;
    flash_clk : out STD_LOGIC;
    flash_io0 : out STD_LOGIC;
    flash_io1 : in STD_LOGIC
  );

end design_1_caravel_0_0;

architecture stub of design_1_caravel_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "gpio,mprj_i[37:0],mprj_o[37:0],mprj_en[37:0],clock,resetb,flash_csb,flash_clk,flash_io0,flash_io1";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "caravel,Vivado 2022.1";
begin
end;
