# BK7258 + OV6946 Camera Streaming Project Makefile
# Author: Project Development Team
# Date: September 2024

# Project Configuration
PROJECT_NAME = bk7258_camera_streaming
TARGET = $(PROJECT_NAME)

# Directories
SRC_DIR = src
INC_DIR = include
BUILD_DIR = build
LIBS_DIR = libs
OUTPUT_DIR = output

# Beken Armino SDK Configuration (Update path when SDK is installed)
ARMINO_SDK_PATH ?= $(LIBS_DIR)/armino_sdk
SDK_CONFIG_PATH = $(ARMINO_SDK_PATH)/middleware/soc/bk7258

# Toolchain Configuration  
CROSS_COMPILE = arm-none-eabi-
CC = $(CROSS_COMPILE)gcc
CXX = $(CROSS_COMPILE)g++
AS = $(CROSS_COMPILE)as
LD = $(CROSS_COMPILE)ld
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump
SIZE = $(CROSS_COMPILE)size
GDB = $(CROSS_COMPILE)gdb

# MCU Configuration
MCU = cortex-m33
ARCH = armv8-m.main
FPU = fpv5-sp-d16

# Compiler Flags
CFLAGS = -mcpu=$(MCU) -mthumb -march=$(ARCH) -mfpu=$(FPU) -mfloat-abi=hard
CFLAGS += -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers
CFLAGS += -fdata-sections -ffunction-sections -fno-strict-aliasing
CFLAGS += -fno-builtin -fshort-enums -MMD -MP
CFLAGS += -std=c11 -O2 -g3

# Preprocessor Defines
DEFINES = -DBUILD_VERSION=\"$(shell git describe --always --dirty)\"
DEFINES += -DBUILD_DATE=\"$(shell date +'%Y-%m-%d %H:%M:%S')\"
DEFINES += -DBK7258 -DCONFIG_SOC_BK7258 -DARM_MATH_CM33
DEFINES += -D__FPU_PRESENT=1U -DCONFIG_FREERTOS
DEFINES += -DCONFIG_LWIP -DCONFIG_WIFI_ENABLE -DCONFIG_CAMERA_OV6946

# Include Directories
INCLUDES = -I$(INC_DIR)
INCLUDES += -I$(SRC_DIR)
INCLUDES += -I$(SRC_DIR)/camera
INCLUDES += -I$(SRC_DIR)/streaming
INCLUDES += -I$(SRC_DIR)/wifi
# Add SDK includes when available
# INCLUDES += -I$(ARMINO_SDK_PATH)/include
# INCLUDES += -I$(SDK_CONFIG_PATH)/include

