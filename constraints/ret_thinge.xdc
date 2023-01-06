set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN D9 } [get_ports { FP_SC_RX_3V3 } ]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN D13 } [get_ports { FP_SC_TX } ]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN B14 } [get_ports { SC_RX }]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN A13 } [get_ports { SC_TX }]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN C9 } [get_ports { RCVA_12_EN }]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN E13 } [get_ports { DRA_12_EN }]

set_property -dict { IOSTANDARD LVDS_25 PACKAGE_PIN T3 DIFF_TERM "TRUE" } [get_ports {RXD0_P}]
set_property -dict { IOSTANDARD LVDS_25 PACKAGE_PIN T4 DIFF_TERM "TRUE" } [get_ports {RXD0_N}]
set_property -dict { IOSTANDARD LVDS_25 PACKAGE_PIN V6 DIFF_TERM "TRUE" } [get_ports {RXD1_P}]
set_property -dict { IOSTANDARD LVDS_25 PACKAGE_PIN U7 DIFF_TERM "TRUE" } [get_ports {RXD1_N}]

set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN P15 } [get_ports { PPSTXD0 } ]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN R16 } [get_ports { PPSTXD1 } ]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN P14 } [get_ports { DRV_PANELS } ]

set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN U14 } [get_ports { P1_RX }]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN V14 } [get_ports { P1_TX }]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN L14 } [get_ports { P0_RX }]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN U10 } [get_ports { P0_TX }]

create_clock -period 40.000 -name clk25 [get_ports -filter { NAME =~ "CLK25M" }]
