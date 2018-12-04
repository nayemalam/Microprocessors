#include <stdio.h>
#include <add.h>

int movingAvg(float * dataPtr, float * sum, double n, int D);
	
int main() {
	float samples[] = {1.1,2.2,3.3,4.4,5.5};
	float filtered[5];
	int N = 5;
	int avg = 0;
	double sum = 0.0;
	int depth = 5;
	
	
	for(int i=0; i< sizeof(samples)/sizeof(float); i++) {
		sum = filtered[i]; //add
		if(i>=N){
			sum-=filtered[i-N]; //subtract
		if(i>=(N-1)) {
			printf("your sma: %f", sum/depth);
		}
		avg = sum/depth;
		printf("Your sma: %d\n", avg);
	}
}
	return 0;

//int movingAvg(float * dataPtr, float *sum, double n, double D) {
	
	
}