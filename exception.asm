lui $t0, 0x7fff
ori $t0, 0xffff
lui $t1, 0x7fff
ori $t1, 0xffff
add $t2, $t0, $t1

lui $t5, 0xffff
ori $t5, 0xffff
sw  $t5, 0x10020000

#teqi 	$t0, 0
#li 	$v0, 10

 .ktext 0x80000180
   mfc0 $k0,$14   # Coprocessor 0 register $14 has address of trapping instruction
   sw	$k0, 0x10020000
   
   #addi $k0,$k0,4 # Add 4 to point to next instruction
   #mtc0 $k0,$14   # Store new address back into $14
   #eret           # Error return; set PC to value in $14
   .kdata	
msg:   
   .asciiz "Trap generated"
