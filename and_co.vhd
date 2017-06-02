library IEEE;
use IEEE.std_logic_1164.all;

entity and_co is
    port(
    and_input1, and_input2 : IN std_logic_vector(15 downto 0);
    and_output : OUT std_logic_vector(15 downto 0)
    );
end and_co;

architecture rtl of and_co is
    begin
        process(and_input1, and_input2) is
        begin
            and_output <= and_input1 AND and_input2;
        end process;
end rtl;
