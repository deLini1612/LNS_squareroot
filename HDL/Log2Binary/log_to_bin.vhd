library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-- Log2BinaryRoot: Mitchell algorithm to convert LNS -> BNS

entity log_to_bin is
    generic (
        BASE_WIDTH      : positive := 8;
        IN_WIDTH        : positive := 11;
        OUT_WIDTH       : positive := 23
        -- In higher level, when use this module, we should declare a constant IN_WIDTH bases on BASE_WIDTH
        );    
    port (
        din     : in    std_logic_vector(IN_WIDTH - 1 downto 0);
        dout    : out   std_logic_vector(OUT_WIDTH - 1 downto 0)
        );
end log_to_bin;


architecture a1 of log_to_bin is
    constant INDEX_WIDTH  : positive := IN_WIDTH - BASE_WIDTH + 1;
    constant INDEX_OUT    : positive := integer(ceil(log2(real(OUT_WIDTH))));

    signal index_ml1_int    : std_logic_vector(INDEX_WIDTH - 1 downto 0);
    signal int_part         : std_logic_vector(OUT_WIDTH - 1 downto 0);
    signal fraction         : std_logic_vector(OUT_WIDTH - 1 downto 0);
    signal shifted_frac     : std_logic_vector(OUT_WIDTH - 1 downto 0);
    signal shift_int        : std_logic_vector(INDEX_OUT- 1 downto 0);

begin
    index_ml1_int <= din(IN_WIDTH - 1 downto BASE_WIDTH - 1);
    shift_int <= std_logic_vector(resize(unsigned('0' & index_ml1_int) + (BASE_WIDTH - 1), INDEX_OUT));

    BarrelShifterInt : entity work.barrel_shifter(a1)
    generic map (
        IN_WIDTH => OUT_WIDTH,
        CONTROL_WIDTH => INDEX_OUT
    )
    port map (
        din => std_logic_vector(to_unsigned(1, OUT_WIDTH)),
        shift  => shift_int,
        dout => int_part);

    
    fraction <= std_logic_vector(to_unsigned(1, OUT_WIDTH - BASE_WIDTH + 1)) & din(BASE_WIDTH - 2 downto 0);

    BarrelShifterFrac : entity work.barrel_shifter(a1)
    generic map (
        IN_WIDTH => OUT_WIDTH,
        CONTROL_WIDTH => INDEX_WIDTH
    )
    port map (
        din => fraction,
        shift  => index_ml1_int,
        dout => shifted_frac);

    dout <= int_part or shifted_frac;
end a1;