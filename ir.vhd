library IEEE;
use IEEE.std_logic_1164.all;

entity ir is
    port(
    ir_in : IN std_logic_vector(15 downto 0);
    ir_load : IN std_logic;
    clk : IN std_logic;
    ir_out: OUT std_logic_vector(15 downto 0)
    );
end ir;

architecture rtl of ir is
    signal ir_signal : std_logic_vector(15 downto 0) := "0000000000000000";
    begin
        process(clk, ir_load) is
        begin
            if (rising_edge(clk)) then
                if (ir_load = '1') then
                    ir_signal <= ir_in;
                -- elsif (wp_preset = '1') then
                --     ir_signal <= "000000";
                end if;
            end if;
        end process;

        ir_out <= ir_signal;
end rtl;
