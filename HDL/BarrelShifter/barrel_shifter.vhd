library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- BarrelShifter: a left-shifter with variable shift-value

entity barrel_shifter is
    generic (
        IN_WIDTH : positive := 8;
        CONTROL_WIDTH : positive := 3
        -- In higher level, when use this module, we should declare a constant CONTROL_WIDTH bases on IN_WIDTH
        -- then map the constant into the generic port CONTROL_WIDTH of this module
        -- CONTROL_WIDTH = integer(ceil(log2(real(IN_WIDTH))))
        );    
    port (
        din     : in    std_logic_vector(IN_WIDTH - 1 downto 0);
        shift   : in    std_logic_vector(CONTROL_WIDTH - 1 downto 0);
        dout    : out   std_logic_vector(IN_WIDTH - 1 downto 0)
        );
end barrel_shifter;


architecture a1 of barrel_shifter is
    subtype stage_intermediate is std_logic_vector(IN_WIDTH - 1 downto 0); --intermediate result after each MUX
    type all_intermediate is array (natural range <>) of stage_intermediate;

    signal intermediate : all_intermediate(CONTROL_WIDTH downto 0); --array of intermediate, each for 1 layer
begin
    intermediate(0) <= din;

    -- generate each stage (2-input MUX)
    -- input1: intermediate of prev stage; input2: shifted intermediate of prev stage
    -- control signal: bit value of the shift input
    Gen: for i in 0 to CONTROL_WIDTH - 1 generate
        process(intermediate(i), shift)
        begin
            if (shift(i) = '0') then
                intermediate(i+1) <= intermediate(i);
            else
                intermediate(i+1) <= intermediate(i)((IN_WIDTH - 2**i - 1) downto 0) & ((2**i - 1) downto 0 => '0');
            end if;
        end process;
    end generate;

    dout <= intermediate(CONTROL_WIDTH);
end a1;