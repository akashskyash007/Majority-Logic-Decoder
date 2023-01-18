#include <stdio.h>
#include <stdlib.h>

void generate_parity_vector(int* information_vector, int* parity_vector) {
	int i0 = information_vector[0], i1 = information_vector[1], i2 = information_vector[2];
	int p0 = i0 ^ i1;
	int p1 = i1 ^ i2;
	int p2 = i0 ^ i1 ^ i2;
	int p3 = i0 ^ i2;
	parity_vector[0] = p0;
	parity_vector[1] = p1;
	parity_vector[2] = p2;
	parity_vector[3] = p3;
}

void encode(int* encoded_vector, int* information_vector, int block_size, int num_info_bits) {
	for (int i = 0; i < num_info_bits; i++) {
		encoded_vector[i] = information_vector[i];
	}
        int* parity_vector = (int*)(malloc((block_size - num_info_bits) * sizeof(int)));
	generate_parity_vector(information_vector, parity_vector);
	for (int i = num_info_bits; i < block_size; i++) {
		encoded_vector[i] = parity_vector[i - num_info_bits];
	}	
}
void add_error(int* receive_vector, int* encoded_vector,int* error_vector,int block_size){
	
	for(int i=0;i<block_size;i++){
		receive_vector[i]=encoded_vector[i]^error_vector[i];
	
	}
	

}
void decoding(int* receive_vector, int* decoded_vector, int block_size){
	for(int i=0;i<block_size;i++){
		decoded_vector[i]=receive_vector[i];
	
	}
	for(int i=0;i<block_size;i++){
		int A1=decoded_vector[3]^decoded_vector[4]^decoded_vector[6];
		int A2=decoded_vector[1]^decoded_vector[5]^decoded_vector[6];
		int A3=decoded_vector[0]^decoded_vector[2]^decoded_vector[6];
		int M=A1&A2 | A2&A3 | A1&A3;
		
		decoded_vector[6]^=M;
		int temp=decoded_vector[6];
		for(int j=6;j>0;j--){
			decoded_vector[j]=decoded_vector[j-1];
		}
		decoded_vector[0]=temp;
	
	}
	

}

void test_encoder() {
	int information_vector[3] = {0, 1, 1};
	int encoded_vector[7];
	encode(encoded_vector, information_vector, 7, 3);
	for(int i=0;i<7;i++){
		printf("%d ",encoded_vector[i]);
	}
	
	printf("\n");
	int error_vector[7]={0,0,1,0,0,0,0};
	int receive_vector[7];
	add_error(receive_vector,encoded_vector,error_vector,7);
	for(int i=0;i<7;i++){
		printf("%d ",receive_vector[i]);
	}
	printf("\n");
	int decoded_vector[7];
	decoding(receive_vector,decoded_vector,7);
	for(int i=0;i<7;i++){
		printf("%d ",decoded_vector[i]);
	}
	
	
}

int main(void) {
	test_encoder();
	
	return 0;
}
