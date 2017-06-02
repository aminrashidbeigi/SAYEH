library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity multiplier_co is
    port(A : in STD_LOGIC_VECTOR(15 downto 0);
         B : in STD_LOGIC_VECTOR(15 downto 0);
         res : out STD_LOGIC_VECTOR(15 downto 0)
     );
end multiplier_co;

architecture dataflow of multiplier_co is
    component four_bit_multiplier is
        port(a : in STD_LOGIC_VECTOR(3 downto 0);
             b : in STD_LOGIC_VECTOR(3 downto 0);
             ans : out STD_LOGIC_VECTOR(7 downto 0)
         );
    end component;
    component ripple_adder is
    port (A,B:in STD_LOGIC_VECTOR(15 downto 0);
          sum:out STD_LOGIC_VECTOR(15 downto 0);
          cout:out STD_LOGIC;
          command:in STD_LOGIC);
    end component;

    signal s1, s2, s3, s4 : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
    signal mid1, mid2 : STD_LOGIC_VECTOR(15 downto 0);
    signal cout1 : STD_LOGIC;
    signal cout2 : STD_LOGIC;
    signal cout3 : STD_LOGIC;
    signal command : STD_LOGIC := '0';
begin
    AM1 : four_bit_multiplier port map(A(3 downto 0), B(3 downto 0), s1(7 downto 0));
    AM2 : four_bit_multiplier port map(A(7 downto 4), B(3 downto 0), s2(11 downto 4));
    AM3 : four_bit_multiplier port map(A(3 downto 0), B(7 downto 4), s3(11 downto 4));
    AM4 : four_bit_multiplier port map(A(7 downto 4), B(7 downto 4), s4(15 downto 8));

    SUM1: ripple_adder port map(s1, s2, mid1, cout1, command);
    SUM2: ripple_adder port map(s3, s4, mid2, cout2, command);
    SUM3: ripple_adder port map(mid1, mid2, res, cout3, command);

end dataflow;
