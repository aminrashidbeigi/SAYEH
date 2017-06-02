library IEEE;
use IEEE.std_logic_1164.all;

entity comprator_co is
    port(
    comprator_input1, comprator_input2 : IN std_logic_vector(15 downto 0);
    comprator_cout , comprator_zout : OUT std_logic
    );
end entity comprator_co;

architecture rtl of comprator_co is begin
    process(comprator_input1, comprator_input2) is
    begin
        if (comprator_input1 = comprator_input2) then
            comprator_zout <= '1';
				        comprator_cout <= '0';
        elsif (comprator_input1 > comprator_input2) then
				      comprator_zout <= '0';
				          comprator_cout <= '1';
	      elsif(comprator_input1 < comprator_input2) then
				      comprator_zout <= '0';
				      comprator_cout <= '0';
		    end if;
    end process;
end rtl;
