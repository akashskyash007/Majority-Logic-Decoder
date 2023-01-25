#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void generate_parity_vector(int* information_vector, int* encoded_vector, int block_size, int num_info_bits) {
	int* flip_flop_input = (int*)(malloc(10 * sizeof(int)));
	int* flip_flop_output = (int*)(malloc(10 * sizeof(int)));
	for(int i = 0;i < block_size - num_info_bits; i++){
		flip_flop_input[i] = 0;
		flip_flop_output[i] = 0;
	
	}
	for(int i = 0;i < num_info_bits; i++){
		flip_flop_input[0] = flip_flop_output[9] ^ information_vector[num_info_bits - 1 - i];
		flip_flop_input[1] = flip_flop_output[0] ^ flip_flop_input[0];
		flip_flop_input[2] = flip_flop_output[1] ^ flip_flop_input[0];
		flip_flop_input[3] = flip_flop_output[2];
		flip_flop_input[4] = flip_flop_output[3] ^ flip_flop_input[0];
		flip_flop_input[5] = flip_flop_output[4] ^ flip_flop_input[0];
		flip_flop_input[6] = flip_flop_output[5];
		flip_flop_input[7] = flip_flop_output[6];
		flip_flop_input[8] = flip_flop_output[7] ^ flip_flop_input[0];
		flip_flop_input[9] = flip_flop_output[8];
		for (int j = i; j > 0; j--) {
			encoded_vector[j] = encoded_vector[j - 1];
		}
		encoded_vector[0] = information_vector[num_info_bits - i - 1];
		for (int j = block_size - num_info_bits - 1; j >= 0; j--) {
			flip_flop_output[j] = flip_flop_input[j];
		}
	}
	for (int i = num_info_bits; i < block_size; i++) {
		for (int j = i; j > 0; j--) {
			encoded_vector[j] = encoded_vector[j - 1];
		}
		encoded_vector[0] = flip_flop_output[block_size - i - 1];
	}
}

void encode(int* encoded_vector, int* information_vector, int block_size, int num_info_bits) {
	generate_parity_vector(information_vector, encoded_vector, block_size, num_info_bits);	
}

void add_error(int* receive_vector, int* encoded_vector,int* error_vector,int block_size){
	for(int i=0;i<block_size;i++){
		receive_vector[i]=encoded_vector[i]^error_vector[i];
	}
}

int majority_gate(int i1, int i2, int i3, int i4, int i5, int i6) {
	if (i1 + i2 + i3 + i4 + i5 + i6 > 3) {
		return 1;
	}
	else {
		return 0;
	}
}

