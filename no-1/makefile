BUILD_DIR=build
SRC_DIR=src

# Source files
SRCS := $(wildcard $(SRC_DIR)/*.s)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.s,$(BUILD_DIR)/%.o,$(SRCS))

# Default target
all: build

# Build executable from assembly files
build: $(BUILD_DIR) $(BUILD_DIR)/http_server

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Assemble to object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.s | $(BUILD_DIR)
	as $< -o $@

# Link everything together
$(BUILD_DIR)/http_server: $(OBJ_FILES)
	gcc $^ -o $@

clean:
	rm -rf $(BUILD_DIR)/*.o $(BUILD_DIR)/http_server

.PHONY: build clean