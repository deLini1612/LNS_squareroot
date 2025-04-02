library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity correction_root_4seg is
    generic (
        FRAC_WIDTH      : positive := 7);
    port (
        x               : in    std_logic_vector(1 downto 0);
        k_mod_2         : in    std_logic;
        k_le_2          : in    std_logic;
        result          : out   std_logic_vector(FRAC_WIDTH - 1 downto 0)
        );
end correction_root_4seg;

architecture b8 of correction_root_4seg is
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
                    when "00" => correction_term <= "0000000";
                    when "01" => correction_term <= "0000010";
                    when "10" => correction_term <= "0000101";
                    when "11" => correction_term <= "0001000";
                    when others => correction_term <= "0000000";
                end case;
            else
                case x is
                    when "00" => correction_term <= "0000111";
                    when "01" => correction_term <= "0000011";
                    when "10" => correction_term <= "0000001";
                    when "11" => correction_term <= "0000000";
                    when others => correction_term <= "0000000";
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(correction_term'left downto (correction_term'left + 1 -FRAC_WIDTH));
end b8;

architecture b16 of correction_root_4seg is
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
                    when "00" => correction_term <= "000000001100111";
                    when "01" => correction_term <= "000001001011111";
                    when "10" => correction_term <= "000010101101000";
                    when "11" => correction_term <= "000100011111100";
                    when others => correction_term <= "000000000000000";
                end case;
            else
                case x is
                    when "00" => correction_term <= "000011110101110";
                    when "01" => correction_term <= "000001101001110";
                    when "10" => correction_term <= "000000100001100";
                    when "11" => correction_term <= "000000000100001";
                    when others => correction_term <= "000000000000000";
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(correction_term'left downto (correction_term'left + 1 -FRAC_WIDTH));
end b16;

architecture b32 of correction_root_4seg is
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
                    when "00" => correction_term <= "0000000011001110111010011111010";
                    when "01" => correction_term <= "0000010010111111000111001110001";
                    when "10" => correction_term <= "0000101011010001110110101000000";
                    when "11" => correction_term <= "0001000111111000011011001011101";
                    when others => correction_term <= "0000000000000000000000000000000";
                end case;
            else
                case x is
                    when "00" => correction_term <= "0000111101011100000100001111010";
                    when "01" => correction_term <= "0000011010011101010011100010010";
                    when "10" => correction_term <= "0000001000011000100110000010011";
                    when "11" => correction_term <= "0000000001000011111000010110000";
                    when others => correction_term <= "0000000000000000000000000000000";
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(correction_term'left downto (correction_term'left + 1 -FRAC_WIDTH));
end b32;

architecture b64 of correction_root_4seg is
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
                    when "00" => correction_term <= "000000001100111011101001111101000101010111101010001010110010100";
                    when "01" => correction_term <= "000001001011111100011100111000110000101010110000000101001100000";
                    when "10" => correction_term <= "000010101101000111011010100000001000100110000100111000101000000";
                    when "11" => correction_term <= "000100011111100001101100101110100111001110001111011101110000000";
                    when others => correction_term <= "000000000000000000000000000000000000000000000000000000000000000";                    
                end case;
            else
                case x is
                    when "00" => correction_term <= "000011110101110000010000111101011110001001011001000100100000000";
                    when "01" => correction_term <= "000001101001110101001110001001001010101100110011100110001000000";
                    when "10" => correction_term <= "000000100001100010011000001001101010001001010000000100011000000";
                    when "11" => correction_term <= "000000000100001111100001011000011001000110110101001001111011000";
                    when others => correction_term <= "000000000000000000000000000000000000000000000000000000000000000";                    
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(correction_term'left downto (correction_term'left + 1 -FRAC_WIDTH));
end b64;