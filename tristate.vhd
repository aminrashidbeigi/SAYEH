library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tristate is
    port (
    input    : in  std_logic_vector(15 downto 0);
    EN   : in  STD_LOGIC;
    output    : out std_logic_vector(15 downto 0)
    );
end tristate;

architecture rtl of tristate is
begin
    output <= input when (EN = '1') else "ZZZZZZZZZZZZZZZZ";
end rtl;
