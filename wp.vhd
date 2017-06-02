library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity wp is
    port(
    ir_out : IN std_logic_vector(5 downto 0);
    wp_add : IN std_logic;
    wp_reset : IN std_logic;
    clk : IN std_logic;
    wp_out: OUT std_logic_vector(5 downto 0)
    );
end wp;

architecture rtl of wp is
    signal wp_signal : std_logic_vector(5 downto 0);
    begin
        process(clk, wp_add, wp_reset) is
        begin
            if (rising_edge(clk)) then
                if (wp_add = '1') then
                    wp_signal <= std_logic_vector(unsigned(wp_signal) + unsigned(ir_out));
                elsif (wp_reset = '1') then
                    wp_signal <= "000000";
                end if;
          end if;
        end process;

        wp_out <= wp_signal;
end rtl;