void decode(int* receive_vector, int* decoded_vector, int block_size){
	for(int i=0;i<block_size;i++){
		decoded_vector[i]=receive_vector[i];
	
	}
	for(int i=0;i<block_size;i++){
		int A11 = decoded_vector[4] ^ decoded_vector[10] ^ decoded_vector[13] ^ decoded_vector[14];
		int A12 = decoded_vector[7] ^ decoded_vector[12] ^ decoded_vector[13] ^ decoded_vector[14];
		int A13 = decoded_vector[9] ^ decoded_vector[11] ^ decoded_vector[13] ^ decoded_vector[14];
		int A14 = decoded_vector[0] ^ decoded_vector[8] ^ decoded_vector[13] ^ decoded_vector[14];
		int A15 = decoded_vector[1] ^ decoded_vector[5] ^ decoded_vector[13] ^ decoded_vector[14];
		int A16 = decoded_vector[3] ^ decoded_vector[6] ^ decoded_vector[13] ^ decoded_vector[14];
		int M1 = majority_gate(A11, A12, A13, A14, A15, A16);

                int A21 = decoded_vector[0] ^ decoded_vector[10] ^ decoded_vector[12] ^ decoded_vector[14];
                int A22 = decoded_vector[3] ^ decoded_vector[11] ^ decoded_vector[12] ^ decoded_vector[14];
                int A23 = decoded_vector[7] ^ decoded_vector[13] ^ decoded_vector[12] ^ decoded_vector[14];
                int A24 = decoded_vector[1] ^ decoded_vector[2] ^ decoded_vector[12] ^ decoded_vector[14];
                int A25 = decoded_vector[4] ^ decoded_vector[8] ^ decoded_vector[12] ^ decoded_vector[14];
                int A26 = decoded_vector[6] ^ decoded_vector[9] ^ decoded_vector[12] ^ decoded_vector[14];
                int M2 = majority_gate(A21, A22, A23, A24, A25, A26);

                int A31 = decoded_vector[3] ^ decoded_vector[12] ^ decoded_vector[11] ^ decoded_vector[14];
                int A32 = decoded_vector[9] ^ decoded_vector[13] ^ decoded_vector[11] ^ decoded_vector[14];
                int A33 = decoded_vector[0] ^ decoded_vector[5] ^ decoded_vector[11] ^ decoded_vector[14];
                int A34 = decoded_vector[1] ^ decoded_vector[8] ^ decoded_vector[11] ^ decoded_vector[14];
                int A35 = decoded_vector[2] ^ decoded_vector[4] ^ decoded_vector[11] ^ decoded_vector[14];
                int A36 = decoded_vector[6] ^ decoded_vector[7] ^ decoded_vector[11] ^ decoded_vector[14];
                int M3 = majority_gate(A31, A32, A33, A34, A35, A36);

                int A41 = decoded_vector[0] ^ decoded_vector[12] ^ decoded_vector[10] ^ decoded_vector[14];
                int A42 = decoded_vector[4] ^ decoded_vector[13] ^ decoded_vector[10] ^ decoded_vector[14];
                int A43 = decoded_vector[1] ^ decoded_vector[6] ^ decoded_vector[10] ^ decoded_vector[14];
                int A44 = decoded_vector[3] ^ decoded_vector[5] ^ decoded_vector[10] ^ decoded_vector[14];
                int A45 = decoded_vector[7] ^ decoded_vector[8] ^ decoded_vector[10] ^ decoded_vector[14];
                int A46 = decoded_vector[2] ^ decoded_vector[9] ^ decoded_vector[10] ^ decoded_vector[14];
                int M4 = majority_gate(A41, A42, A43, A44, A45, A46);

                int A51 = decoded_vector[0] ^ decoded_vector[11] ^ decoded_vector[5] ^ decoded_vector[14];
                int A52 = decoded_vector[1] ^ decoded_vector[13] ^ decoded_vector[5] ^ decoded_vector[14];
                int A53 = decoded_vector[3] ^ decoded_vector[10] ^ decoded_vector[5] ^ decoded_vector[14];
                int A54 = decoded_vector[4] ^ decoded_vector[6] ^ decoded_vector[5] ^ decoded_vector[14];
                int A55 = decoded_vector[2] ^ decoded_vector[7] ^ decoded_vector[5] ^ decoded_vector[14];
                int A56 = decoded_vector[8] ^ decoded_vector[9] ^ decoded_vector[5] ^ decoded_vector[14];
                int M5 = majority_gate(A51, A52, A53, A54, A55, A56);

                int A61 = decoded_vector[1] ^ decoded_vector[12] ^ decoded_vector[2] ^ decoded_vector[14];
                int A62 = decoded_vector[4] ^ decoded_vector[11] ^ decoded_vector[2] ^ decoded_vector[14];
                int A63 = decoded_vector[0] ^ decoded_vector[6] ^ decoded_vector[2] ^ decoded_vector[14];
                int A64 = decoded_vector[3] ^ decoded_vector[8] ^ decoded_vector[2] ^ decoded_vector[14];
                int A65 = decoded_vector[5] ^ decoded_vector[7] ^ decoded_vector[2] ^ decoded_vector[14];
                int A66 = decoded_vector[9] ^ decoded_vector[10] ^ decoded_vector[2] ^ decoded_vector[14];
                int M6 = majority_gate(A61, A62, A63, A64, A65, A66);

		int M = majority_gate(M1, M2, M3, M4, M5, M6);

		decoded_vector[block_size - 1]^=M;
		int temp=decoded_vector[block_size - 1];
		for(int j=block_size - 1;j > 0;j--){
			decoded_vector[j] = decoded_vector[j-1];
		}
		decoded_vector[0] = temp;
	}
}

