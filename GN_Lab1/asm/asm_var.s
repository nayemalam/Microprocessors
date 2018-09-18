	AREA test, CODE, READONLY
	
	export asm_var                  ; label must be exported if it is to be used as a function in C
asm_var

;**For ref: r0 = a, r1 = b, r2 = N, r3 = output result; as outlined in header file;

			PUSH {R4,R5}                    ; saving context according to calling convention
	
			MOV 		 R6, #0                 ; set result = 0
			VMOV.f32 S0, R6               	; floating point result
			VSUB.f32 S5, S5, S5							; sum = 0
			VLDR.f32 S9, [R1]
			VCVT.f32.s32 S9,S9
			
MEAN	
			SUBS 		 R1,R1, #1
			BLT 		 VAR
			ADD			 R4, R0, R1, LSL #2 		; array
			VLDR.f32 S1, [R4]								; sum
			B MEAN
			VDIV.f32 S2, S1, S9							; mean
			
VAR	
			SUBS 		 R1, R1, #1 						;counter 
			BLT 		 DONE
			ADD 		 R5, R0, R1, LSL #2 		; array
			VLDR.f32 S3, [R5]								; load it to float
			VSUB.f32 S4, S3, S2							; subtract by mean (a[i]-mean)
			VMUL.f32 S4, S4, S4							; (a[i]-mean)^2
			VLDR.f32 S10,[R1]
			VDIV.f32 S5, S4, S10							
			B VAR
			
DONE	
			VSTR.f32 S0,[R3]
			POP {R4,R5}
			BX LR
			END