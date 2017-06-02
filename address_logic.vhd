library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_unsigned.all;

entity address_logic is
  port (
    PCside , Rside : in std_logic_vector(15 downto 0);
    Iside : in std_logic_vector(7 downto 0);
    ALout : out std_logic_vector(15 downto 0);
    ResetPC, PCplusI, PCplus1, RplusI, Rplus0 : IN std_logic
  );
end entity;

architecture arch of address_logic is

  Constant one : std_logic_vector(4 downto 0) := "10000";
  Constant two : std_logic_vector(4 downto 0) := "01000";
  Constant three : std_logic_vector(4 downto 0) := "00100";
  Constant four : std_logic_vector(4 downto 0) := "00010";
  Constant five : std_logic_vector(4 downto 0) := "00001";

begin
  process(PCside, Rside, Iside, ResetPC,PCplusI, PCplus1, RplusI, Rplus0)
    VARIABLE temp : std_logic_vector (4 DOWNTO 0);
  begin
    temp := (ResetPC & PCplusI & PCplus1 & RplusI & Rplus0);
    case( temp ) is

      WHEN one => ALout <= (OTHERS => '0');
      WHEN two => ALout <= PCside + Iside;
      WHEN three => ALout <= PCside + 1;
      WHEN four => ALout <= Rside + Iside;
      WHEN five => ALout <= Rside;
      WHEN OTHERS => ALout <= PCside;

    end case;
  end process;
end architecture;
