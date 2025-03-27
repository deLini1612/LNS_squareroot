library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library std;
use std.textio.all;

entity bin_to_log_tb is
end bin_to_log_tb;

architecture a1 of bin_to_log_tb is
    constant IN_WIDTH           : integer := 16;
    constant INDEX_WIDTH        : integer := integer(ceil(log2(real(IN_WIDTH))));
    constant TEST_NUM           : integer := 1000;

    signal din      : std_logic_vector(IN_WIDTH - 1 downto 0);
    signal valid    : std_logic;
    signal dout     : std_logic_vector(INDEX_WIDTH + IN_WIDTH - 2 downto 0);

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

    UUT : entity work.bin_to_log(a1)
        generic map (
            IN_WIDTH => IN_WIDTH,
            INDEX_WIDTH => INDEX_WIDTH
        )
        port map (
            din => din,
            valid  => valid,
            dout => dout)
        ;

    process
        variable input_line     : line;
        variable golden_line    : line;
        variable temp_in_str    : string(1 to IN_WIDTH); -- String with length IN_WIDTH
        variable temp_out_str   : string(1 to INDEX_WIDTH + IN_WIDTH); -- String with length INDEX_WIDTH + IN_WIDTH
        variable input_data     : std_logic_vector(IN_WIDTH - 1 downto 0);
        variable golden_output  : std_logic_vector(INDEX_WIDTH + IN_WIDTH - 1 downto 0);
        variable golden_valid   : std_logic;
        variable error_cnt      : integer := 0;
    begin
        for i in 0 to TEST_NUM - 1 loop
            -- Read input and golden output
            readline(input_file, input_line);
            readline(golden_file, golden_line);
            read(input_line, temp_in_str);
            input_data := to_stdlogicvector(temp_in_str, IN_WIDTH);
            read(golden_line, temp_out_str);
            golden_output := to_stdlogicvector(temp_out_str, INDEX_WIDTH + IN_WIDTH); --format: result & valid

            din <= input_data;
            wait for 10 ns;

            -- Compare output
            if valid /= golden_output(0) then
                report "Mismatch: Wrong valid"
                    severity error;
                error_cnt := error_cnt + 1;
            else
                if dout /= golden_output(INDEX_WIDTH + IN_WIDTH - 1 downto 1) then
                    report "Mismatch: Wrong result"
                        severity error;
                    error_cnt := error_cnt + 1;
                end if;
            end if;

        end loop;

        report "Simulation completed: Accuracy = " & integer'image(TEST_NUM-error_cnt) & "/" & integer'image(TEST_NUM);
        
        wait;
    end process;    
end a1;