#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void generate_parity_vector(int* information_vector, int* encoded_vector, int block_size, int num_info_bits) {
	int* flip_flop_input = (int*)(malloc(4*sizeof(int)));
	int* flip_flop_output = (int*)(malloc(4*sizeof(int)));
	for(int i = 0; i < block_size - num_info_bits; i++){
		flip_flop_input[i] = 0;
		flip_flop_output[i] = 0;
	
	}
	for(int i = 0;i < num_info_bits;i++){
		flip_flop_input[0] = flip_flop_output[3]^information_vector[2 - i];
		flip_flop_input[1] = flip_flop_output[0];
		flip_flop_input[2] = flip_flop_input[0] ^ flip_flop_output[1];
		flip_flop_input[3] = flip_flop_input[0] ^ flip_flop_output[2];
		for (int j = i; j > 0; j--) {
			encoded_vector[j] = encoded_vector[j - 1];
		}
		encoded_vector[0] = information_vector[num_info_bits - 1 - i];
		flip_flop_output[3] = flip_flop_input[3];
		flip_flop_output[2] = flip_flop_input[2];
		flip_flop_output[1] = flip_flop_input[1];
		flip_flop_output[0] = flip_flop_input[0];
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

void decode(int* received_vector, int* decoded_vector, int block_size, int num_info_bits){
	for(int i=0;i<block_size;i++){
		decoded_vector[i]=received_vector[i];
	
	}
	int num_parity_bits = block_size - num_info_bits;
	int* syndrome_register_inputs = (int*)(malloc(num_parity_bits * sizeof(int)));
	int* syndrome_register_outputs = (int*)(malloc(num_parity_bits * sizeof(int)));
	for (int i = 0; i < num_parity_bits; i++) {
		syndrome_register_inputs[i] = 0;
		syndrome_register_outputs[i] = 0;
	}
	for (int i = 0; i < block_size; i++) {
		syndrome_register_inputs[0] = received_vector[block_size - 1 - i] ^ syndrome_register_outputs[3];
		syndrome_register_inputs[1] = syndrome_register_outputs[0];
		syndrome_register_inputs[2] = syndrome_register_outputs[1] ^ syndrome_register_outputs[3];
		syndrome_register_inputs[3] = syndrome_register_outputs[2] ^ syndrome_register_outputs[3];
		for (int j = 0; j < num_parity_bits; j++) {
			syndrome_register_outputs[j] = syndrome_register_inputs[j];
		}
	}
	int A1 = syndrome_register_outputs[3];
	int A2 = syndrome_register_outputs[1];
	int A3 = syndrome_register_outputs[0] ^ syndrome_register_outputs[2];
	int M = A1&A2 | A2&A3 | A1&A3;
	decoded_vector[block_size - 1] ^= M;
	syndrome_register_inputs[0] = syndrome_register_outputs[3] ^ M;
	int temp = decoded_vector[block_size - 1];
	for (int i = block_size - 1; i > 0; i--) {
		decoded_vector[i] = decoded_vector[i - 1];
	}
	decoded_vector[0] = temp;
	for (int i = 1; i < block_size; i++) {
		syndrome_register_inputs[1] = syndrome_register_outputs[0];
		syndrome_register_inputs[2] = syndrome_register_outputs[1] ^ syndrome_register_outputs[3];
		syndrome_register_inputs[3] = syndrome_register_outputs[2] ^ syndrome_register_outputs[3];
		for (int j = 0; j < num_parity_bits; j++) {
			syndrome_register_outputs[j] = syndrome_register_inputs[j];
		}
		int A1 = syndrome_register_outputs[3];
		int A2 = syndrome_register_outputs[1];
		int A3 = syndrome_register_outputs[0] ^ syndrome_register_outputs[2];
		int M = A1&A2 | A2&A3 | A1&A3;
            	syndrome_register_inputs[0] = syndrome_register_outputs[3] ^ M;
		decoded_vector[block_size - 1] ^= M;
		int temp = decoded_vector[block_size - 1];
		for (int j = block_size - 1; j > 0; j--) {
			decoded_vector[j] = decoded_vector[j - 1];
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

int fact(int x) {
	int result = 1;
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
	fptr = fopen("MLD_7_4_Results.txt", "w");
	int block_size = 7;
	int num_info_bits = 3;
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
		fprintf(fptr, "Transmitted Vector%30s%30s%30s\n", "Received Vector", "Decoded Vector", "Number of Errors");
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
				decode(current_received_vector, current_decoded_vector, block_size, num_info_bits);
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
	system("gedit MLD_7_4_Results.txt");
	return 0;
}
