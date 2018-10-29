library ieee;

-- OP CODES:
-- 0000 - Load immediate
-- 0001 - Store register from memory
-- 0010 - Load register to store in memory
-- 0011 - Add two registers and store in third register

entity scheduler is
  port (clk: in bit;
	-- TODO is this one single 16 bit_vector value or four 4 bit_vector values?
	op, F1, F2, F3: in bit_vector(3 downto 0));
end entity scheduler;

architecture behaviour of scheduler is
  component memory is
  port (store, en, store_reg: in bit;
	loc: in bit_vector(3 downto 0);
	imm, reg_input: in bit_vector(7 downto 0);
	output: out bit_vector(7 downto 0));
  end component;
  component registers is
  port (store, en, output: in bit;
	loc, loc_s, loc_t: in bit_vector(3 downto 0);
	mem_input, alu_input: in bit_vector(7 downto 0);
	output_s, output_t, output_d: out bit_vector(7 downto 0));
  end component;
  component alu is
  port (en: bit;
	S, T: in bit_vector(7 downto 0);
	D: out bit_vector(7 downto 0));
  end component;
  signal imm, mem_out, alu_out, reg_input, reg_out_d, reg_out_s, reg_out_t: bit_vector(7 downto 0);
  signal mem_loc, reg_d_loc, reg_s_loc, reg_t_loc: bit_vector(3 downto 0);
  signal mem_store, mem_store_reg, mem_en, reg_store, reg_load, reg_en, alu_en: bit;
begin
  scheduler_process: process (clk, op, F1, F2, F3)
  begin
    if(rising_edge(clk)) then
      mem_store <= '0';
      mem_en <= '0';
      reg_store <= '0';
      reg_en <= '0';
      reg_load <= '0';
      alu_en <= '0';
      if (op(3 downto 0) = "0000") then -- Load imm
	mem_en <= '1';
	mem_loc <= F1;
        imm(7 downto 4) <= F2;
	imm(3 downto 0) <= F3;
        mem_store <= '1';
      end if;
      if (op(3 downto 0) = "0001") then -- Store register from memory
	mem_en <= '1';
	reg_en <= '1';
      	reg_store <= '1';
	reg_d_loc <= F1;
	mem_loc <= F2;
      end if;
      if (op(3 downto 0) = "0010") then -- Store register from memory
	mem_en <= '1';
	reg_en <= '1';
        mem_store_reg <= '1';
	reg_load <= '1';
	reg_d_loc <= F1;
	mem_loc <= F2;
      end if;
      if (op(3 downto 0) = "0011") then -- Add reg_s with reg_t and store in reg_d
	reg_en <= '1';
	alu_en <= '1';
	reg_d_loc <= F1;
        reg_s_loc <= F2;
        reg_t_loc <= F3;
      end if;
      -- TODO What is the difference in architecture for MEM and REG?
      -- TODO registers need to remember values over multiple clock cycle?
  
      -- TODO How to transfer ALU values back to registers (within same clock cycle)??
    end if;
  end process scheduler_process;
  M1: memory port map(en=>mem_en, store=>mem_store, store_reg=>mem_store_reg, loc=>mem_loc, imm=>imm, output=>mem_out, reg_input=>reg_out_d); 
  R1: registers port map(en=>reg_en, store=>reg_store, output=>reg_load, loc=>reg_d_loc, loc_s=>reg_s_loc, loc_t=>reg_t_loc, mem_input=>mem_out, alu_input=>alu_out, output_d=>reg_out_d, output_s=>reg_out_s, output_t=>reg_out_t);
  A1: alu port map(en=>alu_en, S=>reg_out_s, T=>reg_out_t, D=>alu_out);
end behaviour;