void generate_information_vectors(int num_info_bits, int* all_info_vectors) {
	int* info_vector = (int*)(malloc(num_info_bits * sizeof(int)));
	int curr_info_vector_index = 0;
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
		for (int j = curr_info_vector_index; j < curr_info_vector_index + num_info_bits; j++) {
			all_info_vectors[j] = info_vector[j - curr_info_vector_index];
		}
		curr_info_vector_index += num_info_bits;
	}
}

void generate_error_vectors_fixed_error_numbers(int* all_error_vectors, int* error_vector, int curr_position, int num_errors, int block_size, int* curr_error_vector_position) {
	if (curr_position < 0) {
		int start_position = ((*curr_error_vector_position)++) * block_size;
		for (int i = 0; i < block_size; i++) {
			all_error_vectors[i + start_position] = error_vector[i];
		}
	}
	else {
		if (curr_position + 1 == num_errors) {
			error_vector[curr_position] = 1;
			generate_error_vectors_fixed_error_numbers(all_error_vectors, error_vector, curr_position - 1, num_errors - 1, block_size, curr_error_vector_position);
		}
		else if (num_errors == 0) {
			error_vector[curr_position] = 0;
			generate_error_vectors_fixed_error_numbers(all_error_vectors, error_vector, curr_position - 1, num_errors, block_size, curr_error_vector_position);
		}
		else {
			error_vector[curr_position] = 0;
			generate_error_vectors_fixed_error_numbers(all_error_vectors, error_vector, curr_position - 1, num_errors, block_size, curr_error_vector_position);
			error_vector[curr_position] = 1;
			generate_error_vectors_fixed_error_numbers(all_error_vectors, error_vector, curr_position - 1, num_errors - 1, block_size, curr_error_vector_position);
		}
	}
}

long int fact(int x) {
	long int result = 1;
	while (x > 0) {
		result *= x;
		x--;
	}
	return result;
} 

int calc_nCr(int n, int r) {
	return fact(n)/(fact(r) * fact(n - r));
}

int calc_errors_after_decoding(int* current_encoded_vector, int* current_decoded_vector, int block_size) {
	int num_errors = 0;
	for (int i = 0; i < block_size; i++) {
		num_errors += current_encoded_vector[i] ^ current_decoded_vector[i];
	}
	return num_errors;
}

