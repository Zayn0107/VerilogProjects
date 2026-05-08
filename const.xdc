## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

# LEDs
set_property PACKAGE_PIN U16 [get_ports led_5mhz]					

set_property PACKAGE_PIN E19 [get_ports led_50mhz]					

set_property PACKAGE_PIN U19 [get_ports led_100mhz]	
				
set_property IOSTANDARD LVCMOS33 [get_ports LED]
##Buttons
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports rst]

# Switches
set_property PACKAGE_PIN V17 [get_ports SW0]					
	set_property IOSTANDARD LVCMOS33 [get_ports SW0]
set_property PACKAGE_PIN V16 [get_ports SW1]					
	set_property IOSTANDARD LVCMOS33 [get_ports SW1]

## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## SPI configuration mode options for QSPI boot, can be used for all designs
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]