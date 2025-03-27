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

architecture b16 of correction_root_8seg is
    signal sel_k_small      : std_logic_vector(1 downto 0);
    signal correction_term  : std_logic_vector(14 downto 0);
begin
    sel_k_small <= k_mod_2 & x(2); 
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
                    when "000" => correction_term <= "000000000011100";
                    when "001" => correction_term <= "000000010110011";
                    when "010" => correction_term <= "000000110111011";
                    when "011" => correction_term <= "000001100010101";
                    when "100" => correction_term <= "000010010101110";
                    when "101" => correction_term <= "000011001111001";
                    when "110" => correction_term <= "000100001101011";
                    when "111" => correction_term <= "000101001111100";
                    when others => correction_term <= "000000000000000";
                end case;
            else
                case x is
                    when "000" => correction_term <= "000100110011011";
                    when "001" => correction_term <= "000011001110100";
                    when "010" => correction_term <= "000010000101111";
                    when "011" => correction_term <= "000001010001111";
                    when "100" => correction_term <= "000000101101101";
                    when "101" => correction_term <= "000000010101110";
                    when "110" => correction_term <= "000000000111011";
                    when "111" => correction_term <= "000000000001000";
                    when others => correction_term <= "000000000000000";
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(14 downto (15-FRAC_WIDTH));
end b16;

architecture b32 of correction_root_8seg is
    signal sel_k_small      : std_logic_vector(1 downto 0);
    signal correction_term  : std_logic_vector(30 downto 0);
begin
    sel_k_small <= k_mod_2 & x(2); 
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
                    when "000" => correction_term <= "0000000000111000010011101001011";
                    when "001" => correction_term <= "0000000101100111000110010101000";
                    when "010" => correction_term <= "0000001101110110001100111000110";
                    when "011" => correction_term <= "0000011000101011000000011010011";
                    when "100" => correction_term <= "0000100101011101110100010001001";
                    when "101" => correction_term <= "0000110011110010110110000111010";
                    when "110" => correction_term <= "0001000011010110000111011010010";
                    when "111" => correction_term <= "0001010011111000111100011001110";
                    when others => correction_term <= "0000000000000000000000000000000";
                end case;
            else
                case x is
                    when "000" => correction_term <= "0001001100110110010100101001001";
                    when "001" => correction_term <= "0000110011101000110111100100110";
                    when "010" => correction_term <= "0000100001011110000011011100011";
                    when "011" => correction_term <= "0000010100011111001001010100011";
                    when "100" => correction_term <= "0000001011011011111110101000011";
                    when "101" => correction_term <= "0000000101011100011000100101000";
                    when "110" => correction_term <= "0000000001110111110010101101011";
                    when "111" => correction_term <= "0000000000010000001001011110110";
                    when others => correction_term <= "0000000000000000000000000000000";
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(30 downto (31-FRAC_WIDTH));
end b32;

architecture b64 of correction_root_8seg is
    signal sel_k_small      : std_logic_vector(1 downto 0);
    signal correction_term  : std_logic_vector(62 downto 0);
begin
    sel_k_small <= k_mod_2 & x(2); 
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
							when "000" => correction_term <= "000000000011100001001110100101111110001001000100110010100010001";
							when "001" => correction_term <= "000000010110011100011001010100001001101110001001000001101111000";
							when "010" => correction_term <= "000000110111011000110011100011010001100100100100111100010110000";
							when "011" => correction_term <= "000001100010101100000001101001111111000000100110000000000000000";
							when "100" => correction_term <= "000010010101110111010001000100100111001100011110111001011000000";
							when "101" => correction_term <= "000011001111001011011000011101011110100101000010110100011000000";
							when "110" => correction_term <= "000100001101011000011101101001000111101010100010011110100000000";
							when "111" => correction_term <= "000101001111100011110001100111001001011100000001011011010000000";
							when others => correction_term <= "000000000000000000000000000000000000000000000000000000000000000";
                end case;
            else
                case x is
							when "000" => correction_term <= "000100110011011001010010100100110100111010110100110100110000000";
							when "001" => correction_term <= "000011001110100011011110010011010000101011010011110011010000000";
							when "010" => correction_term <= "000010000101111000001101110001101111010001001100110010100000000";
							when "011" => correction_term <= "000001010001111100100101010001100010000011110111110100101000000";
							when "100" => correction_term <= "000000101101101111111010100001101010110001000100000010010100000";
							when "101" => correction_term <= "000000010101110001100010010100010000000011101010111110000000000";
							when "110" => correction_term <= "000000000111011111001010110101100011111101010011100110111011110";
							when "111" => correction_term <= "000000000001000000100101111011010000000000100001010101001111011";
							when others => correction_term <= "000000000000000000000000000000000000000000000000000000000000000";
                end case;
            end if;
        end if;
    end process;

    result <= correction_term(62 downto (63-FRAC_WIDTH));
end b64;