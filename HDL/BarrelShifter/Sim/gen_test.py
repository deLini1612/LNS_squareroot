import argparse
import random
import math

def generate_test_cases(test_num, width):
    control_width = math.ceil(math.log2(width))
    
    with open("input.txt", "w") as input_file, open("golden_output.txt", "w") as output_file:
        for _ in range(test_num):
            rand_in = random.randint(0, (1 << width) - 1)
            rand_shift = random.randint(0, (1 << control_width) - 1)

            binary_str = f"{rand_in:0{width}b}{rand_shift:0{control_width}b}"
            input_file.write(binary_str + "\n")
            
            # Find golden output
            shifted_out = (rand_in <<  rand_shift) % (2**width)
            output_file.write(f"{shifted_out:0{width}b}\n")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate test cases for priority encoder validation.")
    parser.add_argument("-test_num", type=int, required=True, help="Number of test cases")
    parser.add_argument("-width", type=int, required=True, help="Input bit width")
    args = parser.parse_args()
    
    generate_test_cases(args.test_num, args.width)