BUILD_DIR := build
SRC_DIR := src

EXECUTABLE := $(BUILD_DIR)/http_server

SRCS := $(wildcard $(SRC_DIR)/*.s)

OBJS := $(patsubst $(SRC_DIR)/%.s, $(BUILD_DIR)/%.o, $(SRCS))

.PHONY: all
all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJS)
	@echo "Linking..."
	gcc $(OBJS) -o $(EXECUTABLE)
	@echo "Build complete: $(EXECUTABLE)"

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.s | $(BUILD_DIR)
	@echo "Assembling $< -> $@"
	as $< -o $@

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

.PHONY: clean
clean:
	@echo "Cleaning up..."
	rm -rf $(BUILD_DIR)