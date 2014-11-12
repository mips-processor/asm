## Play my pong is an interactive display where users
## can configure what blinky pong patterns to display on
## the LED screen.  Is it written for the MIPS implementation
## of EE3207, Computer Architecture, NUS.

# instructions tested
# lw, srl, sll, 

# t4 : Register storing DIP state

### Memory Map ##########################
# 0x90000000 -> Location of DIP  -- deployment: change to 0x10030000
# 0x10020000 -> Location of LEDs -- deployment: change to 0x10020000
########################################
#   [][][][][][][][X]

### FIXTURES ###
# Comment in deployment
lui $t1, 0x0000
ori $t1, 0x1000
sw $t1, 0x90000000
# /Comment in deployment
### /FIXTURES ###

LoadBitmaps:
	lui 	$t1, 0x0000
	ori 	$t1, 0x0001
	sw 	$t1, 0x10010000		# Store value '1' in memory location 0x10010000
	
LoadOne:
	lui	$s0, 0x0000		# Store zero
	ori 	$s0, 0x0000

ConfigSettings:
	lw 	$t4, 0x90000000 	# Get DIP settings state
	add 	$t0, $zero, $t4 	# Copy DIP value and get state mode by SRL
	sll 	$t0, $t0, 31
	srl 	$t0, $t0, 31 		# Setting state in $t0, bit 0
	
	lui 	$t1, 0x8000 		# Doing some fancy bit shifting to check SRA, SUB and SLLV
	ori 	$t1, 0x00
	sra 	$t1, $t1, 31		# populated with 1s now
	lui 	$t6, 0xFFFF
	ori 	$t6, 0x0000
	sub	$t4, $t1, $t6 		# t4 now contains 0x0000 FFFF
	srl 	$t4, $t4, 15
	sll 	$t1, $t1, 31 		# t1 is now 1000 0000
	sub	$t1, $t1, $t1 		# t1 is now zeroed
	ori 	$t1, 0x1F		# 32 places used by SLLV
	sllv 	$t4, $t4, $t1
	srl	$t4, $t4, 31
	# At this point, $t4 the bitmask contains 0x8000 0000 #
	

Config_GetSelection:
	lui 	$t1, 0x0000
	ori 	$t1, 0x0001
	nor 	$t1, $t1, $s0 		# Create a bitmask
	add	$t2, $t2, $zero		# clear $t2
	lw 	$t5, 0x90000000 	# Get DIP settings state
	and 	$t2, $t5, $t1
	srl	$t2, $t2, 1 		# $t2 now contains bit selection
	sub	$t4, $t0, $t4
	bgez	$t4, ConfigSettings
	
Config_saved_blink_lights:
	

Main:
## DO NOT MODIFY $t2, which contains state information. ##
DecideBranchToJump:
	### Jump Statement ###
	add 	$t5, $zero, $zero	# Reset $t5
	ori	$t5, 1			# Load $t5 with combination 1
	beq 	$t2, $t5, CASE_BLINKY	# Do a blinky
	### /Jump Statement ###
	
	### Jump Statement ###
	add 	$t5, $zero, $zero	# Reset $t5
	ori	$t5, 2			# Load $t5 with combination 1
	beq 	$t2, $t5, CASE_PEUPEU	# Case PEUPEU
	### /Jump Statement ###
	
	### Jump Statement ###
	add 	$t5, $zero, $zero	# Reset $t5
	ori	$t5, 3			# Load $t5 with combination 1
	beq 	$t2, $t5, CASE_HILO	# Case HILO
	### /Jump Statement ###
	
	## Otherwise, jump to case invalid.
	
CASE_INVALID:
## If all else fails.
	lui	$t5, 0x0000
	ori 	$t5, 0xAAAA
	sw	$t5, 0x10020000			# Write to screen	
	### Delay ###
	addi 	$t5, $zero, 10			# Load $t5 with delay of 10
	_DELAY_LOOP_INVALID_0:
	sub	$t5, $t5, 1			# Decrement counter 
	bgez 	$t5, _DELAY_LOOP_INVALID_0	# Loop
	### /Delay ###	
	lui	$t4, 0x0000
	ori 	$t4, 0xFFFF
	nor	$t4, $t4, $s0
	nor	$t5, $t5, $t4			# toggle
	sw	$t5, 0x10020000			# Write to screen	
	### Delay ###
	addi 	$t5, $zero, 10			# Load $t5 with delay of 10
	_DELAY_LOOP_INVALID_1:
	sub	$t5, $t5, 1			# Decrement counter 
	bgez 	$t5, _DELAY_LOOP_INVALID_1	# Loop
	### /Delay ###	
	j 	CheckToggleAndLoop		# Jump to end and (possibly) loop	
	
CASE_BLINKY: 
	lui	$t5, 0x0000
	ori 	$t5, 0xFFFF
	sw	$t5, 0x10020000			# Write to screen
	
	### Delay ###
	addi 	$t5, $zero, 10			# Load $t5 with delay of 10
	_DELAY_LOOP_BLINKY_0:
	sub	$t5, $t5, 1			# Decrement counter 
	bgez 	$t5, _DELAY_LOOP_BLINKY_0	# Loop
	### /Delay ###	
	lui	$t5, 0xFFFF
	ori 	$t5, 0x0000
	sw	$t5, 0x10020000			# Write to screen
	### Delay ###
	addi 	$t5, $zero, 10			# Load $t5 with delay of 10
	_DELAY_LOOP_BLINKY_1:
	sub	$t5, $t5, 1			# Decrement counter 
	bgez 	$t5, _DELAY_LOOP_BLINKY_1	# Loop
	### /Delay ###
	j 	CheckToggleAndLoop		# Jump to end and (possibly) loop	
	
	
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
	
	j 	CheckToggleAndLoop		# Jump to end and (possibly) loop	
	

CASE_HILO: 
	lui 	$t6, 0x0000
	ori	$t6, 0xFFFF 
	lui	$t7, 0x000F
	ori 	$t7, 0xFFFF
	mult	$t7, $t6			# HI and LO populated
	
	mfhi	$t5
	sw	$t5, 0x10020000			# Write to screen
	
	### Delay ###
	addi 	$t5, $zero, 10			# Load $t5 with delay of 10
	_DELAY_LOOP_HILO_0:
	sub	$t5, $t5, 1			# Decrement counter 
	bgez 	$t5, _DELAY_LOOP_BLINKY_0	# Loop
	### /Delay ###	
	
	mflo	$t5
	sw	$t5, 0x10020000			# Write to screen
	
	### Delay ###
	addi 	$t5, $zero, 10			# Load $t5 with delay of 10
	_DELAY_LOOP_HILO_1:
	sub	$t5, $t5, 1			# Decrement counter 
	bgez 	$t5, _DELAY_LOOP_BLINKY_1	# Loop
	### /Delay ###
	j 	CheckToggleAndLoop		# Jump to end and (possibly) loop


CheckToggleAndLoop:
	lw 	$t4, 0x90000000 	# Get DIP settings state
	add	$t0, $zero, 25		# Clear $t0
	slt 	$t0, $zero, $t0		# Fancy way of loading $t0 with 1 
	and	$t4, $t4, $t0 		# Bitmask to get toggle switch value 
	bgezal 	$4, ConfigSettings	# Go to config label if screen is unset
	j 	Main 			# Else loop back to Main display
	

	# t2: Bit selection
	
	
	
#	j ConfigSettings
	 
	
	
