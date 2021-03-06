############################################
# Makefile for SMS Z80 Sample
# Date: November 22, 2020
# Author: Jacques Belosoukinski <kentosama>
# Github: https://github.com/kentosama
############################################

# Recursive wildcard
rwildcard = $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))

ASM=wla-z80
ASFLAGS= -o
LD=wlalink
LDFLAGS = -v -r
OUT_DIR=out
CPUS?=$(shell nproc)
MAKEFLAGS:=--jobs=$(CPUS)

SRC_DIR:=src
SRC:=$(wildcard $(SRC_DIR)/*.asm)
SRC_EXTRA_C:= $(wildcard $(SRC_DIR)/**/*.asm)
SRC+= $(SRC_EXTRA_C)

OBJ:=$(SRC:.asm=.rel)
OBJS:=$(addprefix $(OUT_DIR)/, $(OBJ))

BIN=rom.sms
EMULATOR=meka

release: $(OUT_DIR)/$(BIN)

all: release

.PHONY: clean

run: release
	$(EMULATOR) $(OUT_DIR)/$(BIN)

clean:
	@rm -rf $(OUT_DIR)/*
	
$(OUT_DIR)/$(BIN): $(OBJS)
	@mkdir -p $(OUT_DIR)
	@echo -e '[objects]' > $(OUT_DIR)/tmp
	@echo -e $(OBJS) >> $(OUT_DIR)/tmp
	$(LD) $(LDFLAGS) $(OUT_DIR)/tmp $(OUT_DIR)/$(BIN)
	@rm -rf $(OUT_DIR)/tmp
	
$(OUT_DIR)/%.rel: %.asm
	@mkdir -p $(@D)
	$(ASM) $(ASFLAGS) $@ $^
