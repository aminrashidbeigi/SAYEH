library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is
    port(
    input1 : IN std_logic_vector(15 downto 0);
    input2 : IN std_logic_vector(15 downto 0);
    opcode : IN std_logic_vector(3 downto 0);
    cin : IN std_logic;
    zin : in std_logic;
    cout : OUT std_logic;
    zout : OUT std_logic;
    output : OUT std_logic_vector(15 downto 0)
    );
end entity;

architecture structural of alu is
    component and_co
        port(
        and_input1, and_input2 : IN std_logic_vector(15 downto 0);
        and_output : OUT std_logic_vector(15 downto 0)
        );
    end component;

    component or_co
        port(
        or_input1, or_input2 : IN std_logic_vector(15 downto 0);
        or_output : OUT std_logic_vector(15 downto 0)
        );
    end component;

    component right_shift_co
        port(
        right_shift_input : IN std_logic_vector(15 downto 0);
        right_shift_output : OUT std_logic_vector(15 downto 0)
        );
    end component;

    component left_shift_co
        port(
        left_shift_input : IN std_logic_vector(15 downto 0);
        left_shift_output : OUT std_logic_vector(15 downto 0)
        );
    end component;

    component comprator_co
        port(
        comprator_input1, comprator_input2 : IN std_logic_vector(15 downto 0);
        comprator_cout , comprator_zout : OUT std_logic
        );
    end component;

    component adder_co
        port(
        adder_input1, adder_input2 : in STD_LOGIC_VECTOR(15 downto 0);
        adder_cin : in STD_LOGIC;
        adder_output  : out STD_LOGIC_VECTOR(15 downto 0);
        adder_cout : out STD_LOGIC
        );
    end component;

    component subtractor_co
        port(
        subtractor_input1, subtractor_input2 : IN  std_logic_vector(15 DOWNTO 0);
        subtractor_cin : IN std_logic;
        subtractor_output : OUT std_logic_vector (15 DOWNTO 0)
        -- overflow : OUT std_logic
        );
    end component;

    component twos_complement_co
        port(
        twos_complement_input  : IN  std_logic_vector(15 DOWNTO 0);
        twos_complement_output : OUT std_logic_vector (15 DOWNTO 0)
        );
    end component;

    component xor_co
        port(
        xor_input1, xor_input2 : IN std_logic_vector(15 downto 0);
        xor_output : OUT std_logic_vector(15 downto 0)
        );
    end component;

	 component not_co
 		  port(
		  not_input : IN std_logic_vector(15 downto 0);
		  not_output : OUT std_logic_vector(15 downto 0)
		  );
	 end component;

	 component multiplier_co
		 port(
		 A: in STD_LOGIC_VECTOR(15 downto 0);
		 B : in STD_LOGIC_VECTOR(15 downto 0);
		 res : out STD_LOGIC_VECTOR(15 downto 0)
		 );
	 end component;

	 component divider_co
		 port(
		 input1: in STD_LOGIC_VECTOR(15 downto 0);
		 input2 : in STD_LOGIC_VECTOR(15 downto 0);
		 output : out STD_LOGIC_VECTOR(15 downto 0)
		 );
	 end component;

	 component random_generator_co
		port(
		output : OUT std_logic_vector(15 downto 0)
		);
	 end component;

	component sqrt_co
	port (
	input : in std_logic_vector(15 DOWNTO 0);
	output : out std_logic_vector(15 DOWNTO 0)
	);
	end component;

	component sin_co
	port (
	input : in std_logic_vector(15 DOWNTO 0);
	output : out std_logic_vector(15 DOWNTO 0)
	);
	end component;

	component cos_co
	port (
	input : in std_logic_vector(15 DOWNTO 0);
	output : out std_logic_vector(15 DOWNTO 0)
	);
	end component;

	component tan_co
	port (
	input : in std_logic_vector(15 DOWNTO 0);
	output : out std_logic_vector(15 DOWNTO 0)
	);
	end component;

	component cot_co
	port (
	input : in std_logic_vector(15 DOWNTO 0);
	output : out std_logic_vector(15 DOWNTO 0)
	);
	end component;

	signal or_signal, divider_signal, and_signal, adder_signal, random_signal, multiplier_signal, subtractor_signal, xor_signal, twos_complement_signal, left_shift_signal, right_shift_signal, not_signal, sqrt_signal, sin_signal, cos_signal, tan_signal,cot_signal: std_logic_vector(15 downto 0);
   signal adder_cout_signal, comprator_cout_signal : std_logic;
   signal opcode_signal : std_logic_vector(3 downto 0);

	 begin

    and_module : and_co port map (and_input1 => input1, and_input2 => input2, and_output => and_signal);
    or_module : or_co port map (or_input1 => input1, or_input2 => input2, or_output => or_signal);
    G3 : right_shift_co port map (right_shift_input => input1, right_shift_output => right_shift_signal);
    G4 : left_shift_co port map (left_shift_input => input1, left_shift_output => left_shift_signal);
    G5 : comprator_co port map (comprator_input1 => input1, comprator_input2 => input2, comprator_cout => comprator_cout_signal, comprator_zout => zout);
    G6 : adder_co port map (adder_input1 => input1, adder_input2 => input2, adder_cin => cin, adder_output => adder_signal, adder_cout => adder_cout_signal);
    G7 : subtractor_co port map (subtractor_input1 => input1, subtractor_input2 => input2, subtractor_cin => cin, subtractor_output => subtractor_signal);
    G8 : twos_complement_co port map (twos_complement_input => input1, twos_complement_output => twos_complement_signal);
    xor_module : xor_co port map (xor_input1 => input1, xor_input2 => input2, xor_output => xor_signal);
    not_module : not_co port map (input1, not_signal);
	 rand_module : random_generator_co port map (random_signal);
	 multiplier_module : multiplier_co port map(input1, input2, multiplier_signal);
	 divider_module : divider_co port map(input1, input2, divider_signal);
	 sqrt_module : sqrt_co port map(input1, sqrt_signal);
	 sin_module : sin_co port map(input1, sin_signal);
	 cos_module : cos_co port map(input1, cos_signal);
	 tan_module : tan_co port map(input1, tan_signal);
	 cot_module : cot_co port map(input1, cot_signal);



    opcode_signal <= opcode;

		with opcode_signal select
		output <= input1 when "0000",
                and_signal when "0001",
  					 or_signal when "0010",
  					 right_shift_signal when "0011",
  					 left_shift_signal when "0100",
  					 adder_signal when "0101",
  					 subtractor_signal when "0110",
  					 twos_complement_signal when "0111",
  					 xor_signal when "1000",
					 not_signal when "1001",
					 random_signal when "1010",
					 multiplier_signal when "1011",
					 divider_signal when "1100",
					 sqrt_signal when "1101",
					 sin_signal when "1110",
					 cos_signal when "1111",
  					 "0000000000000000" when others;

    with opcode_signal select
    cout <= comprator_cout_signal when "0100",
            adder_cout_signal when "1010",
            '0' when others;

    -- process(opcode_signal) begin
    --   if (opcode_signal = "0000") then
    --       output <= and_signal;
    --   elsif (opcode_signal = "0001") then
    --       output <= or_signal;
    --   elsif (opcode_signal = "0010") then
    --       output <= right_shift_signal;
    --   elsif (opcode_signal = "0011") then
    --       output <= left_shift_signal;
    --   elsif (opcode_signal = "0100") then
    --       cout <= comprator_cout_signal;
    --   elsif (opcode_signal = "0101") then
		-- 	 cout <= adder_cout_signal;
		-- 	 output <= adder_signal;
    --   elsif (opcode_signal = "0110") then
    --       output <= subtractor_signal;
    --   elsif (opcode_signal = "0111") then
    --       output <= twos_complement_signal;
    --   elsif (opcode_signal = "1000") then
    --       output <= xor_signal;
    --   end if; --if
    -- end process ; -- process

    --output <= and_signal;
end structural;
