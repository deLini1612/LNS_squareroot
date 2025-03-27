library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library std;
use std.textio.all;

-- only-square testcase
entity square_root_int_tb is
end square_root_int_tb;

architecture a1 of square_root_int_tb is
    constant IN_WIDTH      : integer := 32;
    constant NUM_SEG       : integer := 4;
    constant INDEX_WIDTH   : integer := integer(ceil(log2(real(IN_WIDTH))));
    constant OUT_WIDTH     : integer := integer(IN_WIDTH/2);

    signal A        : std_logic_vector(IN_WIDTH - 1 downto 0) := (others => '0');
    signal result   : std_logic_vector(OUT_WIDTH - 1 downto 0);

    file output_file : text open write_mode is "output_results_4seg_32bit.txt";
    file error_file  : text open write_mode is "error_log_4seg_32bit.txt";
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
        variable i          : unsigned(OUT_WIDTH - 1 downto 0) := to_unsigned(1, OUT_WIDTH);
        variable input      : unsigned(IN_WIDTH - 1 downto 0);
        variable error      : integer;
        variable line_buf   : line;
        variable error_buf  : line;
    begin
        A <= std_logic_vector(to_unsigned(0, IN_WIDTH));
        wait for 10 ns;
        error := to_integer(0 - unsigned(result));
        
        write(line_buf, to_integer(unsigned(result)));
        write(error_buf, error);
        writeline(output_file, line_buf);
        writeline(error_file, error_buf);

        TestCase: while i /= to_unsigned(0, OUT_WIDTH)  loop
            input := i*i;
            A <= std_logic_vector(input);

            wait for 10 ns;
            error := to_integer(signed(i) - signed(result));

            write(line_buf, to_integer(unsigned(result)));
            write(error_buf, error);
            writeline(output_file, line_buf);
            writeline(error_file, error_buf);
	
	    i := i + 1;
        end loop;
        wait;
    end process;
end a1;
