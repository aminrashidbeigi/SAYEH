library IEEE;
use IEEE.std_logic_1164.all;

entity flags is
    port(
    cin : IN std_logic;
    zin : IN std_logic;
    clk : IN std_logic;
    c_set : IN std_logic;
    c_reset : IN std_logic;
    z_set : IN std_logic;
    z_reset : IN std_logic;
    sr_load : IN std_logic;
    cout : OUT std_logic;
    zout : OUT std_logic
    );
end flags;

architecture rtl of flags is
    signal cout_signal, zout_signal : std_logic := '0';
    begin
        process(clk, c_set, c_reset, z_set, z_reset, sr_load) is
        begin
            if (rising_edge(clk)) then
                if (sr_load = '1') then
                    cout_signal <= cout_signal;
                    zout_signal <= zout_signal;
                end if;
                if (c_set = '1') then
                    cout_signal <= '1';
                    zout_signal <= zout_signal;
                elsif (c_reset = '1') then
                    cout_signal <= '0';
                    zout_signal <= zout_signal;
                end if;
                if (z_set = '1') then
                    cout_signal <= cout_signal;
                    zout_signal <= '1';
                elsif (z_reset = '1') then
                    cout_signal <= cout_signal;
                    zout_signal <= '0';
                end if;
          end if;
          end process;

        cout <= cout_signal;
        zout <= zout_signal;
end rtl;
