#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void print_information_vector(int* info_vector, int num_info_bits) {
	for (int i = 0; i < num_info_bits; i++) {
		printf("%d ", info_vector[i]);
	}
	printf("\n");
}

void print_error_vector(int* error_vector, int block_size) {
	for (int i = 0; i < block_size; i++) {
		printf("%d ", error_vector[i]);
	}
	printf("\n");
}

void generate_information_vectors(int num_info_bits) {
	printf("All Possible Information Vectors\n");
	printf("#####################################\n");
	int* info_vector = (int*)(malloc(num_info_bits * sizeof(int)));
	for (int i = 0; i < num_info_bits; i++) {
		info_vector[i] = 0;
	}
	long int num_permutations = (int)(pow(2, num_info_bits));
	for (long int i = 0; i < num_permutations; i++) {
		for (int j = num_info_bits - 1; j >= 0; j--) {
			long int position_power_2 = pow(2, j);
			if (i >= position_power_2 && i % position_power_2 == 0) {
				info_vector[num_info_bits - j - 1] ^= 1;			
			}
		}
		print_information_vector(info_vector, num_info_bits);
	}
	printf("\n\n");
}

void generate_error_vectors_fixed_error_numbers(int* error_vector, int curr_position, int num_errors, int block_size) {
	if (curr_position < 0) {
		print_error_vector(error_vector, block_size);
	}
	else {
		if (curr_position + 1 == num_errors) {
			error_vector[curr_position] = 1;
			generate_error_vectors_fixed_error_numbers(error_vector, curr_position - 1, num_errors - 1, block_size);
		}
		else if (num_errors == 0) {
			error_vector[curr_position] = 0;
			generate_error_vectors_fixed_error_numbers(error_vector, curr_position - 1, num_errors, block_size);
		}
		else {
			error_vector[curr_position] = 0;
			generate_error_vectors_fixed_error_numbers(error_vector, curr_position - 1, num_errors, block_size);
			error_vector[curr_position] = 1;
			generate_error_vectors_fixed_error_numbers(error_vector, curr_position - 1, num_errors - 1, block_size);
		}
	}
}

void generate_error_vectors_all_possible_error_numbers(int block_size) {
	int* error_vector = (int*)(malloc(block_size * sizeof(int)));
	for (int num_errors = 0; num_errors <= block_size; num_errors++) {
		printf("Error Vectors with %d errors\n", num_errors);
		printf("######################################\n");
		generate_error_vectors_fixed_error_numbers(error_vector, block_size - 1, num_errors, block_size);
		printf("\n\n");
	}
}

int main(void) {
	generate_information_vectors(8);
	generate_error_vectors_all_possible_error_numbers(7);
	return 0;
}
