/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */
/* create a string */
.global nameStr
.type nameStr,%gnu_unique_object
    
/*** STUDENTS: Change the next line to your name!  **/
nameStr: .asciz "Robert Nelson"  
 
.align    /* ensure following vars are allocated on word-aligned addresses */

/* initialize a global variable that C can access to print the nameStr */
.global nameStrPtr
.type nameStrPtr,%gnu_unique_object
nameStrPtr: .word nameStr   /* Assign the mem loc of nameStr to nameStrPtr */

.global a_value,b_value
.type a_value,%gnu_unique_object
.type b_value,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
a_value:          .word     0  
b_value:           .word     0  

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: 
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    mov r0,r0
.endif
    
    /** note to profs: asmFunc.s solution is in Canvas at:
     *    Canvas Files->
     *        Lab Files and Coding Examples->
     *            Lab 5 Division
     * Use it to test the C test code */
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    
    /***
     * Copy the value passed into r0 to a new register
     * This will allow us to manipulate it indendently
    ***/
    mov r1, r0
    /***
     * Perform an arithmetic shift right by 16 bits
     * The A bits were previously the 16 MSB, and need to be moved down
     * ASR also performs the necessary sign extension of A
     ***/
    asr r2, r1, #16
    
    /* Store the now-unpacked value of A */
    ldr r3, =a_value
    str r2, [r3]
    
    /* Begin with the same process as above moving r0 to new register */
    mov r1, r0
    /***
     * Perform a logical shift left by 16 bits
     * The B bits are sitting in the LSB but bit 31 is used for sign extension
     * So an LSL will move the bits to where the B sign value is the MSB
     * After this, perform an ASR by 16 bits to sign extend the MSB
     * This process is incredibly similar to A, but with one extra step
    ***/
    lsl r2, r1, #16
    asr r1, r2, #16
    
    /* Store the now-unpacked value of B */
    ldr r3, =b_value
    str r1, [r3]
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    mov r0,r0 /* these are do-nothing lines to deal with IDE mem display bug */
    mov r0,r0 /* this is a do-nothing line to deal with IDE mem display bug */

screen_shot:    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




