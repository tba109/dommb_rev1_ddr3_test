////////////////////////////////////////////////////////////////////////////////////////
// Tyler Anderson Wed Feb 15 14:13:23 EST 2017
// Trying to get the NIOS2 to work with a memory controller.
////////////////////////////////////////////////////////////////////////////////////////

module qsys_nios2_ddr3_top
  (
   input 	 OSC_TCXO_20M_FPGA,
   output [13:0] DDR3_A,
   output [2:0]  DDR3_BA,
   output 	 DDR3_CAS_n,
   output 	 DDR3_CKE,
   output 	 DDR3_CK_n,
   output 	 DDR3_CK_p,
   output 	 DDR3_CS_n,
   output [1:0]  DDR3_DM,
   inout [15:0]  DDR3_DQ,
   inout [1:0] 	 DDR3_DQS_n,
   inout [1:0] 	 DDR3_DQS_p,
   output 	 DDR3_ODT,
   output 	 DDR3_RAS_n,
   output 	 DDR3_RESET_n,
   input 	 DDR3_RZQ, 
   output 	 DDR3_WE_n
   );

   wire 	 rclk;
   ALTCLKCTRL ALTCLKCTRL_0
     (
      .inclk(OSC_TCXO_20M_FPGA),
      .outclk(rclk)
      );

   reg 		 pll_locked /*synthesis noprune*/;
   reg 		 init_done /*synthesis noprune*/;
   reg 		 cal_success /*synthesis noprune*/;
   reg 		 cal_fail /*synthesis noprune*/;


   reg 		 reset_n;
   reg [3:0] 	 cnt;
   always @ (posedge rclk)
         if(cnt<10) begin
	    reset_n  <=0;
	    cnt     <=cnt+1;
	 end else
	   reset_n  <=1;
   
   qsys_nios2_ddr3 u0
     (
      .clk_clk(rclk),
      .reset_reset_n(reset_n),
      .memory_mem_a       (DDR3_A),       // memory.mem_a
      .memory_mem_ba      (DDR3_BA),      //       .mem_ba
      .memory_mem_ck      (DDR3_CK_p),      //       .mem_ck
      .memory_mem_ck_n    (DDR3_CK_n),    //       .mem_ck_n
      .memory_mem_cke     (DDR3_CKE),     //       .mem_cke
      .memory_mem_cs_n    (DDR3_CS_n),    //       .mem_cs_n
      .memory_mem_dm      (DDR3_DM),      //       .mem_dm
      .memory_mem_ras_n   (DDR3_RAS_n),   //       .mem_ras_n
      .memory_mem_cas_n   (DDR3_CAS_n),   //       .mem_cas_n
      .memory_mem_we_n    (DDR3_WE_n),    //       .mem_we_n
      .memory_mem_reset_n (DDR3_RESET_n), //       .mem_reset_n
      .memory_mem_dq      (DDR3_DQ),      //       .mem_dq
      .memory_mem_dqs     (DDR3_DQS_p),     //       .mem_dqs
      .memory_mem_dqs_n   (DDR3_DQS_n),   //       .mem_dqs_n
      .memory_mem_odt     (DDR3_ODT),     //       .mem_odt
      .mem_if_ddr3_emif_0_status_local_init_done(init_done),
      .mem_if_ddr3_emif_0_status_local_cal_success(cal_success),
      .mem_if_ddr3_emif_0_status_local_cal_fail(cal_fail),
      .oct_rzqin(DDR3_RZQ)
      // .mem_if_ddr3_emif_0_pll_sharing_pll_mem_clk(),
      // .mem_if_ddr3_emif_0_pll_sharing_pll_write_clk(),
      // .mem_if_ddr3_emif_0_pll_sharing_pll_locked(),
      // .mem_if_ddr3_emif_0_pll_sharing_pll_write_clk_pre_phy_clk(),
      // .mem_if_ddr3_emif_0_pll_sharing_pll_addr_cmd_clk(),
      // .mem_if_ddr3_emif_0_pll_sharing_pll_avl_clk(),
      // .mem_if_ddr3_emif_0_pll_sharing_pll_config_clk(),
      // .mem_if_ddr3_emif_0_pll_sharing_pll_dr_clk(),
      // .mem_if_ddr3_emif_0_pll_sharing_pll_dr_clk_pre_phy_clk(),
      // .mem_if_ddr3_emif_0_pll_sharing_pll_mem_phy_clk(),
      // .mem_if_ddr3_emif_0_pll_sharing_afi_phy_clk(),
      // .mem_if_ddr3_emif_0_pll_sharing_pll_avl_phy_clk(),
      // .pll_0_locked_export(pll_locked)
      );
   
endmodule
