library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Binary2Log: Mitchell algorithm to convert BNS -> LNS

entity bin_to_log is
    generic (
        IN_WIDTH        : positive := 8;
        INDEX_WIDTH     : positive := 3
        -- In higher level, when use this module, we should declare a constant OUT_WIDTH bases on IN_WIDTH
        -- then map the constant into the generic port OUT_WIDTH of this module
        -- OUT_WIDTH = INDEX_WIDTH + FRAC_WIDTH = integer(ceil(log2(real(IN_WIDTH)))) + (IN_WIDTH - 1)
        );    
    port (
        din     : in    std_logic_vector(IN_WIDTH - 1 downto 0);
        valid   : out   std_logic;
        dout    : out   std_logic_vector(INDEX_WIDTH + IN_WIDTH - 2 downto 0)
        );
end bin_to_log;


architecture a1 of bin_to_log is
    constant OUT_WIDTH  : positive := INDEX_WIDTH + IN_WIDTH - 1;

    signal index_ml1    : std_logic_vector(INDEX_WIDTH - 1 downto 0);
    signal shifted_in   : std_logic_vector(IN_WIDTH - 1 downto 0);
    signal fraction     : std_logic_vector(IN_WIDTH - 2 downto 0);
    signal shift        : std_logic_vector(INDEX_WIDTH - 1 downto 0);
begin

    PriorityEncoder : entity work.priority_encoder(a1)
    generic map (
        IN_WIDTH => IN_WIDTH,
        OUT_WIDTH => INDEX_WIDTH
    )
    port map (
        din => din,
        result  => index_ml1,
        valid => valid);

    shift <= std_logic_vector(IN_WIDTH - 1 - unsigned(index_ml1));

    BarrelShifter : entity work.barrel_shifter(a1)
    generic map (
        IN_WIDTH => IN_WIDTH,
        CONTROL_WIDTH => INDEX_WIDTH
    )
    port map (
        din => din,
        shift  => shift,
        dout => shifted_in);

    fraction <= shifted_in(IN_WIDTH - 2 downto 0);
    dout <= index_ml1 & fraction;

end a1;