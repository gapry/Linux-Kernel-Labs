#include <stdio.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <errno.h>

#define MY_SYSCALL_NR 471

int main()
{
  printf("[custom syscall] %d...\n", MY_SYSCALL_NR);

  long ret = syscall(MY_SYSCALL_NR);

  if (ret == 0) {
    printf("[success] syscall %d executed.\n", MY_SYSCALL_NR);
    printf("[kernel log (dmesg)] = '[my_syscall] Hello World!!!.'\n");
  } else {
    perror("[error] syscall failed");
  }
  return 0;
}
