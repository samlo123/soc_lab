#include "fir.h"

void __attribute__ ( ( section ( ".mprjram" ) ) ) initfir() {
	//initial your fir
	for (int i = 0; i < N; i++)
		outputsignal[i] = 0;
}

int* __attribute__ ( ( section ( ".mprjram" ) ) ) fir(){
	initfir();
	//write down your fir
	for (int i = 0; i < N; i++)
		for (int j = 0; j < i; j++)
			outputsignal[i] += inputsignal[j] * taps[i - j];
	return outputsignal;
}
		