# Source Files
SOURCES = $(wildcard $(SRC_DIR)/*.c)
SOURCES += $(wildcard $(SRC_DIR)/camera/*.c)
SOURCES += $(wildcard $(SRC_DIR)/streaming/*.c)
SOURCES += $(wildcard $(SRC_DIR)/wifi/*.c)

# Object Files
OBJECTS = $(SOURCES:%.c=$(BUILD_DIR)/%.o)
DEPS = $(OBJECTS:.o=.d)

# Linker Configuration
LDFLAGS = -mcpu=$(MCU) -mthumb -march=$(ARCH) -mfpu=$(FPU) -mfloat-abi=hard
LDFLAGS += -specs=nano.specs -specs=nosys.specs
LDFLAGS += -Wl,--gc-sections,--relax
LDFLAGS += -Wl,--print-memory-usage
LDFLAGS += -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref

# Linker Script (will be provided by SDK)
LDSCRIPT = $(LIBS_DIR)/bk7258_linker_script.ld

# Flash Tool Configuration (Update when available)
FLASH_TOOL = bkwriter_cli
FLASH_PORT = /dev/cu.usbserial-*
FLASH_BAUDRATE = 2000000

# Default target
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin size

# Create build directory
$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)/$(SRC_DIR)
	@mkdir -p $(BUILD_DIR)/$(SRC_DIR)/camera
	@mkdir -p $(BUILD_DIR)/$(SRC_DIR)/streaming  
	@mkdir -p $(BUILD_DIR)/$(SRC_DIR)/wifi
	@mkdir -p $(OUTPUT_DIR)

# Compile source files
$(BUILD_DIR)/%.o: %.c | $(BUILD_DIR)
	@echo "CC $<"
	@$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -c $< -o $@

# Link executable
$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS)
	@echo "LD $@"
	@$(CC) $(OBJECTS) $(LDFLAGS) -T$(LDSCRIPT) -o $@

# Generate hex file
$(BUILD_DIR)/$(TARGET).hex: $(BUILD_DIR)/$(TARGET).elf
	@echo "OBJCOPY $@"
	@$(OBJCOPY) -O ihex $< $@
	@cp $@ $(OUTPUT_DIR)/

# Generate binary file
$(BUILD_DIR)/$(TARGET).bin: $(BUILD_DIR)/$(TARGET).elf
	@echo "OBJCOPY $@"
	@$(OBJCOPY) -O binary $< $@
	@cp $@ $(OUTPUT_DIR)/

# Show size information
size: $(BUILD_DIR)/$(TARGET).elf
	@echo "Size information:"
	@$(SIZE) $<

# Generate assembly listing
$(BUILD_DIR)/$(TARGET).lst: $(BUILD_DIR)/$(TARGET).elf
	@echo "OBJDUMP $@"
	@$(OBJDUMP) -h -S $< > $@

# Flash firmware to device
flash: $(BUILD_DIR)/$(TARGET).bin
	@echo "Flashing firmware to BK7258..."
	@$(FLASH_TOOL) -p $(FLASH_PORT) -b $(FLASH_BAUDRATE) -w $<

# Debug with J-Link GDB
debug: $(BUILD_DIR)/$(TARGET).elf
	@echo "Starting GDB debug session..."
	@$(GDB) $< -ex "target remote localhost:2331"

# Clean build files
clean:
	@echo "Cleaning build files..."
	@rm -rf $(BUILD_DIR)
	@rm -rf $(OUTPUT_DIR)

# Clean all generated files
distclean: clean
	@echo "Cleaning all generated files..."
	@find . -name "*.orig" -delete
	@find . -name "*~" -delete

# Install SDK (placeholder - update with actual SDK installation)
install-sdk:
	@echo "Installing Beken Armino SDK..."
	@echo "Please download SDK from https://docs.bekencorp.com/"
	@echo "Extract to $(LIBS_DIR)/armino_sdk/"

# Project information
info:
	@echo "Project: $(PROJECT_NAME)"
	@echo "Target: $(TARGET)"
	@echo "MCU: $(MCU)"
	@echo "Toolchain: $(CROSS_COMPILE)"
	@echo "SDK Path: $(ARMINO_SDK_PATH)"
	@echo "Build Dir: $(BUILD_DIR)"
	@echo "Sources: $(words $(SOURCES)) files"

# Help
help:
	@echo "BK7258 Camera Streaming Project Build System"
	@echo ""
	@echo "Available targets:"
	@echo "  all         - Build firmware (default)"
	@echo "  clean       - Remove build files"
	@echo "  distclean   - Remove all generated files"
	@echo "  flash       - Flash firmware to device"
	@echo "  debug       - Start GDB debug session"
	@echo "  size        - Show memory usage"
	@echo "  install-sdk - Install Beken SDK"
	@echo "  info        - Show project information"
	@echo "  help        - Show this help"
	@echo ""
	@echo "Environment variables:"
	@echo "  ARMINO_SDK_PATH - Path to Beken Armino SDK"
	@echo "  FLASH_PORT      - Serial port for flashing"

# Include dependency files
-include $(DEPS)

# Phony targets
.PHONY: all clean distclean flash debug size install-sdk info help