library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity twos_complement_co is
    port(
    twos_complement_input  : IN  std_logic_vector(15 DOWNTO 0);
    twos_complement_output : OUT std_logic_vector (15 DOWNTO 0)
    );
end twos_complement_co;

architecture rtl of twos_complement_co is
signal temp : std_logic_vector(15 downto 0) := "0000000000000001";
begin
    process(twos_complement_input) is
      begin
        twos_complement_output <= std_logic_vector(unsigned(NOT twos_complement_input) + unsigned(temp));
    end process;

end rtl;
