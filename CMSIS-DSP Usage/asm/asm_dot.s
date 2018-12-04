	AREA test, CODE, READONLY
	
	export asm_dot                  ; label must be exported if it is to be used as a function in C
asm_dot

;**For ref: r0 = a, r1 = b, r2 = N, r3 = output result; as outlined in header file;

			PUSH {R4-R6}                    ; saving context according to calling convention
			
			VLDR.f32 S0, [R0]
			VLDR.f32 S1, [R1]
			VMOV.f32 S2, R5               	; floating point result
			MOV 		 R6, #0                 ; set i = 0
			
LOOP					
			ADD			 R6, R6, #1							;i
			CMP 		 R2, R6									;N & i
			BLT			 DONE									  ;when i < N -> DONE
			ADD 		 R4, R0, R6, LSL #2 		;array1
			ADD			 R5, R1, R6, LSL #2 		;array2
			VMLA.f32 S2, S0, S1
			VLDR.f32 S0, [R4] 							
			VLDR.f32 S1, [R5]
			;VMUL.f32 S2, S0, S1
			;VADD.f32 S2, S2, S2 						;essentially: result+=a[i]*b[i]
			B 			 LOOP		

DONE	
			VSTR.f32 S2,[R3]
			POP 		 {R4-R6}
			BX 			 LR
			END