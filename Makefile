CXX = g++
#CXX = xcpp
XCXX = v++
VIVADO = vivado
EMCONFIGUTIL = emconfigutil
RUNDIR=$(PWD)
RM = rm -f
CPY = cp -prvf
TARGET = hw
PLATFORM = /proj/xbuilds/2019.2_daily_latest/internal_platforms/xilinx_u280_xdma_201920_1/xilinx_u280_xdma_201920_1.xpfm 

# Kernel definitions
KERNEL_1 = loopback
KERNEL_1_XO = rtl/$(KERNEL_1).xo
KERNEL_1_SRC = rtl/$(KERNEL_1).cpp

KERNEL_2 = label_filter
KERNEL_2_XO = $(KERNEL_2).xo
KERNEL_2_SRC = src/$(KERNEL_2).cpp

KERNEL_3 = property_read
KERNEL_3_XO = $(KERNEL_3).xo
KERNEL_3_SRC = src/$(KERNEL_3).cpp

KERNEL_4 = aggregate
KERNEL_4_XO = $(KERNEL_4).xo
KERNEL_4_SRC = src/$(KERNEL_4).cpp

# xclbin definitions
XCLBIN_1 = kernel.xclbin
XCLBIN_1_XOS = $(KERNEL_1_XO) $(KERNEL_2_XO) $(KERNEL_3_XO) $(KERNEL_4_XO) 
XCLBIN_1_LINK_OPTS = --config vpp.ini

# Kernel compiler settings
XCXX_COMMON_OPTS = -s  --jobs 8 --remote_ip_cache /proj/fis/results/2019.2/SDX_GLOBAL_CACHE_FOR_SPRITE/2019.2_latest --log_dir vpp_log --report_dir reports  -t $(TARGET) --platform $(PLATFORM) -I .

# Host settings
TARGET_FLAGS = -DTARGET_FLOW_HW=1 -DTARGET_FLOW_HW_EMU=0 -DTARGET_FLOW_SW_EMU=0
HOST_CFLAGS =  -I./ -DDSA64 
HOST_CFLAGS += $(TARGET_FLAGS) -DTARGET_DEVICE=\"$(DEVICE)\"
HOST_CFLAGS += -O0 -g -Wall -fmessage-length=0 -std=c++14 -I${GITHUB_COMMON_REPO}/libs/xcl2 -lxilinxopencl -lpthread -lrt -lstdc++ -I${XILINX_XRT}/include -L${XILINX_XRT}/lib -I${XILINX_SCOUT}/lnx64/tools/opencv -I${XILINX_SCOUT}/include -L${XILINX_SCOUT}/lib/lnx64.o

# Host files
HOST_PREAMBLE = 
HOST_EXE = host.exe
HOST_SRC = host.cpp
HOST_ARGS = $(XCLBIN_1)
# Set up the emconfigutil run
EMCONFIG_FILE = emconfig.json

NUM_DEVICES = 1

# Primary build targets
.PHONY: all build host run clean cleanall help

all: clean build run

build: $(XCLBIN_1) 

run: build host
ifeq ($(TARGET),$(filter $(TARGET),sw_emu hw_emu))
	export XCL_EMULATION_MODE=$(TARGET)
	$(EMCONFIGUTIL) --platform $(PLATFORM) --nd $(NUM_DEVICES)
	@echo "Running Emulation: $(HOST_PREAMBLE) ./$(HOST_EXE) $(HOST_ARGS)"
	$(HOST_PREAMBLE) ./$(HOST_EXE) $(HOST_ARGS)
else ifeq ($(TARGET),$(filter $(TARGET),hw))
	@echo "Running HW Test: $(HOST_PREAMBLE) ./$(HOST_EXE) $(HOST_ARGS)"
	$(HOST_PREAMBLE) ./$(HOST_EXE) $(HOST_ARGS)
endif

# Kernel rules
$(KERNEL_1_XO): $(KERNEL_1_SRC)
	$(RM) $@
	$(VIVADO) -mode batch -source gen_xo.tcl
$(KERNEL_2_XO): $(KERNEL_2_SRC)
	$(RM) $@
	$(XCXX) $(XCXX_COMMON_OPTS) -c -o $@ $+ -k $(KERNEL_2)
$(KERNEL_3_XO): $(KERNEL_3_SRC)
	$(RM) $@
	$(XCXX) $(XCXX_COMMON_OPTS) -c -o $@ $+ -k $(KERNEL_3)
$(KERNEL_4_XO): $(KERNEL_4_SRC)
	$(RM) $@
	$(XCXX) $(XCXX_COMMON_OPTS) -c -o $@ $+ -k $(KERNEL_4)
# xclbin rules
$(XCLBIN_1): $(XCLBIN_1_XOS)
	$(RM) $@
	$(XCXX) $(XCXX_COMMON_OPTS) -l -o $@ $+  --profile_kernel data:all:all:all $(XCLBIN_1_LINK_OPTS)

# Host rules
host: $(HOST_SRC)
	$(CXX) $+ $(HOST_CFLAGS) -o $(HOST_EXE)
	@echo "INFO: Compiled Host Executable: $(HOST_EXE)"

clean:
	$(RM) $(EMCONFIG_FILE) $(HOST_EXE)
	$(RM) *.log

cleanall: clean
	$(RM) $(XCLBIN_1)
	$(RM) $(KERNEL_1_XO) 
	$(RM) $(KERNEL_2_XO) 
	$(RM) $(KERNEL_3_XO) 
	$(RM) $(KERNEL_4_XO) 

help:
	 @echo 'Makefile usage:'
	 @echo '  make all TARGET=<sw_emu/hw_emu/hw> PLATFORM=<FPGA platform>'
	 @echo '      Clean the environment, build host, build xclbin and run the application.'
	 @echo ''
	 @echo '  make run TARGET=<sw_emu/hw_emu/hw> PLATFORM=<FPGA platform>'
	 @echo '      Build host, build xclbin and run the application.'
	 @echo ''
	 @echo '  make build TARGET=<sw_emu/hw_emu/hw> PLATFORM=<FPGA platform>'
	 @echo '      Build xclbin.'
	 @echo ''
	 @echo '  make host'
	 @echo '      Build host executable.'
	 @echo ''
	 @echo '  make clean '
	 @echo '      Remove the host executable and emconfig file.'
	 @echo ''
	 @echo '  make cleanall'
	 @echo '      Remove all, keep only the sources.'

