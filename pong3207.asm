# <<---------------------------------------------->>
# <<-------------- Miniature PONG ---------------->>
# <<---------------------------------------------->>
#
# ~~ Created for CG3207 ~~
#
# << What is it? >>
# 
# This program creates a miniature pong screen.  Bits
# move from left to right, and left.
#
# e.g.
# ....
# x...
# .x..
# ..x.
# ...x
# ....
# ..x.
# .x..
# x...
#
#
# << SPEED CONTROL >>
#
# To control the speed, use the DIP switches.
# 
# DIP switch data is intepreted as an 8-bit unsigned 
# integer delay of n clock cycles.
#
# For no delay, set all input switches to OFF state. 
#
# <<---------------------------------------------->>

.globl main
main:
initSprite:
	lui 	$t0, 0x0000
	ori 	$t0, 0x0000
	sw 	$t0, 0x10010000
	
	lui 	$t0, 0x0000
	ori 	$t0, 0x0001
	sw 	$t0, 0x10010004
	
	lui 	$t0, 0x0000
	ori 	$t0, 0x0002
	sw 	$t0, 0x10010008
	
	lui 	$t0, 0x0000
	ori 	$t0, 0x0004
	sw 	$t0, 0x1001000c
	
	lui 	$t0, 0x0000
	ori 	$t0, 0x0008
	sw 	$t0, 0x10010010
	
	lui 	$t0, 0x0000
	ori 	$t0, 0x0010
	sw 	$t0, 0x10010014
	
	lui 	$t0, 0x0000
	ori 	$t0, 0x0020
	sw 	$t0, 0x10010018
	
	lui 	$t0, 0x0000
	ori 	$t0, 0x0040
	sw 	$t0, 0x1001001c
	
	lui 	$t0, 0x0000
	ori 	$t0, 0x0080
	sw 	$t0, 0x10010020

initialize:
	lui 	$s1, 0			# s1: constant 1
	ori 	$s1, 1
	lui	$t0, 0 			# t0: direction
	ori 	$t0, 4
	lui 	$t1, 0x1001 		# t1: current sprite memory location to access
	ori 	$t1, 0x0000		
	lui 	$t2, 0x1001 		#t2: current sprite address to use
	ori 	$t2, 0x0000
	lw 	$t4, 0x10030000 	#t4: Current state of DIP switches

		
loop:
	and	$s0, $s0, $zero 	# s0: delay counter, reset to 0

display:
	add 	$t1, $t1, $t0 		# Calculate new memory address (add / sub)
	sw 	$t5, 0x10020000 	# Display updated image
	
delay: 
	lw 	$t4, 0x10030000 	# Get DIP switch state
	beq 	$t4,$s0, makeOutput	# Execute if counter reached
	add 	$s0, $s0, $s1 		# Increment counter
	j 	delay			# otherwise loop to delay
	
makeOutput:
	
	lw 	$t3, 0x10020000 	# Get current (OLD) screen state
	lw 	$t5, ($t1) 		# t5: Stores current sprite image and updated (NEW) screen state 
	#or 	$t5, $t5, $t4		# bitwise OR the sprite to get updated image
	beq 	$t3, $t5, flip		# Flip the direction if no change
	j 	loop			# If no change, continue


# Flip positive to negative, and negative to positive
flip:
	slt 	$t7, $t0, $zero
	beq 	$t7, $zero, convertToNegative

convertToPositive:
	lui 	$t0, 0
	ori 	$t0, 4
	add 	$t1, $t1, $t0 		# Calculate new memory address (add / sub)
	j loop

convertToNegative:
	lui 	$t0, 0xFFFF
	ori 	$t0, -4
	add 	$t1, $t1, $t0 		# Calculate new memory address (add / sub)
	j loop



# Sprite data (This segment is performed above, since
# assembly dump does not directly dump .data segment
#
#.data 
#	sprite0: .word 0x00000000
#	sprite1: .word 0x00000001
#	sprite2: .word 0x00000002
#	sprite3: .word 0x00000004
#	sprite4: .word 0x00000008
#	sprite5: .word 0x00000010
#	sprite6: .word 0x00000020
#	sprite7: .word 0x00000040
#	sprite8: .word 0x00000080
