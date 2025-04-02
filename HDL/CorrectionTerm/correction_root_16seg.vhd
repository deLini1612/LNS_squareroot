library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity correction_root_16seg is
    generic (
        FRAC_WIDTH      : positive := 7);
    port (
        x               : in    std_logic_vector(3 downto 0);
        k_mod_2         : in    std_logic;
        k_le_2          : in    std_logic;
        result          : out   std_logic_vector(FRAC_WIDTH - 1 downto 0)
        );
end correction_root_16seg;

architecture b8 of correction_root_16seg is
    signal sel_k_small      : std_logic_vector(1 downto 0);
    signal correction_term  : std_logic_vector(6 downto 0);
begin
    sel_k_small <= k_mod_2 & x(x'left); 
    process (x, k_mod_2, k_le_2, sel_k_small)
    begin
        if (k_le_2 = '1') then
            case (sel_k_small) is
                when "00" => correction_term <= "0000000";
                when "01" => correction_term <= "0000000";
                when "10" => correction_term <= "0001010";
                when "11" => correction_term <= "0000001";
                when others => correction_term <= "0000000";
            end case;
        else
            if (k_mod_2 = '0') then
                case x is
                    when "0000" => correction_term <= "0000000";
                    when "0001" => correction_term <= "0000000";
                    when "0010" => correction_term <= "0000000";
                    when "0011" => correction_term <= "0000000";
                    when "0100" => correction_term <= "0000001";
                    when "0101" => correction_term <= "0000010";
                    when "0110" => correction_term <= "0000010";
                    when "0111" => correction_term <= "0000011";
                    when "1000" => correction_term <= "0000100";
                    when "1001" => correction_term <= "0000100";
                    when "1010" => correction_term <= "0000101";
                    when "1011" => correction_term <= "0000110";
                    when "1100" => correction_term <= "0000111";
                    when "1101" => correction_term <= "0001000";
                    when "1110" => correction_term <= "0001001";
                    when "1111" => correction_term <= "0001010";
                    when others => correction_term <= "0000000";
                end case;
            else
                case x is
                    when "0000" => correction_term <= "0001001";
                    when "0001" => correction_term <= "0001000";
                    when "0010" => correction_term <= "0000110";
                    when "0011" => correction_term <= "0000101";
                    when "0100" => correction_term <= "0000100";
                    when "0101" => correction_term <= "0000011";
                    when "0110" => correction_term <= "0000010";
                    when "0111" => correction_term <= "0000010";
                    when "1000" => correction_term <= "0000001";
                    when "1001" => correction_term <= "0000001";
                    when "1010" => correction_term <= "0000000";
                    when "1011" => correction_term <= "0000000";
                    when "1100" => correction_term <= "0000000";
                    when "1101" => correction_term <= "0000000";
                    when "1110" => correction_term <= "0000000";
                    when "1111" => correction_term <= "0000000";
                    when others => correction_term <= "0000000";
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(correction_term'left downto (correction_term'left + 1 -FRAC_WIDTH));
end b8;

architecture b16 of correction_root_16seg is
    signal sel_k_small      : std_logic_vector(1 downto 0);
    signal correction_term  : std_logic_vector(14 downto 0);
