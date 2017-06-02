library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
    port (
    databus : inout std_logic_vector(15 DOWNTO 0);
    --au
    ResetPC,
    PCplusI,
    PCplus1 ,
    RplusI,
    Rplus0,
    EnablePC ,
    clk,
    --ir
    ir_load,
    --wp
    wp_add ,
    wp_reset,
    --flags
    c_set ,
    c_reset ,
    z_set ,
    z_reset ,
    sr_load,
    --tristates
    rd_on_AddressUnitRSide ,
    rs_on_AddressUnitRSide ,
    address_on_databus ,
    aluout_on_databus ,
    --rf
    rfl_write ,
    rfh_write ,
    Shadow : IN std_logic;
    --alu
    alu_opcode : in std_logic_vector(3 downto 0);
    --mem
    memAddress : OUT std_logic_vector(15 DOWNTO 0);
    --outputs
    Zout ,
    Cout : OUT std_logic;
    ir_out_dp : OUT std_logic_vector(15 downto 0)
    );
end datapath;

architecture rtl of datapath is
    component alu
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
    end component;

    component register_file
        port(
        databus_in : in std_logic_vector(15 downto 0);
        wp_in : in std_logic_vector(5 downto 0);
        shadow_in : in std_logic_vector(3 downto 0);
        rfl_write : in std_logic;
        rfh_write : in std_logic;
        clk : in  std_logic;
        rs : out std_logic_vector(15 downto 0);
        rd : out std_logic_vector(15 downto 0)
        );
    end component;

    component flags
        port(
        cin : IN std_logic;
        zin : IN std_logic;
        clk : IN std_logic;
        c_set : IN std_logic;
        c_reset : IN std_logic;
        z_set : IN std_logic;
        z_reset : IN std_logic;
        sr_load : IN std_logic;
        cout : OUT std_logic;
        zout : OUT std_logic
        );
    end component;

    component wp
        port(
        ir_out : IN std_logic_vector(5 downto 0);
        wp_add : IN std_logic;
        wp_reset : IN std_logic;
        clk : IN std_logic;
        wp_out: OUT std_logic_vector(5 downto 0)
        );
    end component;

    component ir
        port(
        ir_in : IN std_logic_vector(15 downto 0);
        ir_load : IN std_logic;
        clk : IN std_logic;
        ir_out: OUT std_logic_vector(15 downto 0)
        );
    end component;

    component au
        PORT (
        Rside : IN std_logic_vector (15 DOWNTO 0);
        Iside : IN std_logic_vector (7 DOWNTO 0);
        Address : OUT std_logic_vector (15 DOWNTO 0);
        clk, ResetPC, PCplusI, PCplus1 : IN std_logic;
        RplusI, Rplus0, EnablePC : IN std_logic
        );
  	end component;

    component tristate
        port (
        input    : in  std_logic_vector(15 downto 0);
        EN   : in  STD_LOGIC;
        output    : out std_logic_vector(15 downto 0)
        );
    end component;

    signal alu_cout_signal : std_logic;
    signal alu_zout_signal : std_logic;
    signal alu_output_signal : std_logic_vector(15 downto 0);
    signal flags_cout_signal : std_logic;
    signal flags_zout_signal : std_logic;
    signal wp_out_signal : std_logic_vector(5 downto 0);
    signal ir_out_signal: std_logic_vector(15 downto 0);
    signal rs_signal: std_logic_vector(15 downto 0);
    signal rd_signal: std_logic_vector(15 downto 0);
    signal alu_opcode_signal : std_logic_vector(3 downto 0);
    signal address_unit_r_side_bus : std_logic_vector(15 downto 0);
    signal address_unit_output_signal : std_logic_vector(15 downto 0);

    begin
        alu_module : alu port map(rs_signal, rd_signal, alu_opcode,flags_cout_signal, flags_zout_signal, alu_cout_signal, alu_zout_signal, alu_output_signal);
        flags_module : flags port map(alu_cout_signal, alu_zout_signal, clk, c_set, c_reset, z_set, z_reset, sr_load, flags_cout_signal, flags_zout_signal);
        wp_module : wp port map(ir_out_signal(5 downto 0), wp_add, wp_reset, clk, wp_out_signal);
        register_file_module : register_file port map(databus, wp_out_signal, ir_out_signal(11 downto 8), rfl_write, rfh_write, clk, rs_signal, rd_signal);
        ir_module : ir port map(databus, ir_load, clk, ir_out_signal);
        au_module : au port map(address_unit_r_side_bus, ir_out_signal(7 DOWNTO 0), memaddress, clk , ResetPC, PCplusI, PCplus1, RplusI, Rplus0, EnablePC);
        address_on_databus_module : tristate port map(ir_out_signal, address_on_databus, databus);
        aluout_on_databus_module : tristate port map(alu_output_signal, aluout_on_databus, databus);
        rd_on_AddressUnitRSide_module : tristate port map(rd_signal, rd_on_AddressUnitRSide, address_unit_r_side_bus);
        rs_on_AddressUnitRSide_module : tristate port map(rs_signal, rs_on_AddressUnitRSide, address_unit_r_side_bus);


		  ir_out_dp <= ir_out_signal;
        zout <= flags_zout_signal;
        cout <= flags_cout_signal;

end rtl;
