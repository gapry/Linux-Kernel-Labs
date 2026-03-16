# Setup

## Linux Kernel
```
$ cd ~/Downloads/ 
$ curl -O https://git.kernel.org/torvalds/t/linux-7.0-rc4.tar.gz
$ curl -O https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.19.8.tar.xz
$ cd ~/Workspaces/ 
$ git clone git@github.com:gapry/Linux-Kernel.git
$ cd Linux-kernel
$ git checkout --orphan temp_main
$ git commit --allow-empty -m "Initial commit"
$ git push origin temp_main:main
$ git checkout -b init 
$ git checkout -b v6.19.8 
$ tar -xvf ~/Downloads/linux-6.19.8.tar.xz -C . --strip-components=1
$ git add .
$ git commit -S -m "import: v6.19.8"
$ git checkout init
$ git checkout -b v7.0-rc4 
$ tar -xvf ~/Downloads/linux-7.0-rc4.tar.gz -C . --strip-components=1
$ git add .
$ git commit -S -m "import: v7.0-rc4"
$ git checkout main
$ git merge v7.0-rc4
$ git push --all
```

## Buildroot
```
$ cd ~/Downloads/ 
$ curl -O https://gitlab.com/buildroot.org/buildroot/-/archive/2026.02.x/buildroot-2026.02.x.tar.gz
$ cd ~/Workspaces/
$ git clone git@github.com:gapry/buildroot.git
$ cd buildroot/
$ git checkout --orphan temp_main
$ git commit --allow-empty -m "Initial commit"
$ git push origin temp_main:main
$ git checkout -b init
$ git checkout -b v2026.02.x
$ tar -xvf ~/Downloads/buildroot-2026.02.x.tar.gz -C . --strip-components=1
$ git add .
$ git commit -S -m "import: 2026.02.x"
$ git checkout main
$ git merge v2026.02.x
$ git push --all
```

## Linux Kernel Labs
```
$ cd ~/Workspaces/
$ git clone git@github.com:gapry/Linux-Kernel-Labs.git
$ cd Linux-Kernel-Labs
$ git submodule add git@github.com:gapry/Linux-Kernel.git kernel
$ git add .
$ git commit -S -m "submodule: add linux kernel"
$ git submodule add git@github.com:gapry/buildroot.git buildroot
$ git add .
$ git commit -S -m "submodule: add buildroot"
$ git submodule update --init --recursive
$ git submodule sync 
$ cd kernel/
$ git remote add -t v6.19.8 upstream git@github.com:gapry/Linux-Kernel.git
$ git fetch upstream
$ git checkout -b v6.19.8
$ git checkout -b v6.19.8-syscall
$ nvim include/linux/syscalls.h
$ nvim arch/x86/entry/syscalls/syscall_64.tbl
$ nvim kernel/Makefile
$ git add .
$ git commit -S -m "kernel: add my_syscall"
$ git push origin v6.19.8-syscall
$ cd ..
$ git add kernel
$ git commit -S -m "[submodule][kernel] checkout to v6.19.8-syscall"
$ git push origin master
$ cd ..
$ ls 
buildroot/ kernel/ README.md
$ mkdir -p app/syscall
$ nvim app/syscall/main.c 
$ nvim Makefile
```

## Buildroot
```
$ cd ~/Workspaces/Linux-Kernel-Labs
$ ls 
app/ buildroot/ kernel/ Makefile README.md
$ cd buildroot/
$ make qemu_x86_64_defconfig
$ echo 'LINUX_OVERRIDE_SRCDIR = $(TOPDIR)/../kernel' > local.mk
$ make menuconfig
System configuration -> Root filesystem overlay directories -> rootfs/usr/bin
Toolchain -> Kernel Headers -> 6.19.x
$ make
$ ls -lh output/images/
Permissions Size User  Date Modified Name
.rw-r--r--  6.7M gapry 16 Mar 22:16  bzImage
.rw-r--r--   63M gapry 16 Mar 22:16  rootfs.ext2
.rwxr-xr-x   773 gapry 16 Mar 22:16  start-qemu.sh
$ cd ..
$ make build 
$ cd buildroot
$ make target-finalize
$ make
$ cd ..
$ make qemu
Welcome to Buildroot
buildroot login:
# cd /
# ./test_syscall.out
[custom syscall] 471...
[my_syscall] Hello World!!!.
[success] syscall 471 executed.
[kernel log (dmesg)] = '[my_syscall] Hello World!!!.
# dmesg | tail -n 1
[my_syscall] Hello World!!!.
```