begin
    sel_k_small <= k_mod_2 & x(x'left); 
    process (x, k_mod_2, k_le_2, sel_k_small)
    begin
        if (k_le_2 = '1') then
            case (sel_k_small) is
                when "00" => correction_term <= "000000000000000";
                when "01" => correction_term <= "000000000000000";
                when "10" => correction_term <= "000101011100000";
                when "11" => correction_term <= "000000111100111";
                when others => correction_term <= "000000000000000";
            end case;
        else
            if (k_mod_2 = '0') then
                case x is
                    when "0000" => correction_term <= "000000000000111";
                    when "0001" => correction_term <= "000000000110000";
                    when "0010" => correction_term <= "000000001111101";
                    when "0011" => correction_term <= "000000011100111";
                    when "0100" => correction_term <= "000000101101010";
                    when "0101" => correction_term <= "000001000000010";
                    when "0110" => correction_term <= "000001010101100";
                    when "0111" => correction_term <= "000001101100100";
                    when "1000" => correction_term <= "000010000101001";
                    when "1001" => correction_term <= "000010011111000";
                    when "1010" => correction_term <= "000010111010000";
                    when "1011" => correction_term <= "000011010110000";
                    when "1100" => correction_term <= "000011110010110";
                    when "1101" => correction_term <= "000100010000010";
                    when "1110" => correction_term <= "000100101110010";
                    when "1111" => correction_term <= "000101001100101";
                    when others => correction_term <= "000000000000000";
                end case;
            else
                case x is
                    when "0000" => correction_term <= "000100111110101";
                    when "0001" => correction_term <= "000100001001010";
                    when "0010" => correction_term <= "000011011011010";
                    when "0011" => correction_term <= "000010110011101";
                    when "0100" => correction_term <= "000010010001011";
                    when "0101" => correction_term <= "000001110100001";
                    when "0110" => correction_term <= "000001011011010";
                    when "0111" => correction_term <= "000001000110010";
                    when "1000" => correction_term <= "000000110100101";
                    when "1001" => correction_term <= "000000100110000";
                    when "1010" => correction_term <= "000000011010010";
                    when "1011" => correction_term <= "000000010001000";
                    when "1100" => correction_term <= "000000001001111";
                    when "1101" => correction_term <= "000000000100111";
                    when "1110" => correction_term <= "000000000001110";
                    when "1111" => correction_term <= "000000000000001";
                    when others => correction_term <= "000000000000000";
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(correction_term'left downto (correction_term'left + 1 -FRAC_WIDTH));
end b16;

architecture b32 of correction_root_16seg is
    signal sel_k_small      : std_logic_vector(1 downto 0);
    signal correction_term  : std_logic_vector(30 downto 0);
begin
    sel_k_small <= k_mod_2 & x(x'left); 
    process (x, k_mod_2, k_le_2, sel_k_small)
    begin
        if (k_le_2 = '1') then
            case (sel_k_small) is
                when "00" => correction_term <= "0000000000000000000000000000000";
                when "01" => correction_term <= "0000000000000000000000000000000";
                when "10" => correction_term <= "0001010111000000000110100011100";
                when "11" => correction_term <= "0000001111001110110000101100110";
                when others => correction_term <= "0000000000000000000000000000000";
            end case;
        else
            if (k_mod_2 = '0') then
                case x is
                    when "0000" => correction_term <= "0000000000001110101100101001011";
                    when "0001" => correction_term <= "0000000001100001110011000101000";
                    when "0010" => correction_term <= "0000000011111011010101100110010";
                    when "0011" => correction_term <= "0000000111001111110100101000010";
                    when "0100" => correction_term <= "0000001011010101110011110001011";
                    when "0101" => correction_term <= "0000010000000101011110101000001";
                    when "0110" => correction_term <= "0000010101011000010100000110001";
                    when "0111" => correction_term <= "0000011011001000110110011000111";
                    when "1000" => correction_term <= "0000100001010010011110100100101";
                    when "1001" => correction_term <= "0000100111110001010010101110100";
                    when "1010" => correction_term <= "0000101110100001111110001001010";
                    when "1011" => correction_term <= "0000110101100001101011000011100";
                    when "1100" => correction_term <= "0000111100101101111101100100001";
                    when "1101" => correction_term <= "0001000100000100101111100010010";
                    when "1110" => correction_term <= "0001001011100100001101001101010";
                    when "1111" => correction_term <= "0001010011001010110010011010110";
                    when others => correction_term <= "0000000000000000000000000000000";
                end case;
            else
                case x is
                    when "0000" => correction_term <= "0001001111101010101111100110100";
                    when "0001" => correction_term <= "0001000010010101111111101100000";
                    when "0010" => correction_term <= "0000110110110101011001000100000";
                    when "0011" => correction_term <= "0000101100111010001000100110101";
                    when "0100" => correction_term <= "0000100100010111110010011110110";
                    when "0101" => correction_term <= "0000011101000011110100101000110";
                    when "0110" => correction_term <= "0000010110110101010000000011000";
                    when "0111" => correction_term <= "0000010001100100010110111110011";
                    when "1000" => correction_term <= "0000001101001010011110111111001";
                    when "1001" => correction_term <= "0000001001100001110101110010001";
                    when "1010" => correction_term <= "0000000110100101011000001111110";
                    when "1011" => correction_term <= "0000000100010000101011001000011";
                    when "1100" => correction_term <= "0000000010011111110101001000000";
                    when "1101" => correction_term <= "0000000001001111011001111011110";
                    when "1110" => correction_term <= "0000000000011100010110001100110";
                    when "1111" => correction_term <= "0000000000000011111100000111101";
                    when others => correction_term <= "0000000000000000000000000000000";
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(correction_term'left downto (correction_term'left + 1 -FRAC_WIDTH));
end b32;

