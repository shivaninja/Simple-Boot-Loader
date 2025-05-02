

 Bootloader Info
 File: bootloader.asm
 Output: bootloader.bin
 Mode: Real Mode (16-bit)
 Platform: x86 BIOS-based systems


-----------------------------------------------------------------------------------------------------------------------------------------------



Description
This is a simple 16-bit x86 bootloader that fits into the first 512 bytes of a bootable disk. When executed by the BIOS, it prints the message:
Hello from x86 bootloader!
directly to the screen using BIOS interrupt calls.


----------------------------------------------------------------------------------------------------------------------------------------------------

Boot Process
1. BIOS Stage:

On power-up, the BIOS reads the first sector (512 bytes) of the bootable drive into memory at address 0x7C00.

If the sector ends with the signature 0xAA55, BIOS jumps to 0x7C00 to begin execution.

2. Bootloader Stage:

Disables interrupts with cli.

Initializes segment registers (DS, ES) to 0x0000.

Loops over a message string byte-by-byte, printing each character using BIOS interrupt int 0x10.

Enters an infinite loop to prevent the CPU from executing garbage memory.



-------------------------------------------------------------------------------------------------------------------------------------------


Key Features
1. Fits in 512 bytes

2. Includes valid boot signature (0xAA55)

3. Uses BIOS int 0x10 for screen output

4. Compatible with QEMU, VirtualBox, and real BIOS


--------------------------------------------------------------------------------------------------------------------------------------------


 How to Assemble and Test
Assemble:
bash:
nasm -f bin bootloader.asm -o bootloader.bin


----------------------------------------------------------------------------------------------------------------------------------------------


To Run in QEMU:
bash:
qemu-system-x86_64 -drive format=raw,file=bootloader.bin


-----------------------------------------------------------------------------------------------------------------------------------------------


2. Structure Overview
Offset	Size	Purpose
0x0000	~490 B	Code and message string
0x01FE	2 B	Boot Signature (0xAA55)
