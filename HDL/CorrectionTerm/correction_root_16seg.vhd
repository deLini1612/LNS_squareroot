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

architecture b64 of correction_root_16seg is
    signal sel_k_small      : std_logic_vector(1 downto 0);
    signal correction_term  : std_logic_vector(62 downto 0);
begin
    sel_k_small <= k_mod_2 & x(3); 
    process (x, k_mod_2, k_le_2, sel_k_small)
    begin
        if (k_le_2 = '1') then
            case (sel_k_small) is
                when "00" => correction_term <= "000000000000000000000000000000000000000000000000000000000000000";
                when "01" => correction_term <= "000000000000000000000000000000000000000000000000000000000000000";
                when "10" => correction_term <= "000101011111011000011001100110000000110001000011001100000000000";
                when "11" => correction_term <= "000001001001100001010001011110100111101100110101011000000000000";
                when others => correction_term <= "000000000000000000000000000000000000000000000000000000000000000";
            end case;
        else
            if (k_mod_2 = '0') then
                case x is
                    when "0000" => correction_term <= "000000000000111010110011101000011001010101010111001011001010010";
                    when "0001" => correction_term <= "000000000110000111101001100011100010111100110010011001111111010";
                    when "0010" => correction_term <= "000000001111110000001001101011011100011010001000111101101011000";
                    when "0011" => correction_term <= "000000011101001000101000111100110111000010001001000011011011000";
                    when "0100" => correction_term <= "000000101101101101111111001001001111100000110111100011001100000";
                    when "0101" => correction_term <= "000001000001000011100111111101010011101000010010010101011000000";
                    when "0110" => correction_term <= "000001010110110010000101111110001100100101011011011011010100000";
                    when "0111" => correction_term <= "000001101110100101111101010101110001011011110000100010100100000";
                    when "1000" => correction_term <= "000010001000001110111111011011001100111000010111010000110000000";
                    when "1001" => correction_term <= "000010100011011111100010101110000001100000100110011111100000000";
                    when "1010" => correction_term <= "000011000000001100000011110100000010110010111111011111010000000";
                    when "1011" => correction_term <= "000011011110001010101101000110111010010111000110001001010000000";
                    when "1100" => correction_term <= "000011111101010011000011100111100110001111100000100010100000000";
                    when "1101" => correction_term <= "000100011101011101110111101010101001000101100100011011000000000";
                    when "1110" => correction_term <= "000100111110100100111000100100010010011001100111111101100000000";
                    when "1111" => correction_term <= "000101100000100010101010101010000000011110011010111001110000000";
                    when others => correction_term <= "000000000000000000000000000000000000000000000000000000000000000";
                end case;
            else
                case x is
                    when "0000" => correction_term <= "000101010000111001010101001001101110111011100110111111100000000";
                    when "0001" => correction_term <= "000100010101111001001111111111111010111010000010101010110000000";
                    when "0010" => correction_term <= "000011100011110100100110100111001001110011101101111011000000000";
                    when "0011" => correction_term <= "000010111001010010010101111111010111100010111001101011111000000";
                    when "0100" => correction_term <= "000010010101001011001010101001000101110001000110010110100000000";
                    when "0101" => correction_term <= "000001110110100101010000111010011000110001010011001101011000000";
                    when "0110" => correction_term <= "000001011100110001010000010000100001001000000100001100011100000";
                    when "0111" => correction_term <= "000001000111000111111010010010100010111111101011011101100100000";
                    when "1000" => correction_term <= "000000110101001000011110010001100011001101001001110000000110000";
                    when "1001" => correction_term <= "000000100110010111010110110001110010010100111110010101100110000";
                    when "1010" => correction_term <= "000000011010011101001010010110011101101111101100110110110000000";
                    when "1011" => correction_term <= "000000010001000101111010010010000010010111101001000100100111000";
                    when "1100" => correction_term <= "000000001010000000011011111000110001101000011001100100100010000";
                    when "1101" => correction_term <= "000000000100111101111001110010010110010010001101101001110001010";
                    when "1110" => correction_term <= "000000000001110001011011010010111100110111001100110111100101101";
                    when "1111" => correction_term <= "000000000000001111110000100011100011001001110101110011110001000";
                    when others => correction_term <= "000000000000000000000000000000000000000000000000000000000000000";
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(62 downto (63-FRAC_WIDTH));
end b64;

architecture b32 of correction_root_16seg is
    signal sel_k_small      : std_logic_vector(1 downto 0);
    signal correction_term  : std_logic_vector(30 downto 0);
