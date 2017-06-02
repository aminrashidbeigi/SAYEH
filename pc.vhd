library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pc is
    port(
        EnablePC : IN std_logic;
        input : IN std_logic_vector(15 downto 0);
        clk : IN std_logic;
        output : OUT std_logic_vector(15 downto 0)
    );
end entity pc;

architecture dataflow of pc IS begin
    process(clk) begin
        if (clk = '1') then
            if (EnablePC = '1') then
                output <= input;
            end if ; --EnablePC
        end if ; --clk
    end process ; -- process
end dataflow;
