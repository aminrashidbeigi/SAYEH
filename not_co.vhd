library IEEE;
use IEEE.std_logic_1164.all;

entity not_co is
    port(
    not_input : IN std_logic_vector(15 downto 0);
    not_output : OUT std_logic_vector(15 downto 0)
    );
end not_co;

architecture rtl of not_co is
    begin
        process(not_input) is
        begin
            not_output <= not not_input;
        end process;
end rtl;
