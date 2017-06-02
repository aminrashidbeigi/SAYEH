library IEEE;
use IEEE.std_logic_1164.all;

entity controller is

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
		rfl_write ,
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
end entity;

architecture rtl of controller is

	type state is (reset_state, fetch_state, decode_state, decode_delay_state, no_operation_state, halt_state, set_zero_state, clear_zero_state, set_carry_state, clear_carry_state ,
		clear_wp_state, move_reg_state, load_address_first_state, enable_pc_state, load_address_second_state, store_address_state, and_state, or_state, not_state, left_shift_state, right_shift_state,
		add_state, sub_state, compare_state, move_immd_low_state, move_immd_high_state, save_pc_state, jump_address_state, jump_relative_state, branch_if_zero_state, branch_if_carry_state,
		wp_add_state, fetch_delay_state);
	signal current_state : state := reset_state;
	signal next_state : state;

	begin
		process (clk, rst)
		begin
				if rst = '1' then
						current_state <= reset_state;
				elsif clk'event and clk = '1' then
						current_state <= next_state;
				end if;
		end process;

		process (current_state)
		begin
			--if (current_state /= after_exe) then
			ResetPC <= '0';
			PCplusI <= '0';
			PCplus1 <= '0';
			rplusI <= '0';
			rplus0 <= '0';
			EnablePC <= '0';
	    	c_set <= '0';
	    	c_reset <= '0';
	    	z_set <= '0';
	    	z_reset <= '0';
	    	sr_load <= '0';
	    	rfl_write <= '0';
	    	rfh_write <= '0';
	    	wp_add <= '0';
	    	wp_reset <= '0';
	    	ir_load <= '0';
	    	address_on_databus <= '0';
	    	aluout_on_databus <= '0';
	    	rs_on_AddressUnitRSide <= '0';
	    	rd_on_AddressUnitRSide <= '0';
	    	ReadMem <= '0';
	    	WriteMem <= '0';
				alu_opcode <= "1111";
			--end if ;

			case current_state is

				when reset_state =>
						ResetPC <= '1';
						EnablePC <= '1';
						c_reset <= '1';
						z_reset <= '1';
						wp_reset <= '1';
						next_state <= fetch_state;

				when fetch_state =>
						ReadMem <= '1';
						ir_load <= '1';
						next_state <= fetch_delay_state;

				when fetch_delay_state =>
						ReadMem <= '1';
						ir_load <= '1';
						next_state <= decode_state;

				when decode_state =>
						next_state <= decode_delay_state;

				when decode_delay_state =>
					if (ir_in(15 downto 8) = "00000000") then --nop
							next_state <= no_operation_state;
					elsif (ir_in(15 downto 8) = "00000001") then --hlt
							next_state <= halt_state;
					elsif (ir_in(15 downto 8) = "00000010") then --szf
							next_state <= set_zero_state;
					elsif (ir_in(15 downto 8) = "00000011") then --czf
							next_state <= clear_zero_state;
					elsif (ir_in(15 downto 8) = "00000100") then --scf
							next_state <= set_carry_state;
					elsif (ir_in(15 downto 8) = "00000101") then --ccf
							next_state <= clear_carry_state;
					elsif (ir_in(15 downto 8) = "00000110") then --cwp
							next_state <= clear_wp_state;
					elsif (ir_in(15 downto 8) = "00001010") then
							next_state <= wp_add_state;--awp
					elsif (ir_in(15 downto 12) = "0001") then
							next_state <= move_reg_state;--mvr
					elsif (ir_in(15 downto 12) = "0010") then
							next_state <= load_address_first_state;--lda
					elsif (ir_in(15 downto 12) = "0011") then
							next_state <= store_address_state;--sta
					elsif (ir_in(15 downto 12) = "0110") then --and
							next_state <= and_state;
					elsif (ir_in(15 downto 12) = "0111") then --orr
							next_state <= or_state;
					elsif (ir_in(15 downto 12) = "1000") then --not
							next_state <= not_state;
					elsif (ir_in(15 downto 12) = "1001") then --shl
							next_state <= left_shift_state;
					elsif (ir_in(15 downto 12) = "1010") then --shr
							next_state <= right_shift_state;
					elsif (ir_in(15 downto 12) = "1011") then --add
							next_state <= add_state;
					elsif (ir_in(15 downto 12) = "1100") then --sub
							next_state <= sub_state;
					elsif (ir_in(15 downto 12) = "1110") then --cmp
							next_state <= compare_state;
					elsif (ir_in(15 downto 12) = "1111" and ir_in(9 downto 8) = "00") then
							next_state <= move_immd_low_state;--mil
					elsif (ir_in(15 downto 12) = "1111" and ir_in(9 downto 8) = "01") then
							next_state <= move_immd_high_state;--mih
					elsif (ir_in(15 downto 12) = "1111" and ir_in(9 downto 8) = "10") then
							next_state <= save_pc_state;--spc
					elsif (ir_in(15 downto 12) = "1111" and ir_in(9 downto 8) = "11") then
							next_state <= jump_address_state;--jpa
					elsif (ir_in(15 downto 8) = "00000111") then
							next_state <= jump_relative_state;--jpr
					elsif (ir_in(15 downto 8) = "00001000") then
							next_state <= branch_if_zero_state;--brz
					elsif (ir_in(15 downto 8) = "00001001") then
							next_state <= branch_if_carry_state;--brc
					end if ;

				when no_operation_state =>
						PCplus1 <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when halt_state =>
				if (rst = '1') then
					next_state <= fetch_state;
					else
						next_state <= halt_state;
				end if;

				when set_zero_state =>
						z_set <= '1';
						PCplus1 <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when clear_zero_state =>
						z_reset <= '1';
						PCplus1 <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when set_carry_state =>
						c_set <= '1';
						PCplus1 <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when clear_carry_state =>
						c_reset <= '1';
						PCplus1 <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when clear_wp_state =>
						wp_reset <= '1';
						PCplus1 <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when wp_add_state =>
						wp_add <= '1';
						PCplus1 <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when move_reg_state =>
						alu_opcode <= "0000";
						aluout_on_databus <= '1';
						rfl_write <= '1';
						rfh_write <= '1';
						PCplus1 <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when load_address_first_state =>
						rs_on_AddressUnitRSide <= '1';
						rplus0 <= '1';
						ReadMem <= '1';
						next_state <= load_address_second_state;

				when load_address_second_state =>
						ReadMem <= '1';
						rfl_write <= '1';
						rfh_write <= '1';
						next_state <= enable_pc_state;

				when store_address_state =>
						alu_opcode <= "0000";
						aluout_on_databus <= '1';
						rd_on_AddressUnitRSide <= '1';
						rplus0 <= '1';
						WriteMem <= '1';
						next_state <= enable_pc_state;

				when enable_pc_state =>
						PCplus1 <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when and_state =>
						alu_opcode <= "0001";
						aluout_on_databus <= '1';
						rfl_write <= '1';
						rfh_write <= '1';
						PCplus1 <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when or_state =>
						alu_opcode <= "0010";
						aluout_on_databus <= '1';
						rfl_write <= '1';
						rfh_write <= '1';
						PCplus1 <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when not_state =>
						alu_opcode <= "1001";
						aluout_on_databus <= '1';
						rfl_write <= '1';
						rfh_write <= '1';
						PCplus1 <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when left_shift_state =>
						alu_opcode <= "0100";
						aluout_on_databus <= '1';
						rfl_write <= '1';
						rfh_write <= '1';
						PCplus1 <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when right_shift_state =>
						alu_opcode <= "0011";
						aluout_on_databus <= '1';
						rfl_write <= '1';
						rfh_write <= '1';
						PCplus1 <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when add_state =>
						alu_opcode <= "0101";
						aluout_on_databus <= '1';
						sr_load <= '1';
						rfl_write <= '1';
						rfh_write <= '1';
						PCplus1 <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when sub_state =>
						alu_opcode <= "0110";
						aluout_on_databus <= '1';
						sr_load <= '1';
						rfl_write <= '1';
						rfh_write <= '1';
						PCplus1 <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when compare_state =>
						alu_opcode <= "0100";
						sr_load <= '1';
						PCplus1 <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when move_immd_low_state =>
						rplusI <= '1';
						address_on_databus <= '1';
						rfl_write <= '1';
						next_state <= enable_pc_state;

				when move_immd_high_state =>
						rplusI <= '1';
						address_on_databus <= '1';
						rfh_write <= '1';
						next_state <= enable_pc_state;

				when save_pc_state =>
						PCplusI <= '1';
						address_on_databus <= '1';
						rfh_write <= '1';
						rfl_write <= '1';
						next_state <= enable_pc_state;

				when jump_address_state =>
						rd_on_AddressUnitRSide <= '1';
						rplusI <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when jump_relative_state =>
						PCplusI <= '1';
						EnablePC <= '1';
						next_state <= fetch_state;

				when branch_if_zero_state =>
						if (Zin = '1') then
								PCplusI <= '1';
								EnablePC <= '1';
								next_state <= fetch_state;
						else
								PCplus1 <= '1';
								EnablePC <= '1';
								next_state <= fetch_state;
					end if ;

				when branch_if_carry_state =>
						if (Cin = '1') then
								PCplusI <= '1';
								EnablePC <= '1';
								next_state <= fetch_state;
						else
								PCplus1 <= '1';
								EnablePC <= '1';
								next_state <= fetch_state;
						end if ;

				when others =>
					next_state <= fetch_state;
			end case;
		end process;
end architecture;
