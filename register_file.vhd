library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity register_file is
		port(
		databus_in : in std_logic_vector (15 downto 0);
		wp_in: in std_logic_vector (5 downto 0);
		shadow_in : in std_logic_vector (3 downto 0);
		rfl_write : in std_logic;
		rfh_write : in std_logic;
		clk : in std_logic;
		rs : out std_logic_vector (15 downto 0);
		rd : out std_logic_vector (15 downto 0)
		);
end entity;

architecture RTL of register_file is
type register_file is array(0 to 63) of std_logic_vector(15 downto 0);
signal registers : register_file := (others => "1111000000101010");
  begin
    process(clk)
      begin
        if (clk ='1') then
            if(rfl_write = '1') then
                if(rfh_write = '1') then
                  registers(to_integer(unsigned(wp_in)+unsigned(shadow_in(3 downto 2)))) <= databus_in;
                  rd <= databus_in;
                else
                  registers(to_integer(unsigned(wp_in)+unsigned(shadow_in(3 downto 2)))) <= "00000000" & databus_in (7 downto 0);
                  rd <= "00000000" & databus_in (7 downto 0);
                end if;
            elsif(rfh_write = '1') then
                  registers(to_integer(unsigned(wp_in)+unsigned(shadow_in(3 downto 2)))) <= databus_in (7 downto 0) & "00000000";
                  rd <= databus_in (7 downto 0) & "00000000";
            else
                rd <= registers(to_integer(unsigned(wp_in)+unsigned(shadow_in(3 downto 2))));
                rs <= registers(to_integer(unsigned(wp_in)+unsigned(shadow_in(1 downto 0))));
            end if;
        end if;
    end process;
end architecture;
