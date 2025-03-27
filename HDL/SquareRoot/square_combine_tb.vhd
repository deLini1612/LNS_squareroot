library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library std;
use std.textio.all;

-- only square testcase
entity square_combine_tb is
end square_combine_tb;

architecture a1 of square_combine_tb is
    constant IN_WIDTH           : integer := 16;
    constant INDEX_WIDTH        : integer := integer(ceil(log2(real(IN_WIDTH))));
    constant OUT_WIDTH_FIXED    : integer := integer(IN_WIDTH/2 + IN_WIDTH - 1);
    constant OUT_WIDTH_INT      : integer := integer(IN_WIDTH/2);

    signal A                : std_logic_vector(IN_WIDTH - 1 downto 0) := (others => '0');
    signal result_fixed     : std_logic_vector(OUT_WIDTH_FIXED - 1 downto 0);
    signal result_int       : std_logic_vector(OUT_WIDTH_INT - 1 downto 0);
begin
    uut_fixed: entity work.square_root(a1)
        generic map (
            IN_WIDTH => IN_WIDTH,
            INDEX_WIDTH => INDEX_WIDTH,
            OUT_WIDTH => OUT_WIDTH_FIXED
        )
        port map (
            A  => A,
            result => result_fixed
        );

        uut_int: entity work.square_root_int(a1)
        generic map (
            IN_WIDTH => IN_WIDTH,
            INDEX_WIDTH => INDEX_WIDTH,
            OUT_WIDTH => OUT_WIDTH_INT
        )
        port map (
            A  => A,
            result => result_int
        );
    process
        variable i : unsigned(IN_WIDTH - 1 downto 0) := to_unsigned(1, IN_WIDTH);
    begin
        A <= std_logic_vector(to_unsigned(0, IN_WIDTH));
        wait for 10 ns;

        TestCase: while i /= to_unsigned(0, IN_WIDTH)  loop
            A <= std_logic_vector(i);

            wait for 10 ns;
	
	    i := i + 1;
        end loop;
        wait;
    end process;
end a1;