void test_system() {
	FILE* fptr;
	fptr = fopen("Multi_Step_MLD_Results.txt", "w");
	int block_size = 15;
	int num_info_bits = 5;
	int num_possible_info_vectors = pow(2, num_info_bits);
	int* all_info_vectors = (int*)(malloc(num_possible_info_vectors * num_info_bits * sizeof(int)));
	generate_information_vectors(num_info_bits, all_info_vectors);
	int num_code_words = num_possible_info_vectors;
	int* all_transmitted_code_words = (int*)(malloc(num_code_words * block_size * sizeof(int)));
	int* curr_info_vector = (int*)(malloc(num_info_bits * sizeof(int)));
	int* current_encoded_vector = (int*)(malloc(block_size * sizeof(int)));
	for (int i = 0; i < num_code_words; i++) {
		int start_position = i * num_info_bits;
		int end_position = (i + 1) * num_info_bits;
		for (int j = start_position; j < end_position; j++)  {
			curr_info_vector[j - start_position] = all_info_vectors[j];
		}
		encode(current_encoded_vector, curr_info_vector, block_size, num_info_bits);
		int curr_codeword_start_pos = i * block_size;
		int curr_codeword_end_pos = (i + 1) * block_size;
		for (int j = curr_codeword_start_pos; j < curr_codeword_end_pos; j++) {
			all_transmitted_code_words[j] = current_encoded_vector[j - curr_codeword_start_pos];
		}
	}
	int* current_received_vector = (int*)(malloc(block_size * sizeof(int)));
	int* current_decoded_vector = (int*)(malloc(block_size * sizeof(int)));
	for (int num_errors = 0; num_errors <= block_size; num_errors++) {
		fprintf(fptr, "#################################################################################################################################\n");
		fprintf(fptr, "Number of Errors = %d\n", num_errors);
		fprintf(fptr, "Transmitted Vector%46s%46s%40s\n", "Received Vector", "Decoded Vector", "Number of Errors");
		float average_number_of_errors = 0.0;
		int number_of_test_cases = 0;
		int maximum_number_of_errors = 0;
		int minimum_number_of_errors = block_size;
		int curr_possible_error_vector_count = calc_nCr(block_size, num_errors);
		int* current_set_of_error_vectors = (int*)(malloc(curr_possible_error_vector_count * block_size * sizeof(int)));
		int* initial_position_in_set;
		*initial_position_in_set = 0;
		int* placeholder_error_vector = (int*)(malloc(block_size * sizeof(int)));
		generate_error_vectors_fixed_error_numbers(current_set_of_error_vectors, placeholder_error_vector, block_size - 1, num_errors, block_size, initial_position_in_set);
		for (int i = 0; i < num_code_words; i++) {
			int code_word_start_pos = i * (block_size);
			int code_word_end_pos = (i + 1) * (block_size);
			for (int j = code_word_start_pos; j < code_word_end_pos; j++) {
				current_encoded_vector[j - code_word_start_pos] = all_transmitted_code_words[j];
			}
			for (int j = 0; j < curr_possible_error_vector_count; j++) {
				int error_start_pos = j * block_size;
				int error_end_pos = (j + 1) * block_size;
				for (int k = error_start_pos; k < error_end_pos; k++) {
					placeholder_error_vector[k - error_start_pos] = current_set_of_error_vectors[k];
				}
				add_error(current_received_vector, current_encoded_vector, placeholder_error_vector, block_size);
				decode(current_received_vector, current_decoded_vector, block_size);
				int num_errors_after_decoding = calc_errors_after_decoding(current_encoded_vector, current_decoded_vector, block_size);
				if (num_errors_after_decoding < minimum_number_of_errors) {
					minimum_number_of_errors = num_errors_after_decoding;
				}
				if (num_errors_after_decoding > maximum_number_of_errors) {
					maximum_number_of_errors = num_errors_after_decoding;
				}
				average_number_of_errors += num_errors_after_decoding;
				number_of_test_cases++;
				for (int k = 0; k < block_size; k++) {
					fprintf(fptr, "%d ", current_encoded_vector[k]);
				}
				fprintf(fptr, "\t\t\t ");
				for (int k = 0; k < block_size; k++) {
					fprintf(fptr, "%d ", current_received_vector[k]);
				}
				fprintf(fptr, "\t\t\t");
				for (int k = 0; k < block_size; k++) {
					fprintf(fptr, "%d ", current_decoded_vector[k]);
				}
				fprintf(fptr, "\t\t\t   %d", num_errors_after_decoding);
				fprintf(fptr, "\n");
			}
		}
		fprintf(fptr, "Summary\n");
		fprintf(fptr, "Maximum Number of Errors = %d\n", maximum_number_of_errors);
		fprintf(fptr, "Minimum Number of Errors = %d\n", minimum_number_of_errors);
		average_number_of_errors /= number_of_test_cases;
		fprintf(fptr, "Average Number of Errors = %f\n", average_number_of_errors);
		fprintf(fptr, "#################################################################################################################################\n");
		fprintf(fptr, "\n\n");
	}
	fclose(fptr);
}

int main(void) {
	test_system();
	system("vim Multi_Step_MLD_Results.txt");
	return 0;
}