begin
    sel_k_small <= k_mod_2 & x(3); 
    process (x, k_mod_2, k_le_2, sel_k_small)
    begin
        if (k_le_2 = '1') then
            case (sel_k_small) is
                when "00" => correction_term <= "0000000000000000000000000000000";
                when "01" => correction_term <= "0000000000000000000000000000000";
                when "10" => correction_term <= "0001010111110110000110011001100";
                when "11" => correction_term <= "0000010010011000010100010111101";
                when others => correction_term <= "0000000000000000000000000000000";
            end case;
        else
            if (k_mod_2 = '0') then
                case x is
                    when "0000" => correction_term <= "0000000000001110101100111010000";
                    when "0001" => correction_term <= "0000000001100001111010011000111";
                    when "0010" => correction_term <= "0000000011111100000010011010110";
                    when "0011" => correction_term <= "0000000111010010001010001111001";
                    when "0100" => correction_term <= "0000001011011011011111110010010";
                    when "0101" => correction_term <= "0000010000010000111001111111010";
                    when "0110" => correction_term <= "0000010101101100100001011111100";
                    when "0111" => correction_term <= "0000011011101001011111010101011";
                    when "1000" => correction_term <= "0000100010000011101111110110110";
                    when "1001" => correction_term <= "0000101000110111111000101011100";
                    when "1010" => correction_term <= "0000110000000011000000111101000";
                    when "1011" => correction_term <= "0000110111100010101011010001101";
                    when "1100" => correction_term <= "0000111111010100110000111001111";
                    when "1101" => correction_term <= "0001000111010111011101111010101";
                    when "1110" => correction_term <= "0001001111101001001110001001000";
                    when "1111" => correction_term <= "0001011000001000101010101010100";
                    when others => correction_term <= "0000000000000000000000000000000";                    
                end case;
            else
                case x is
                    when "0000" => correction_term <= "0001010100001110010101010010011";
                    when "0001" => correction_term <= "0001000101011110010011111111111";
                    when "0010" => correction_term <= "0000111000111101001001101001110";
                    when "0011" => correction_term <= "0000101110010100100101011111110";
                    when "0100" => correction_term <= "0000100101010010110010101010010";
                    when "0101" => correction_term <= "0000011101101001010100001110100";
                    when "0110" => correction_term <= "0000010111001100010100000100001";
                    when "0111" => correction_term <= "0000010001110001111110100100101";
                    when "1000" => correction_term <= "0000001101010010000111100100011";
                    when "1001" => correction_term <= "0000001001100101110101101100011";
                    when "1010" => correction_term <= "0000000110100111010010100101100";
                    when "1011" => correction_term <= "0000000100010001011110100100100";
                    when "1100" => correction_term <= "0000000010100000000110111110001";
                    when "1101" => correction_term <= "0000000001001111011110011100100";
                    when "1110" => correction_term <= "0000000000011100010110110100101";
                    when "1111" => correction_term <= "0000000000000011111100001000111";
                    when others => correction_term <= "0000000000000000000000000000000";
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(30 downto (31-FRAC_WIDTH));
end b32;

architecture b16 of correction_root_16seg is
    signal sel_k_small      : std_logic_vector(1 downto 0);
    signal correction_term  : std_logic_vector(14 downto 0);
begin
    sel_k_small <= k_mod_2 & x(3); 
    process (x, k_mod_2, k_le_2, sel_k_small)
    begin
        if (k_le_2 = '1') then
            case (sel_k_small) is
                when "00" => correction_term <= "000000000000000";
                when "01" => correction_term <= "000000000000000";
                when "10" => correction_term <= "000101011111011";
                when "11" => correction_term <= "000001001001100";
                when others => correction_term <= "000000000000000";
            end case;
        else
            if (k_mod_2 = '0') then
                case x is
                    when "0000" => correction_term <= "000000000000111";
                    when "0001" => correction_term <= "000000000110000";
                    when "0010" => correction_term <= "000000001111110";
                    when "0011" => correction_term <= "000000011101001";
                    when "0100" => correction_term <= "000000101101101";
                    when "0101" => correction_term <= "000001000001000";
                    when "0110" => correction_term <= "000001010110110";
                    when "0111" => correction_term <= "000001101110100";
                    when "1000" => correction_term <= "000010001000001";
                    when "1001" => correction_term <= "000010100011011";
                    when "1010" => correction_term <= "000011000000001";
                    when "1011" => correction_term <= "000011011110001";
                    when "1100" => correction_term <= "000011111101010";
                    when "1101" => correction_term <= "000100011101011";
                    when "1110" => correction_term <= "000100111110100";
                    when "1111" => correction_term <= "000101100000100";
                    when others => correction_term <= "000000000000000";
                end case;
            else
                case x is
                    when "0000" => correction_term <= "000101010000111";
                    when "0001" => correction_term <= "000100010101111";
                    when "0010" => correction_term <= "000011100011110";
                    when "0011" => correction_term <= "000010111001010";
                    when "0100" => correction_term <= "000010010101001";
                    when "0101" => correction_term <= "000001110110100";
                    when "0110" => correction_term <= "000001011100110";
                    when "0111" => correction_term <= "000001000111000";
                    when "1000" => correction_term <= "000000110101001";
                    when "1001" => correction_term <= "000000100110010";
                    when "1010" => correction_term <= "000000011010011";
                    when "1011" => correction_term <= "000000010001000";
                    when "1100" => correction_term <= "000000001010000";
                    when "1101" => correction_term <= "000000000100111";
                    when "1110" => correction_term <= "000000000001110";
                    when "1111" => correction_term <= "000000000000001";
                    when others => correction_term <= "000000000000000";
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(14 downto (15-FRAC_WIDTH));
end b16;