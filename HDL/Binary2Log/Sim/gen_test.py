import argparse
import random
import math
import numpy as np

def mitchell_b2l(x: int, N: int):
    """Convert x (N-bit) to log representation (N + floor(log2(N-1)) bit) using Mitchell's approximation"""
    if x == 0:
        return -np.inf  # Log of zero is undefined, handle separately
    int_part = int(np.floor(np.log2(x)))
    shift_value = N-int_part-1
    fractional_part = x - (1 << int_part)
    scaled_fractional = (fractional_part) << shift_value
    scaled_int = int_part << (N-1)
    return [scaled_int + scaled_fractional, scaled_fractional]

def generate_test_cases(test_num, width):
    index_width = math.ceil(math.log2(width))
    out_width = index_width + width - 1
    
    with open("input.txt", "w") as input_file, open("golden_output.txt", "w") as output_file:
        for _ in range(test_num):
            rand_in = random.randint(0, (1 << width) - 1)

            binary_str = f"{rand_in:0{width}b}"
            input_file.write(binary_str + "\n")
            
            # Find golden output
            lns_out, _ = mitchell_b2l(rand_in, width)
            if (lns_out == -np.inf):
                lns_out = 0
                valid = "0"
            else:
                valid = "1"
            output_file.write(f"{lns_out:0{out_width}b}{valid}\n")
    print(f"Generated {test_num} testcases with IN_WIDTH = {width} and OUT_WIDTH = {out_width}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate test cases for priority encoder validation.")
    parser.add_argument("-test_num", type=int, required=True, help="Number of test cases")
    parser.add_argument("-width", type=int, required=True, help="Input bit width")
    args = parser.parse_args()
    
    generate_test_cases(args.test_num, args.width)