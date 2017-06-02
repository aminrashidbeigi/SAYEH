library IEEE;
use IEEE.std_logic_1164.all;

entity right_shift_co is
    port(
    right_shift_input: in std_logic_vector(15 downto 0);
    right_shift_output: out std_logic_vector(15 downto 0)
    );
end right_shift_co;

architecture rtl of right_shift_co is
    begin
        process(right_shift_input) is
        begin
            right_shift_output(14 downto 0) <= right_shift_input(15 downto 1);
            right_shift_output(15) <= '0';
        end process;
end rtl;
