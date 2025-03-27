import argparse
import random
import math
import numpy as np

def mitchell_l2b(scaled_log:int, N:int)->float:
    """ Convert Mitchell scaled log representation (N + floor(log2(N-1)) + 1 bit) back to normal representation (2N bit)"""
    index_mostleft_one = scaled_log >> (N-1)
    if (index_mostleft_one < 0):
      index_mostleft_one = 0
    partial1 = 1 << (index_mostleft_one + N - 1)
    remaining_part = scaled_log%(1<<(N-1))
    partial2 = remaining_part << index_mostleft_one
    binformat = partial1 + partial2
    return binformat

def generate_test_cases(test_num, width):
    index_width = math.ceil(math.log2(width))
    sum_log_width = index_width + width
    out_width = 3*width - 1
    
    with open("input.txt", "w") as input_file, open("golden_output.txt", "w") as output_file:
        for _ in range(test_num):
            rand_in = random.randint(0, (1 << sum_log_width) - 1)

            binary_str = f"{rand_in:0{sum_log_width}b}"
            input_file.write(binary_str + "\n")
            
            # Find golden output
            bin_out = mitchell_l2b(rand_in, width)
            output_file.write(f"{bin_out:0{out_width}b}\n")
    print(f"Generated {test_num} testcases with base IN_WIDTH = {width}, input LOG_WIDTH = {sum_log_width} and OUT_WIDTH = {out_width}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate test cases for priority encoder validation.")
    parser.add_argument("-test_num", type=int, required=True, help="Number of test cases")
    parser.add_argument("-width", type=int, required=True, help="Input bit width")
    args = parser.parse_args()
    
    generate_test_cases(args.test_num, args.width)