##Clock signal

# 50 MHz System Clock
set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L12P_T1_MRCC_35 Sch=sysclk
create_clock -add -name sys_clk_pin -period 20.00 -waveform {0 10} [get_ports { clk }];

# 125 MHz System Clock
# set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L12P_T1_MRCC_35 Sch=sysclk
# create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { clk }];

# 50 MHz SSD Clock
# set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { pulse_50Mhz }]; #IO_L12P_T1_MRCC_35 Sch=sysclk
# create_clock -add -name sys_clk_pin -period 20.00 -waveform {0 10} [get_ports { pulse_50Mhz }];



#Switches
set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { sw[0] }]; #IO_L19N_T3_VREF_35 Sch=sw[0]
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { sw[1] }]; #IO_L24P_T3_34 Sch=sw[1]
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { sw[2] }]; #IO_L4N_T0_34 Sch=sw[2]
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { sw[3] }]; #IO_L9P_T1_DQS_34 Sch=sw[3]


#Buttons
set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { btn[0] }]; #IO_L12N_T1_MRCC_35 Sch=btn[0]
set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { btn[1] }]; #IO_L24N_T3_34 Sch=btn[1]
set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports { btn[2] }]; #IO_L10P_T1_AD11P_35 Sch=btn[2]
set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { btn[3] }]; #IO_L7P_T1_34 Sch=btn[3]


#LEDs
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { led[0] }]; #IO_L23P_T3_35 Sch=led[0]
set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports { led[1] }]; #IO_L23N_T3_35 Sch=led[1]
set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33 } [get_ports { led[2] }]; #IO_0_35 Sch=led[2]
set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { led[3] }]; #IO_L3N_T0_DQS_AD1N_35 Sch=led[3]

#RGB LED 6
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { rgb[0] }]; #IO_L18P_T2_34 Sch=led6_r
set_property -dict { PACKAGE_PIN F17   IOSTANDARD LVCMOS33 } [get_ports { rgb[1] }]; #IO_L6N_T0_VREF_35 Sch=led6_g
set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { rgb[2] }]; #IO_L8P_T1_AD10P_35 Sch=led6_b

    # 3 2 1 0
##Pmod Header JA (XADC) # 1 1 1 1 (col)
set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { col[0] }]; # Col4 - IO_L21P_T3_DQS_AD14P_35 Sch=JA1_R_p		   
set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { col[1] }]; # Col3 - IO_L22P_T3_AD7P_35 Sch=JA2_R_P 
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { col[2] }]; # Col2 - IO_L24P_T3_AD15P_35 Sch=JA3_R_P    
set_property -dict { PACKAGE_PIN K14   IOSTANDARD LVCMOS33 } [get_ports { col[3] }]; # Col1 - IO_L20P_T3_AD6P_35 Sch=JA4_R_P 
set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { row[0] }]; # Row4 - IO_L21N_T3_DQS_AD14N_35 Sch=JA1_R_N    
set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS33 } [get_ports { row[1] }]; # Row3 - IO_L22N_T3_AD7N_35 Sch=JA2_R_N 
set_property -dict { PACKAGE_PIN J16   IOSTANDARD LVCMOS33 } [get_ports { row[2] }]; # Row2 - IO_L24N_T3_AD15N_35 Sch=JA3_R_N    
set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { row[3] }]; # Row1 - IO_L20N_T3_AD6N_35 Sch=JA4_R_N    

##Pmod Header JC  
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { seg0[6] }]; #IO_L10P_T1_34 Sch=jc_p[1]   			 
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports { seg0[5] }]; #IO_L10N_T1_34 Sch=jc_n[1]		 
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { seg0[4] }]; #IO_L1P_T0_34 Sch=jc_p[2]  
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { seg0[3] }]; #IO_L1N_T0_34 Sch=jc_n[2] 

# set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports { seg0[2] }]; #IO_L8P_T1_34 Sch=jc_p[3]  
# set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS33 } [get_ports { seg0[1] }]; #IO_L8N_T1_34 Sch=jc_n[3]  
# set_property -dict { PACKAGE_PIN T12   IOSTANDARD LVCMOS33 } [get_ports { seg0[0] }]; #IO_L2P_T0_34 Sch=jc_p[4]  
# set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { chip_sel0 }]; #IO_L2N_T0_34 Sch=jc_n[4]  
 
# ##Pmod Header JD  
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { seg0[2] }]; #IO_L5P_T0_34 Sch=jd_p[1]  
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33 } [get_ports { seg0[1] }]; #IO_L5N_T0_34 Sch=jd_n[1]				 
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { seg0[0] }]; #IO_L6P_T0_34 Sch=jd_p[2]  
set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33 } [get_ports { chip_sel0 }]; #IO_L6N_T0_VREF_34 Sch=jd_n[2]  

# set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { seg1[2] }]; #IO_L11P_T1_SRCC_34 Sch=jd_p[3]    
# set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports { seg1[1] }]; #IO_L11N_T1_SRCC_34 Sch=jd_n[3]    
# set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { seg1[0] }]; #IO_L21P_T3_DQS_34 Sch=jd_p[4] 
# set_property -dict { PACKAGE_PIN V18   IOSTANDARD LVCMOS33 } [get_ports { chip_sel1 }]; #IO_L21N_T3_DQS_34 Sch=jd_n[4] 

##Pmod Header JE                                                                                                                  
#set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { je[0] }]; #IO_L4P_T0_34 Sch=je[1]						 
#set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { je[1] }]; #IO_L18N_T2_34 Sch=je[2]                     
#set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { je[2] }]; #IO_25_35 Sch=je[3]                          
set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { servo }]; #IO_L19P_T3_35 Sch=je[4]                     
#set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { je[4] }]; #IO_L3N_T0_DQS_34 Sch=je[7]                  
#set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { je[5] }]; #IO_L9N_T1_DQS_34 Sch=je[8]                  
#set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { je[6] }]; #IO_L20P_T3_34 Sch=je[9]                     
#set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { je[7] }]; #IO_L7N_T1_34 Sch=je[10]                    