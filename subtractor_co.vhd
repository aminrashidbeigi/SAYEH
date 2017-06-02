LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;

entity subtractor_co IS
     port(
     subtractor_input1, subtractor_input2 : IN  std_logic_vector(15 DOWNTO 0);
     subtractor_cin : IN std_logic;
     subtractor_output : OUT std_logic_vector (15 DOWNTO 0)
     -- overflow : OUT std_logic
     );
end subtractor_co;

architecture Behavioral of subtractor_co is
    signal output_signal : std_logic_vector(15 downto 0);
    BEGIN
        output_signal <= subtractor_input1 - subtractor_input2 - subtractor_cin;
        -- overflow <= '1' when (input1(15)/=input2(15) and output_temp(15)/=input1(15)) else '0';
        subtractor_output <= output_signal;
end Behavioral;
