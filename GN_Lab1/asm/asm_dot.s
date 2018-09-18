	AREA test, CODE, READONLY
	
	export asm_dot                  ; label must be exported if it is to be used as a function in C
asm_dot

;**For ref: r0 = a, r1 = b, r2 = N, r3 = output result; as outlined in header file;

			PUSH {R4,R5}                    ; saving context according to calling convention
	
			MOV 		 R6, #0                 ; set result = 0
			VMOV.f32 S0, R6               	; floating point result
			
LOOP	
			SUBS 		 R2, R2, #1 						;counter 
			BLT 		 DONE
			ADD 		 R4, R0, R2, LSL #2 		;array1
			ADD			 R5, R1, R2, LSL #2 		;array2
			VLDR.f32 S1, [R4] 							
			VLDR.f32 S2, [R5]
			VMUL.f32 S2, S1, S2 
			VADD.f32 S0, S0, S2 						;essentially: result+=a[i]*b[i]
			B 			 LOOP		
			
DONE	
			VSTR.f32 S0,[R3]
			POP {R4,R5}
			BX LR
			END