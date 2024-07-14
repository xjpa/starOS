learning how to build an OS from scratch

building one named after [our family doggo](https://xjpa.github.io/star/)

why? to learn

specifically: learn assembly, C, understand systems programming better, get a good solid foundation.

And finally it's to have a long term project I can dedicate to and learn from

# screenshot

![](hello.png)

# instructions

1. compile bootloader with nasm
2. compile kernel with gcc
3. link kernel with x86_64-elf-ld
4. convert ELF to binary with x86_64-elf-objcopy
5. cat bootloader and kernel to an OS image
6. run OS: qemu-system-x86_64

going forward, i ought to create a makefile for that

update:

```bash
$ make
$ make run
```

# star

![](star.jpeg)
