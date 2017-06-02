LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder is
    port(
        a, b, cin : in STD_LOGIC;
        sum, cout : out STD_LOGIC
    );
end adder;

architecture rtl of adder is
begin
    sum <= (not a and not b and cin) or
         (not a and b and not cin) or
         (a and not b and not cin) or
         (a and b and cin);

    cout <= (not a and b and cin) or
          (a and not b and cin) or
          (a and b and not cin) or
          (a and b and cin);
end rtl;

LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_co is
    port(
    adder_input1, adder_input2 : in STD_LOGIC_VECTOR(15 downto 0);
    adder_cin : in STD_LOGIC;
    adder_output : out STD_LOGIC_VECTOR(15 downto 0);
    adder_cout : out STD_LOGIC
    );
end adder_co;

architecture rtl of adder_co is
    component adder
      port(
          a, b, cin : in STD_LOGIC;
          sum, cout : out STD_LOGIC
      );
    end component;

    signal c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15 : STD_LOGIC;
    begin
        adder0: adder port map (a => adder_input1(0), b => adder_input2(0), cin => adder_cin, sum => adder_output(0), cout => c1);
        adder1: adder port map (a => adder_input1(1), b => adder_input2(1), cin => c1, sum => adder_output(1), cout => c2);
        adder2: adder port map (a => adder_input1(2), b => adder_input2(2), cin => c2, sum => adder_output(2), cout => c3);
        adder3: adder port map (a => adder_input1(3), b => adder_input2(3), cin => c3, sum => adder_output(3), cout => c4);
        adder4: adder port map (a => adder_input1(4), b => adder_input2(4), cin => c4, sum => adder_output(4), cout => c5);
        adder5: adder port map (a => adder_input1(5), b => adder_input2(5), cin => c5, sum => adder_output(5), cout => c6);
        adder6: adder port map (a => adder_input1(6), b => adder_input2(6), cin => c6, sum => adder_output(6), cout => c7);
        adder7: adder port map (a => adder_input1(7), b => adder_input2(7), cin => c7, sum => adder_output(7), cout => c8);
        adder8: adder port map (a => adder_input1(8), b => adder_input2(8), cin => c8, sum => adder_output(8), cout => c9);
        adder9: adder port map (a => adder_input1(9), b => adder_input2(9), cin => c9, sum => adder_output(9), cout => c10);
        adder10: adder port map (a => adder_input1(10), b => adder_input2(10), cin => c10, sum => adder_output(10), cout => c11);
        adder11: adder port map (a => adder_input1(11), b => adder_input2(11), cin => c11, sum => adder_output(11), cout => c12);
        adder12: adder port map (a => adder_input1(12), b => adder_input2(12), cin => c12, sum => adder_output(12), cout => c13);
        adder13: adder port map (a => adder_input1(13), b => adder_input2(13), cin => c13, sum => adder_output(13), cout => c14);
        adder14: adder port map (a => adder_input1(14), b => adder_input2(14), cin => c14, sum => adder_output(14), cout => c15);
        adder15: adder port map (a => adder_input1(15), b => adder_input2(15), cin => c15, sum => adder_output(15), cout => adder_cout);
END rtl;
