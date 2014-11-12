CASE_BLINKY: 
	lui	$t5, 0x0000
	ori 	$t5, 0x00F0
	sw	$t5, 0x10020000			# Write to screen
	
	### Delay ###
	addi 	$t5, $zero, 10			# Load $t5 with delay of 10
	_DELAY_LOOP_BLINKY_0:
	sub	$t5, $t5, 1			# Decrement counter 
	bgez 	$t5, _DELAY_LOOP_BLINKY_0	# Loop
	### /Delay ###	
	lui	$t5, 0x0000
	ori 	$t5, 0x000F
	sw	$t5, 0x10020000			# Write to screen
	### Delay ###
	addi 	$t5, $zero, 10			# Load $t5 with delay of 10
	_DELAY_LOOP_BLINKY_1:
	sub	$t5, $t5, 1			# Decrement counter 
	bgez 	$t5, _DELAY_LOOP_BLINKY_1	# Loop
	### /Delay ###
	

CASE_PEUPEU:
## Shoot Nerf guns. peu peu!
	lui 	$t6, 0
	ori 	$t6, 2
	lui	$t5, 0x0000
	ori 	$t5, 0x0001
	sw	$t5, 0x10020000			# Write to screen
	
	# 2
	mul 	$t5, $t5, $t6
	sw	$t5, 0x10020000			# Write to screen
	
	# 3
	mul 	$t5, $t5, $t6
	sw	$t5, 0x10020000			# Write to screen
	
	# 4
	mul 	$t5, $t5, $t6
	sw	$t5, 0x10020000			# Write to screen
	
	# 5
	mul 	$t5, $t5, $t6
	sw	$t5, 0x10020000			# Write to screen
	
	# 4
	srl	$t5, $t5, 1
	sw	$t5, 0x10020000			# Write to screen

	# 3
	srl	$t5, $t5, 1
	sw	$t5, 0x10020000			# Write to screen
	
	# 2
	srl	$t5, $t5, 1
	sw	$t5, 0x10020000			# Write to screen
	
	# 1
	srl	$t5, $t5, 1
	sw	$t5, 0x10020000			# Write to screen


	j 	CASE_BLINKY