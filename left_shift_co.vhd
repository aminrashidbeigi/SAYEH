library IEEE;
use IEEE.std_logic_1164.all;

entity left_shift_co is
    port(
    left_shift_input: in std_logic_vector(15 downto 0);
    left_shift_output: out std_logic_vector(15 downto 0)
    );
end left_shift_co;

architecture rtl of left_shift_co is
  begin
      process(left_shift_input) is
      begin
          left_shift_output(15 downto 1) <= left_shift_input(14 downto 0);
          left_shift_output(0) <= '0';
      end process;
end rtl;
