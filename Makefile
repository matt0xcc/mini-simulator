BIN = semu

BUILD_DIR = ./build
SRC_DIRS = ./src

# find all c files and header files
SRCS = $(shell find $(SRC_DIRS) -name '*.c')

# string substitution for object files
# % match files in SRC, and turn each one into ./build/*.c.o, % is *.c
OBJS = $(SRCS:%=$(BUILD_DIR)/%.o)

# include source directories so that *.h file can be found 
INC_DIRS = $(shell find $(SRC_DIRS) -type d)
# add prefix '-I' to INC_DIRS
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

# Compilation Settings

CC = gcc
# C compiler flags
CCFLAGS = $(INC_FLAGS) -MMD -MP
CFLAGS = -Wall -Werror -std=c11 -O2 -g
LD = gcc
LDFLAGS = 


$(BUILD_DIR)/$(BIN): $(OBJS)
	$(LD) $(OBJS) -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.c.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CCFLAGS) $(CFLAGS) -c $< -o $@

.PHONY: clean test
clean:
	rm -rf $(BUILD_DIR)

test:
	$(CC) $(CFLAGS) -o $(SRC_DIR)/test $(SRC_DIR)idex.o $(SRC_DIR)/test.c && ./$(SRC_DIR)/test


$(info "It seems everything goes on well ~")
