library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library std;
use std.textio.all;

entity log_to_bin_tb is
end log_to_bin_tb;

architecture a1 of log_to_bin_tb is
    constant BASE_WIDTH         : integer := 16;
    constant IN_WIDTH           : integer := integer(ceil(log2(real(BASE_WIDTH)))) + BASE_WIDTH;
    constant INDEX_WIDTH  	    : integer := IN_WIDTH - BASE_WIDTH + 1;
    constant OUT_WIDTH          : integer := 3*BASE_WIDTH - 1;
    constant TEST_NUM           : integer := 1000;

    signal din      : std_logic_vector(IN_WIDTH - 1 downto 0);
    signal dout     : std_logic_vector(OUT_WIDTH - 1 downto 0);

    file input_file       : text open read_mode is "input.txt";
    file golden_file      : text open read_mode is "golden_output.txt";

    function to_stdlogicvector(
        str : in string;  -- binary string input
        vector_length : in integer -- the desired length of std_logic_vector
    ) return std_logic_vector is
        variable result : std_logic_vector(vector_length-1 downto 0);
        variable i : integer;
    begin
        -- Initialize the result vector with '0's
        result := (others => '0');
        
        -- Loop through the string, starting from the most significant bit
        for i in 0 to vector_length-1 loop
            if str(i+1) = '1' then
                result(vector_length-1-i) := '1';
            else
                result(vector_length-1-i) := '0';
            end if;
        end loop;
        
        return result;
    end function;
begin

    UUT : entity work.log_to_bin(a1)
        generic map (
            BASE_WIDTH => BASE_WIDTH,
            IN_WIDTH => IN_WIDTH,
            OUT_WIDTH => OUT_WIDTH
        )
        port map (
            din => din,
            dout => dout)
        ;

    process
        variable input_line     : line;
        variable golden_line    : line;
        variable temp_in_str    : string(1 to IN_WIDTH); -- String with length IN_WIDTH
        variable temp_out_str   : string(1 to OUT_WIDTH); -- String with length OUT_WIDTH
        variable input_data     : std_logic_vector(IN_WIDTH - 1 downto 0);
        variable golden_output  : std_logic_vector(OUT_WIDTH - 1 downto 0);
        variable error_cnt      : integer := 0;
    begin
        for i in 0 to TEST_NUM - 1 loop
            -- Read input and golden output
            readline(input_file, input_line);
            readline(golden_file, golden_line);
            read(input_line, temp_in_str);
            input_data := to_stdlogicvector(temp_in_str, IN_WIDTH);
            read(golden_line, temp_out_str);
            golden_output := to_stdlogicvector(temp_out_str, OUT_WIDTH);

            din <= input_data;
            wait for 10 ns;

            -- Compare output
            if dout /= golden_output then
                report "Mismatch: Wrong output"
                    severity error;
                error_cnt := error_cnt + 1;
            end if;
        end loop;

        report "Simulation completed: Accuracy = " & integer'image(TEST_NUM-error_cnt) & "/" & integer'image(TEST_NUM);
        
        wait;
    end process;    
end a1;