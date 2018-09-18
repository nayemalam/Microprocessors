	AREA test, CODE, READONLY
	
	export asm_dot                  ; label must be exported if it is to be used as a function in C
asm_dot

		PUSH{R4, R5}                    ; saving context according to calling convention
		vmov N, #3
	
LOOP: 	vmov.f32 r0, #0 // i = 0
		vadd r0, r0, #1
		subs N,N,#1

		vld v0, a2 // loading first vector
		vld v1, a3 // load second vector
	  
	