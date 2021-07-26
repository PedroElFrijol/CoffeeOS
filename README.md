# CoffeeOS

CoffeeOS is an ARM based operating system that can be booted in Raspberry PI 0, Raspberry PI 0W, and Raspberry PI 4

https://wiki.osdev.org/Raspberry_Pi_Bare_Bones

## Bugs and Fixes
Fixed the makefile and make commands so it can print to the console

(Bugs and fixes updated by PedroElFrijol)

## How to build the OS
you need ARM build tools to install that you can use: `sudo apt install gcc-arm-none-eabi`

Build the Bootloader:    `make bootloader`

Build the Kernel:        `make kernel`

Run QEMU IN ARM:         `make run`

Clean the project:       `make clean`

Build All:               `make all`

(make commands made by Pradosh / pradosh-arduino)
