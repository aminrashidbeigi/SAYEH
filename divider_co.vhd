library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity divider_co is
port (
    input1 : in std_logic_vector (15 downto 0);
    input2:  in std_logic_vector (15 downto 0);
    output:  out std_logic_vector (15 downto 0)
	 );
end divider_co;

architecture Behavioral of divider_co is

signal a,b: integer range 0 to 65535;
begin
    a <= conv_integer(input1);
    b <= conv_integer(input2);
    process (a,b)
        variable temp1,temp2: integer range 0 to 65535;
        variable y :  std_logic_vector (15 downto 0);
        begin
            temp1:=a;
            temp2:=b;
            for i in 15 downto 0 loop
                if (temp1>temp2 * 2**i) then
                    y(i):= '1';
                    temp1:= temp1- temp2 * 2**i;
                else y(i):= '0';
                end if;
            end loop;
            output <= CONV_STD_LOGIC_VECTOR (temp1 ,16) + y;
    end process;
end Behavioral;
