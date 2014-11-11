asm
===

## What is it

MIPS assembly programs for testing.

## Programs included


### Pong3207

Watch a ping pong ball bounce in the screen.

### World of Pong 

Switch state as follows:

        Setting this to HIGH goes to config state.  Else, PLAY.
           |
    00000000
    <----->
      |
    Available Patterns:
        1: Alternate blinky
        Otherwise: Toggle between 0101 and 1010


## Deployment on FPGA

Remember to switch the memory maps back to the proper location, before
usage!
