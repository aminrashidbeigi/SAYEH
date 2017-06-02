library IEEE;
use IEEE.std_logic_1164.all;

entity or_co is
    port(
    or_input1, or_input2 : IN std_logic_vector(15 downto 0);
    or_output : OUT std_logic_vector(15 downto 0)
    );
end or_co;

architecture rtl of or_co is
    begin
        process(or_input1, or_input2) is
        begin
            or_output <= or_input1 OR or_input2;
        end process;
end rtl;
