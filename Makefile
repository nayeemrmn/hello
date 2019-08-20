# Tools
AR      = ar
ARFLAGS = crs
CC      = gcc
CFLAGS  = -Iinclude

# Files and directories
SRC       = src
TARGET    = target
LIB_FILE  = $(TARGET)/libhello.a
SRC_FILES = $(shell find $(SRC) -name "*.c" -type f)
OBJ_FILES = $(SRC_FILES:$(SRC)/%.c=$(TARGET)/%.o)
DEP_FILES = $(SRC_FILES:$(SRC)/%.c=$(TARGET)/%.d)

.PHONY: all clean

all: $(LIB_FILE)

$(LIB_FILE): $(OBJ_FILES)
	$(AR) $(ARFLAGS) $@ $^

$(OBJ_FILES): $(TARGET)/%.o: $(SRC)/%.c
	@mkdir -p $(shell dirname $@)
	$(CC) $(CFLAGS) -c -o $@ $<

$(DEP_FILES): $(TARGET)/%.d: $(SRC)/%.c
	@mkdir -p $(shell dirname $@)
	$(CC) $(CFLAGS) -MM -MT $(TARGET)/$*.o -o $@ $<

clean:
	rm -rf $(TARGET)

-include $(DEP_FILES)
