library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library std;
use std.textio.all;

-- brute-force testcase for small width (4,8,16)
entity square_root_int_all_tb is
end square_root_int_all_tb;

architecture a1 of square_root_int_all_tb is
    constant IN_WIDTH      : integer := 32;
    constant NUM_SEG       : integer := 4;
    constant INDEX_WIDTH   : integer := integer(ceil(log2(real(IN_WIDTH))));
    constant OUT_WIDTH     : integer := integer(IN_WIDTH/2);

    signal A        : std_logic_vector(IN_WIDTH - 1 downto 0) := (others => '0');
    signal result   : std_logic_vector(OUT_WIDTH - 1 downto 0);

    file output_file : text open write_mode is "output_results_4s_32b_int.txt";

    function std_logic_vector_to_string(val: std_logic_vector) return string is
        variable result : string(1 to val'length);
    begin
        for i in val'range loop
            if val(i) = '1' then
                result(val'length - i) := '1';
            elsif val(i) = '0' then
                result(val'length - i) := '0';
            else
                result(val'length - i) := 'X'; -- Handle 'X', 'U', 'Z', etc.
            end if;
        end loop;
        return result;
    end function;
    
begin
    uut: entity work.square_root_int(a1)
        generic map (
            IN_WIDTH => IN_WIDTH,
            INDEX_WIDTH => INDEX_WIDTH,
            OUT_WIDTH => OUT_WIDTH,
            NUM_SEG => NUM_SEG
        )
        port map (
            A  => A,
            result => result
        );

    process
        variable i          : unsigned(IN_WIDTH - 1 downto 0) := to_unsigned(1, IN_WIDTH);
        variable line_buf   : line;
    begin
        A <= std_logic_vector(to_unsigned(0, IN_WIDTH));
        wait for 10 ns;
        
        write(line_buf, std_logic_vector_to_string(result));
        writeline(output_file, line_buf);

        TestCase: while i /= to_unsigned(0, IN_WIDTH) loop
            A <= std_logic_vector(i);

            wait for 10 ns;

            write(line_buf, std_logic_vector_to_string(result));
            writeline(output_file, line_buf);
	
	        i := i + 1;
            if (i = to_unsigned(2**22, IN_WIDTH) and (IN_WIDTH > 16)) then
                exit;  -- Breaks if input >= 2**23 (so much data)
            end if;
        end loop;
        wait;
    end process;
end a1;
