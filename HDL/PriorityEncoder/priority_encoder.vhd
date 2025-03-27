library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Priority Encoder: return the index of most left '1', if there is no '1', return valid = 0

entity priority_encoder is
    generic (
        IN_WIDTH : positive := 8;
        OUT_WIDTH : positive := 3
        -- In higher level, when use this module, we should declare a constant OUT_WIDTH bases on IN_WIDTH
        -- then map the constant into the generic port OUT_WIDTH of this module
        -- OUT_WIDTH = integer(ceil(log2(real(IN_WIDTH))))
        );    
    port (
        din     : in    std_logic_vector(IN_WIDTH - 1 downto 0);
        result  : out   std_logic_vector(OUT_WIDTH - 1 downto 0);
        valid   : out   std_logic
        );
end priority_encoder;


architecture a1 of priority_encoder is
begin
    process(din)
    begin
        result <= (others => '0');
        valid  <= '0';
        for i in 0 to (IN_WIDTH-1) loop
            if (din(i) = '1') then
                result <= std_logic_vector(to_unsigned(i, OUT_WIDTH));
                valid  <= '1';
            end if;
        end loop;
    end process;
end a1;