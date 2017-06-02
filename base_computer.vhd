library IEEE;
use IEEE.std_logic_1164.all;

entity base_computer is
    port (
    external_reset, clk : in std_logic
    );
end base_computer;


architecture rtl of base_computer is

    component components
        port (
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
    end component;

    component memory
        port (
        clk,
        readmem,
        writemem : in std_logic;
        addressbus: in std_logic_vector (15 downto 0);
        databus : inout std_logic_vector (15 downto 0);
        memdataready : out std_logic
        );
    end component;

    component port_manager
		port (
		clk, readio, writeio: in std_logic;
		addressbus: in std_logic_vector (15 downto 0);
		databus : inout std_logic_vector (15 downto 0)
		);
    end component;

    signal readmem_signal, writemem_signal, read_io_signal, write_io_signal : std_logic;
	 signal memdataready_signal : std_logic;
    signal addressbus_signal, databus_signal : std_logic_vector(15 downto 0);

    begin

        memory_module : memory port map(
                        clk,
                        readmem_signal,
                        writemem_signal,
                        addressbus_signal,
                        databus_signal,
                        memdataready_signal
                        );

        components_module : components port map(
									 clk,
									 external_reset,
									 memdataready_signal,
									 databus_signal,
									 addressbus_signal,
									 readmem_signal,
									 writemem_signal,
									 read_io_signal,
									 write_io_signal
								    );

		port_manager_module : port_manager port map(
									 clk,
								  	read_io_signal,
								 	write_io_signal,
									addressbus,
									databus
									);

end rtl;
