	AREA test, CODE, READONLY
	
	export asm_var                  ; label must be exported if it is to be used as a function in C
asm_var

;**For ref: r0 = a, r1 = b, r2 = N, r3 = output result; as outlined in header file;

			PUSH {R4,R5}                    ; saving context according to calling convention
	
			MOV 		 R6, #0                 ; set result = 0
			VMOV.f32 S0, R6               	; floating point result
			MOV 		 R7, #0
			VMOV.f32 S5, R7							  	; sum = 0
			
			
MEAN	
			SUBS R5, R5, #1         
			BLT MEAN              
			ADD R4, R0, R5, LSL #2  
			VLDR.f32 S2, [R4]       
			VADD.f32 S4, S2   
			B MEAN 
			VMOV.f32 S1, R1
			VCVT.F32.S32 S1, S1 
			VDIV.f32 S4, S4, S1     			; S4 is the average of the array 
			MOV R5, R1
			B VAR 
			
VAR	
			SUBS R5, R5, #1         
			BLT DONE            
			ADD R4, R0, R5, LSL #2  		;array a
			VLDR.f32 S2, [R4]       
			VSUB.f32 S2, S2, S4
			VMUL.f32 S2, S2, S2
			VADD.f32 S5, S5, S2
			B VAR
			
DONE	
			VDIV.f32 S5, S5, S1 
			VSTR.f32 S5, [R2]
			POP {R4,R5}
			BX LR
			END