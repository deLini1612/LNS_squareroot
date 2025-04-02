library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity correction_root_8seg is
    generic (
        FRAC_WIDTH      : positive := 7);
    port (
        x               : in    std_logic_vector(2 downto 0);
        k_mod_2         : in    std_logic;
        k_le_2          : in    std_logic;
        result          : out   std_logic_vector(FRAC_WIDTH - 1 downto 0)
        );
end correction_root_8seg;

architecture b8 of correction_root_8seg is
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
                    when "000" => correction_term <= "0000000";
                    when "001" => correction_term <= "0000000";
                    when "010" => correction_term <= "0000001";
                    when "011" => correction_term <= "0000011";
                    when "100" => correction_term <= "0000100";
                    when "101" => correction_term <= "0000110";
                    when "110" => correction_term <= "0001000";
                    when "111" => correction_term <= "0001001";
                    when others => correction_term <= "0000000";
                end case;
            else
                case x is
                    when "000" => correction_term <= "0001001";
                    when "001" => correction_term <= "0000110";
                    when "010" => correction_term <= "0000100";
                    when "011" => correction_term <= "0000010";
                    when "100" => correction_term <= "0000001";
                    when "101" => correction_term <= "0000000";
                    when "110" => correction_term <= "0000000";
                    when "111" => correction_term <= "0000000";
                    when others => correction_term <= "0000000";
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(correction_term'left downto (correction_term'left + 1 -FRAC_WIDTH));
end b8;

architecture b16 of correction_root_8seg is
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
                    when "000" => correction_term <= "000000000011100";
                    when "001" => correction_term <= "000000010110010";
                    when "010" => correction_term <= "000000110110110";
                    when "011" => correction_term <= "000001100001000";
                    when "100" => correction_term <= "000010010010000";
                    when "101" => correction_term <= "000011001000000";
                    when "110" => correction_term <= "000100000001100";
                    when "111" => correction_term <= "000100111101011";
                    when others => correction_term <= "000000000000000";
                end case;
            else
                case x is
                    when "000" => correction_term <= "000100100100000";
                    when "001" => correction_term <= "000011000111011";
                    when "010" => correction_term <= "000010000010110";
                    when "011" => correction_term <= "000001010000110";
                    when "100" => correction_term <= "000000101101011";
                    when "101" => correction_term <= "000000010101101";
                    when "110" => correction_term <= "000000000111011";
                    when "111" => correction_term <= "000000000001000";
                    when others => correction_term <= "000000000000000";                    
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(correction_term'left downto (correction_term'left + 1 -FRAC_WIDTH));
end b16;

architecture b32 of correction_root_8seg is
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
                    when "000" => correction_term <= "0000000000111000001111110111010";
                    when "001" => correction_term <= "0000000101100101100101000111010";
                    when "010" => correction_term <= "0000001101101101101001001100110";
                    when "011" => correction_term <= "0000011000010000100101001111100";
                    when "100" => correction_term <= "0000100100100001111000101001101";
                    when "101" => correction_term <= "0000110010000001110100100110011";
                    when "110" => correction_term <= "0001000000011001010110100011001";
                    when "111" => correction_term <= "0001001111010111011111110100000";
                    when others => correction_term <= "0000000000000000000000000000000";
                end case;
            else
                case x is
                    when "000" => correction_term <= "0001001001000000010111101001010";
                    when "001" => correction_term <= "0000110001110111110000110101011";
                    when "010" => correction_term <= "0000100000101101110011100011110";
                    when "011" => correction_term <= "0000010100001100110011100000110";
                    when "100" => correction_term <= "0000001011010110001010011000101";
                    when "101" => correction_term <= "0000000101011011000001101100001";
                    when "110" => correction_term <= "0000000001110111100111100001111";
                    when "111" => correction_term <= "0000000000010000001001001010010";
                    when others => correction_term <= "0000000000000000000000000000000";
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(correction_term'left downto (correction_term'left + 1 -FRAC_WIDTH));
end b32;

architecture b64 of correction_root_8seg is
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
                    when "000" => correction_term <= "000000000011100000111111011101000010001110100001110001101101000";
                    when "001" => correction_term <= "000000010110010110010100011101001000100000110010100011110111000";
                    when "010" => correction_term <= "000000110110110110100100110011010011101100111000000100101100000";
                    when "011" => correction_term <= "000001100001000010010100111110001101101000101000000111001000000";
                    when "100" => correction_term <= "000010010010000111100010100110100001111000011001010001101000000";
                    when "101" => correction_term <= "000011001000000111010010011001101111010011110000100000101000000";
                    when "110" => correction_term <= "000100000001100101011010001100111011011100111110011100100000000";
                    when "111" => correction_term <= "000100111101011101111111010000010010111111100000011110110000000";
                    when others => correction_term <= "000000000000000000000000000000000000000000000000000000000000000";                 
                end case;
            else
                case x is
                    when "000" => correction_term <= "000100100100000001011110100101010110101011000101001011000000000";
                    when "001" => correction_term <= "000011000111011111000011010101100101100111101100111110000000000";
                    when "010" => correction_term <= "000010000010110111001110001111001101100110101100111100110000000";
                    when "011" => correction_term <= "000001010000110011001110000011000111110010111010001111000000000";
                    when "100" => correction_term <= "000000101101011000101001100010110010101010011110101100100100000";
                    when "101" => correction_term <= "000000010101101100000110110000100001101000000001011011001100000";
                    when "110" => correction_term <= "000000000111011110011110000111101110110010011110000100100111010";
                    when "111" => correction_term <= "000000000001000000100100101001000011011011001100001111100011010";
                    when others => correction_term <= "000000000000000000000000000000000000000000000000000000000000000";                 
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(correction_term'left downto (correction_term'left + 1 -FRAC_WIDTH));
end b64;