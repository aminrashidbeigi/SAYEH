library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY au IS
    PORT (
    Rside : IN std_logic_vector (15 DOWNTO 0);
    Iside : IN std_logic_vector (7 DOWNTO 0);
    Address : OUT std_logic_vector (15 DOWNTO 0);
    clk, ResetPC, PCplusI, PCplus1 : IN std_logic;
    RplusI, Rplus0, EnablePC : IN std_logic
    );
END au;

ARCHITECTURE dataflow OF au IS
    COMPONENT pc
        port(
        EnablePC : IN std_logic;
        input : IN std_logic_vector(15 downto 0);
        clk : IN std_logic;
        output : OUT std_logic_vector(15 downto 0)
        );
    END COMPONENT;

    COMPONENT address_logic
        port (
        PCside , Rside : in std_logic_vector(15 downto 0);
        Iside : in std_logic_vector(7 downto 0);
        ALout : out std_logic_vector(15 downto 0);
        ResetPC, PCplusI, PCplus1, RplusI, Rplus0 : IN std_logic
        );
    END COMPONENT;

    SIGNAL pcout : std_logic_vector (15 DOWNTO 0);
    SIGNAL AddressSignal: std_logic_vector (15 DOWNTO 0);
    BEGIN
			Address <= AddressSignal;
			l1 : pc PORT MAP (EnablePC, AddressSignal, clk, pcout);
			l2 : address_logic PORT MAP (pcout, Rside, Iside, AddressSignal, ResetPC, PCplusI, PCplus1, RplusI, Rplus0);
END dataflow;
