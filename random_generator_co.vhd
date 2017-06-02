library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;

entity random_generator_co is
	port(
	output : OUT std_logic_vector(15 downto 0)
	);
end random_generator_co;

architecture behavior of random_generator_co is

signal rand_num : integer := 0;

begin
process
    variable seed1, seed2: positive;
    variable rand: real;
    variable range_of_rand : real := 64000.0;
begin
    uniform(seed1, seed2, rand);
    output <= std_logic_vector(to_unsigned(integer(rand*range_of_rand), 16));
 	 wait for 10 ns;
end process;

end behavior;
