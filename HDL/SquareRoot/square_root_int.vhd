library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity square_root_int is
    generic (
        IN_WIDTH      : positive := 8;
        INDEX_WIDTH   : positive := 3;
        OUT_WIDTH     : positive := 4;
        NUM_SEG       : positive := 3
        -- OUT_WIDTH = IN_WIDTH/2
        );    
    port (
        A         : in    std_logic_vector(IN_WIDTH - 1 downto 0);
        result    : out   std_logic_vector(OUT_WIDTH - 1 downto 0)
        );
end square_root_int;

architecture a1 of square_root_int is
    signal valid        : std_logic;
    signal log_A        : std_logic_vector(INDEX_WIDTH + IN_WIDTH - 2 downto 0);
    signal k_le_2       : std_logic;
    signal correction   : std_logic_vector(IN_WIDTH - 2 downto 0);
    signal log_result   : std_logic_vector(INDEX_WIDTH + IN_WIDTH - 3 downto 0);
    signal result_buff  : std_logic_vector(OUT_WIDTH + IN_WIDTH - 2 downto 0);
    signal result_int  	: std_logic_vector(OUT_WIDTH - 1 downto 0);

begin

    Bin2Log : entity work.bin_to_log(a1)
    generic map (
        IN_WIDTH => IN_WIDTH,
        INDEX_WIDTH => INDEX_WIDTH
    )
    port map (
        din => A,
        valid  => valid,
        dout => log_A);

    
    k_le_2 <= '1' when unsigned(A(IN_WIDTH - 1 downto 2)) = 0 else '0';
        
    GenCorTerm64 : if (IN_WIDTH = 64) and (NUM_SEG = 3) generate
        CorTerm64_8 : entity work.correction_root_8seg(b64)
        generic map (
            FRAC_WIDTH => IN_WIDTH - 1
        )
        port map (
            x => log_A(IN_WIDTH - 2 downto IN_WIDTH - 1 - NUM_SEG),
            k_mod_2  => log_A(IN_WIDTH - 1),
            k_le_2 => k_le_2,
            result => correction);
    end generate;

    GenCorTerm32 : if (IN_WIDTH = 32) and (NUM_SEG = 3) generate
        CorTerm32_8 : entity work.correction_root_8seg(b32)
        generic map (
            FRAC_WIDTH => IN_WIDTH - 1
        )
        port map (
            x => log_A(IN_WIDTH - 2 downto IN_WIDTH - 1 - NUM_SEG),
            k_mod_2  => log_A(IN_WIDTH - 1),
            k_le_2 => k_le_2,
            result => correction);
    end generate;

    GenCorTerm16 : if (IN_WIDTH < 32) and (NUM_SEG = 3) generate
        CorTerm16_8 : entity work.correction_root_8seg(b16)
        generic map (
            FRAC_WIDTH => IN_WIDTH - 1
        )
        port map (
            x => log_A(IN_WIDTH - 2 downto IN_WIDTH - 1 - NUM_SEG),
            k_mod_2  => log_A(IN_WIDTH - 1),
            k_le_2 => k_le_2,
            result => correction);
    end generate;

    GenCorTerm64_16 : if (IN_WIDTH = 64) and (NUM_SEG = 4) generate
        CorTerm64_16 : entity work.correction_root_16seg(b64)
        generic map (
            FRAC_WIDTH => IN_WIDTH - 1
        )
        port map (
            x => log_A(IN_WIDTH - 2 downto IN_WIDTH - 1 - NUM_SEG),
            k_mod_2  => log_A(IN_WIDTH - 1),
            k_le_2 => k_le_2,
            result => correction);
    end generate;

    GenCorTerm32_16 : if (IN_WIDTH = 32) and (NUM_SEG = 4) generate
        CorTerm32_16 : entity work.correction_root_16seg(b32)
        generic map (
            FRAC_WIDTH => IN_WIDTH - 1
        )
        port map (
            x => log_A(IN_WIDTH - 2 downto IN_WIDTH - 1 - NUM_SEG),
            k_mod_2  => log_A(IN_WIDTH - 1),
            k_le_2 => k_le_2,
            result => correction);
    end generate;

    GenCorTerm16_16 : if (IN_WIDTH < 32) and (NUM_SEG = 4) generate
        CorTerm16_16 : entity work.correction_root_16seg(b16)
        generic map (
            FRAC_WIDTH => IN_WIDTH - 1
        )
        port map (
            x => log_A(IN_WIDTH - 2 downto IN_WIDTH - 1 - NUM_SEG),
            k_mod_2  => log_A(IN_WIDTH - 1),
            k_le_2 => k_le_2,
            result => correction);
    end generate;
            
    log_result <= std_logic_vector(resize(unsigned(log_A(INDEX_WIDTH + IN_WIDTH - 2 downto 1)) - unsigned(correction),log_result'length));

    Log2Bin : entity work.log_to_bin(a1)
        generic map (
            BASE_WIDTH => IN_WIDTH,
            IN_WIDTH => INDEX_WIDTH + IN_WIDTH - 2,
            OUT_WIDTH => OUT_WIDTH + (IN_WIDTH - 1)
        )
        port map (
            din => log_result,
            dout => result_buff);

    result_int <= result_buff(OUT_WIDTH + IN_WIDTH - 2 downto IN_WIDTH - 1) when (result_buff(IN_WIDTH - 2) = '0' or (unsigned(result_buff(OUT_WIDTH + IN_WIDTH - 2 downto IN_WIDTH - 1)) + 1 = 0)) else std_logic_vector(resize(unsigned(result_buff(OUT_WIDTH + IN_WIDTH - 2 downto IN_WIDTH - 1)) + 1, result_int'length));
    result <= result_int when valid = '1' else std_logic_vector(to_unsigned(0, OUT_WIDTH));
end architecture a1;