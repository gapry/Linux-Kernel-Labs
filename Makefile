CC = ./buildroot/output/host/bin/x86_64-linux-gcc
BUILD_DIR = build
OVERLAY_DIR = buildroot/rootfs/usr/bin

build:
	mkdir -p $(BUILD_DIR)
	$(CC) app/syscall/main.c -o $(BUILD_DIR)/app.out
	mkdir -p $(OVERLAY_DIR)
	cp $(BUILD_DIR)/app.out $(OVERLAY_DIR)/test_syscall.out
	chmod a+x $(OVERLAY_DIR)/test_syscall.out

qemu:
	sh ./buildroot/output/images/start-qemu.sh

clean:
	rm -rf $(BUILD_DIR)
