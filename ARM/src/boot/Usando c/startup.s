.global _start
_start:
LDR sp, = sp_top
BL my_init
B .