architecture b64 of correction_root_16seg is
    signal sel_k_small      : std_logic_vector(1 downto 0);
    signal correction_term  : std_logic_vector(62 downto 0);
begin
    sel_k_small <= k_mod_2 & x(x'left); 
    process (x, k_mod_2, k_le_2, sel_k_small)
    begin
        if (k_le_2 = '1') then
            case (sel_k_small) is
                when "00" => correction_term <= "000000000000000000000000000000000000000000000000000000000000000";
                when "01" => correction_term <= "000000000000000000000000000000000000000000000000000000000000000";
                when "10" => correction_term <= "000101011100000000011010001110011111101111010110011111100000000";
                when "11" => correction_term <= "000000111100111011000010110011011000001010011010010111001100000";
                when others => correction_term <= "000000000000000000000000000000000000000000000000000000000000000";
            end case;
        else
            if (k_mod_2 = '0') then
                case x is
                    when "0000" => correction_term <= "000000000000111010110010100101101010111000011101000001100110011";
                    when "0001" => correction_term <= "000000000110000111001100010100011001100100100110100010111011100";
                    when "0010" => correction_term <= "000000001111101101010110011001000011010000010000000101010111000";
                    when "0011" => correction_term <= "000000011100111111010010100001001101110001010101000000011011000";
                    when "0100" => correction_term <= "000000101101010111001111000101110000111001111010111110011110000";
                    when "0101" => correction_term <= "000001000000010101111010100000110110011111110101001001111000000";
                    when "0110" => correction_term <= "000001010101100001010000011000100011110010010010111001010000000";
                    when "0111" => correction_term <= "000001101100100011011001100011110111011110111101010011010100000";
                    when "1000" => correction_term <= "000010000101001001111010010010101011111000111011101011110000000";
                    when "1001" => correction_term <= "000010011111000101001010111010010111110111110110110101110000000";
                    when "1010" => correction_term <= "000010111010000111111000100101001110110010110000100111011000000";
                    when "1011" => correction_term <= "000011010110000110101100001110001111110100110000011001010000000";
                    when "1100" => correction_term <= "000011110010110111110110010000101101000000001010101110110000000";
                    when "1101" => correction_term <= "000100010000010010111110001001001001111001110010001010100000000";
                    when "1110" => correction_term <= "000100101110010000110100110101001110000110100100010101010000000";
                    when "1111" => correction_term <= "000101001100101011001001101011010111111000011100101000100000000";
                    when others => correction_term <= "000000000000000000000000000000000000000000000000000000000000000";                 
                end case;
            else
                case x is
                    when "0000" => correction_term <= "000100111110101010111110011010001111000110110001110010110000000";
                    when "0001" => correction_term <= "000100001001010111111110110000011110001111011000100010110000000";
                    when "0010" => correction_term <= "000011011011010101100100010000011110101011000110001010101000000";
                    when "0011" => correction_term <= "000010110011101000100010011010101100100100010011110001010000000";
                    when "0100" => correction_term <= "000010010001011111001001111011001001010001000101111011100000000";
                    when "0101" => correction_term <= "000001110100001111010010100011010001111100010011111110000000000";
                    when "0110" => correction_term <= "000001011011010101000000001100010000111000011101011000001100000";
                    when "0111" => correction_term <= "000001000110010001011011111001111110101101010111000110001000000";
                    when "1000" => correction_term <= "000000110100101001111011111100100101101100010010111001000010000";
                    when "1001" => correction_term <= "000000100110000111010111001000111111101000101010100000001110000";
                    when "1010" => correction_term <= "000000011010010101100000111111001110111101111011110100010110000";
                    when "1011" => correction_term <= "000000010001000010101100100001110100010010000111000001111000000";
                    when "1100" => correction_term <= "000000001001111111010100100000011010101111101000000111110010000";
                    when "1101" => correction_term <= "000000000100111101100111101111000010110101010100000010000011100";
                    when "1110" => correction_term <= "000000000001110001011000110011011011001010011000110100011001000";
                    when "1111" => correction_term <= "000000000000001111110000011110101011101011111111101001100000011";
                    when others => correction_term <= "000000000000000000000000000000000000000000000000000000000000000";                    
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(correction_term'left downto (correction_term'left + 1 -FRAC_WIDTH));
end b64;