CC = ./buildroot/output/host/bin/x86_64-linux-gcc
BUILD_DIR = build

build:
	mkdir -p $(BUILD_DIR)
	$(CC) app/syscall/main.c -o $(BUILD_DIR)/app.out

clean:
	rm -rf $(BUILD_DIR)
