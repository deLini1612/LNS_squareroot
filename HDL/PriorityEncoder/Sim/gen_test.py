import argparse
import random
import math

def generate_test_cases(test_num, width):
    out_width = math.ceil(math.log2(width))
    
    with open("input.txt", "w") as input_file, open("golden_output.txt", "w") as output_file:
        for _ in range(test_num):
            rand_in = random.randint(0, (1 << width) - 1)
            binary_str = f"{rand_in:0{width}b}"
            input_file.write(binary_str + "\n")
            
            # Find golden output
            if rand_in == 0:
                valid = "0"
            else:
                valid = "1"
                msb_index = width - binary_str.index("1") - 1
                output_file.write(f"{msb_index:0{out_width}b}{valid}\n")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate test cases for priority encoder validation.")
    parser.add_argument("-test_num", type=int, required=True, help="Number of test cases")
    parser.add_argument("-width", type=int, required=True, help="Input bit width")
    args = parser.parse_args()
    
    generate_test_cases(args.test_num, args.width)