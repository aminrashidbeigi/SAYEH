library IEEE;
use IEEE.std_logic_1164.all;

entity xor_co is
    port(
    xor_input1, xor_input2 : IN std_logic_vector(15 downto 0);
    xor_output : OUT std_logic_vector(15 downto 0)
    );
end xor_co;

architecture rtl of xor_co is
    begin
        process(xor_input1, xor_input2) is
        begin
            xor_output <= xor_input1 XOR xor_input2;
        end process;
end rtl;
