library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity square_root_reg is
generic (
    IN_WIDTH      : positive := 64;
    INDEX_WIDTH   : positive := 6;
    OUT_WIDTH     : positive := 32;
	 NUM_SEG			: positive := 3
    -- OUT_WIDTH = IN_WIDTH/2
    );
port (
    clk                 :   in      std_logic;
    A    		        : 	in 		std_logic_vector(IN_WIDTH - 1 downto 0);
    result              :   out 	std_logic_vector(OUT_WIDTH - 1 downto 0)
    );
end square_root_reg;

architecture add_reg_arc of square_root_reg is
    signal result_D     : std_logic_vector(OUT_WIDTH - 1 downto 0);
    signal A_Q          : std_logic_vector(IN_WIDTH - 1 downto 0);
begin

    UUT :   entity work.square_root_int(a1)
            generic map (
                IN_WIDTH => IN_WIDTH,
                OUT_WIDTH => OUT_WIDTH,
                INDEX_WIDTH => INDEX_WIDTH,
					 NUM_SEG => NUM_SEG
            )
            port map (
                A           =>  A_Q,
                result      =>  result_D);

    AddReg: process(clk)
    begin
        if(rising_edge(clk)) then
            A_Q <= A;
            result <= result_D;
        end if;
    end process;
end architecture add_reg_arc;
