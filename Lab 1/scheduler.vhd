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
  port (store, clk, en: in bit;
	loc: in bit_vector(3 downto 0);
	imm: in bit_vector(7 downto 0);
	output: out bit_vector(7 downto 0));
  end component;

  signal imm, mem_out: bit_vector(7 downto 0);
  signal mem_loc, reg_d_loc: bit_vector(3 downto 0);
  signal mem_store, mem_en, reg_en: bit;
begin
  scheduler_process: process (clk, op, F1, F2, F3)
  begin
    if(rising_edge(clk)) then
      mem_store <= '0';
      mem_en <= '0';
      if (op(3 downto 0) = "0000") then
	mem_en <= '1';
	mem_loc <= F1;
        imm <= F2 & F3;
        mem_store <= '1';
      end if;
      if (op(3 downto 0) = "0001") then
	mem_en <= '1';
	reg_en <= '1';
	reg_d_loc <= F1;
	mem_loc <= F2;
      end if;
      -- TODO What is the difference in architecture for MEM and REG?
      -- TODO registers need to remember values over multiple clock cycle?
  
      -- TODO How to transfer ALU values back to registers (within same clock cycle)??
    end if;
  end process scheduler_process;
  M1: memory port map(en=>mem_en, store=>mem_store, loc=>mem_loc, clk=>clk, imm=>imm, output=>mem_out);
end behaviour;
