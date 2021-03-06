# Copyright (C) 2018  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel FPGA IP License Agreement, or other applicable license
# agreement, including, without limitation, that your use is for
# the sole purpose of programming logic devices manufactured by
# Intel and sold by Intel or its authorized distributors.  Please
# refer to the applicable agreement for further details.

# Quartus Prime: Generate Tcl File for Project
# File: MU0CPUFINAL.tcl
# Generated on: Wed Feb 26 12:17:41 2020

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "MU0CPUFINAL"]} {
		puts "Project MU0CPUFINAL is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists MU0CPUFINAL]} {
		project_open -revision MU0CPUFINAL MU0CPUFINAL
	} else {
		project_new -revision MU0CPUFINAL MU0CPUFINAL
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone V"
	set_global_assignment -name DEVICE 5CGXFC7C7F23C8
	set_global_assignment -name TOP_LEVEL_ENTITY MU0CPU
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 18.1.0
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "15:20:21  JANUARY 27, 2020"
	set_global_assignment -name LAST_QUARTUS_VERSION "18.1.0 Standard Edition"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
	set_global_assignment -name EDA_SIMULATION_TOOL "ModelSim-Altera (Verilog)"
	set_global_assignment -name EDA_TIME_SCALE "1 ps" -section_id eda_simulation
	set_global_assignment -name EDA_OUTPUT_DATA_FORMAT "VERILOG HDL" -section_id eda_simulation
	set_global_assignment -name VERILOG_FILE cpu_statemachine.v
	set_global_assignment -name BDF_FILE MU0CPU.bdf
	set_global_assignment -name QIP_FILE ram.qip
	set_global_assignment -name VERILOG_FILE cpu_decoder.v
	set_global_assignment -name BDF_FILE 3_bit_register.bdf
	set_global_assignment -name MIF_FILE MU0CPUFINAL.mif
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform1.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform3.vwf
	set_global_assignment -name QIP_FILE constant.qip
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform4.vwf
	set_global_assignment -name QIP_FILE ram111.qip
	set_global_assignment -name MIF_FILE Mif1.mif
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform5.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform8.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform9.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform10.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform11.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform12.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform13.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform14.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform15.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform16.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform6.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform7.vwf
	set_global_assignment -name BDF_FILE "statemachine-isolated-test.bdf"
	set_global_assignment -name VECTOR_WAVEFORM_FILE isolatedSM.vwf
	set_global_assignment -name BDF_FILE MU0CPUFINAL.bdf
	set_global_assignment -name BDF_FILE statemachineisolatedtest.bdf
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform17.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform18.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform19.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform20.vwf
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform2.vwf
	set_global_assignment -name VERILOG_FILE DECODER_CHECK.v
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
