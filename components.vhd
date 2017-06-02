library IEEE;
use IEEE.std_logic_1164.all;

entity components is
    port(
    clk : in std_logic;
    external_reset : in std_logic;
    mem_data_ready : in std_logic;
    databus: inout std_logic_vector(15 downto 0);
    ir_out : out std_logic_vector(15 downto 0);
    read_mem : out std_logic;
    write_mem : out std_logic;
    read_io : out std_logic;
    write_io : out std_logic
    );
end components;


architecture rtl of components is

  component controller
      port (
      -- databus : inout std_logic_vector(15 DOWNTO 0);
      --au
      ResetPC,
      PCplusI,
      PCplus1 ,
      RplusI,
      Rplus0,
      EnablePC,
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
      rfl_write,
      rfh_write ,
      Shadow : out std_logic;
      --alu
      alu_opcode : out std_logic_vector(3 downto 0);
      --mem
      memAddress : out std_logic_vector(15 DOWNTO 0);
      --outputs
      readmem,
      writemem : out std_logic;
      clk,
      zin ,
      cin,
      rst : in std_logic;
      ir_in : in std_logic_vector(15 downto 0)
      );
  end component;

  component datapath
      port (
      databus : inout std_logic_vector(15 DOWNTO 0);
      --au
      ResetPC,
      PCplusI,
      PCplus1,
      RplusI,
      Rplus0,
      EnablePC,
      clk,
      --ir
      ir_load,
      --wp
      wp_add,
      wp_reset,
      --flags
      c_set,
      c_reset,
      z_set,
      z_reset,
      sr_load,
      --tristates
      rd_on_AddressUnitRSide,
      rs_on_AddressUnitRSide,
      address_on_databus,
      aluout_on_databus,
      --rf
      rfl_write,
      rfh_write,
      Shadow : IN std_logic;
      --alu
      alu_opcode : in std_logic_vector(3 downto 0);
      --mem
      memAddress : OUT std_logic_vector(15 DOWNTO 0);
      --outputs
      Zout,
      Cout : OUT std_logic;
      ir_out_dp : OUT std_logic_vector(15 downto 0)
      );
  end component;

    signal c_set_signal, readmem_signal,writemem_signal,zout_signal , cout_signal , c_reset_signal, z_set_signal, z_reset_signal,sr_load_signal, ResetPC_signal, PCplusI_signal, PCplus1_signal, RplusI_signal, Rplus0_signal, EnablePC_signal,
          ir_load_signal,rst_signal, wp_add_signal, wp_reset_signal, rfl_write_signal ,rd_on_AddressUnitRSide_signal , rs_on_AddressUnitRSide_signal , address_on_databus_signal , aluout_on_databus_signal, rfh_write_signal , Shadow_signal : std_logic;
    signal ir_signal, memAddress_signal : std_logic_vector(15 downto 0);
    signal alu_opcode_signal : std_logic_vector(3 downto 0);

    begin
      controller_module : controller port map (
          ResetPC_signal,
          PCplusI_signal,
          PCplus1_signal ,
          RplusI_signal,
          Rplus0_signal,
          EnablePC_signal,
          ir_load_signal,
          wp_add_signal ,
          wp_reset_signal,
          c_set_signal ,
          c_reset_signal ,
          z_set_signal ,
          z_reset_signal ,
          sr_load_signal,
          rd_on_AddressUnitRSide_signal ,
          rs_on_AddressUnitRSide_signal ,
          address_on_databus_signal ,
          aluout_on_databus_signal ,
          rfl_write_signal ,
          rfh_write_signal ,
          Shadow_signal,
          alu_opcode_signal,
          memAddress_signal,
          readmem_signal,
          writemem_signal,
          clk,
          zout_signal ,
          cout_signal,
          rst_signal,
          ir_signal
      );

		datapath_module : datapath port map (
        databus,
        ResetPC_signal,
        PCplusI_signal,
        PCplus1_signal ,
        RplusI_signal,
        Rplus0_signal,
        EnablePC_signal ,
        clk,
        ir_load_signal,
        wp_add_signal,
        wp_reset_signal,
        c_set_signal ,
        c_reset_signal ,
        z_set_signal ,
        z_reset_signal ,
        sr_load_signal,
        rd_on_AddressUnitRSide_signal ,
        rs_on_AddressUnitRSide_signal ,
        address_on_databus_signal ,
        aluout_on_databus_signal ,
        rfl_write_signal ,
        rfh_write_signal ,
        Shadow_signal,
        alu_opcode_signal,
        memAddress_signal ,
        Zout_signal ,
        Cout_signal,
        ir_signal
		);

    read_mem <= readmem_signal;
    write_mem <= writemem_signal;
    ir_out <= ir_signal;
end rtl;
