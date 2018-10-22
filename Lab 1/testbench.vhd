library ieee;

entity testbench is
end entity testbench;

architecture behaviour of testbench is
  component scheduler is
    port (clk: in bit;
	  op, F1, F2, F3: in bit_vector(3 downto 0));
  end component;
  component memory is 
    port (store, clk: in bit;
	  loc: in bit_vector(3 downto 0);
          imm: in bit_vector(7 downto 0));
  end component;

  signal F1, F2, F3, op: bit_vector(3 downto 0);
  signal imm: bit_vector(7 downto 0);
  signal store, clk: bit;
begin
  clk_process: process
  begin
	clk <= '1';
	wait for 5 ns;
 	clk <= '0';
	wait for 5 ns;
  end process;
  test_process: process
  begin
-- 0000 - Load immediate F2&F3 into F1
-- 0001 - Store F1 register from F2 memory
-- 0010 - Load F1 register to store in F2 memory
-- 0011 - Add two F2 F3 registers and store in third F1 register
    --store <= '0';
    op <= "0000";
    F1 <= "0000";
    F2 <= "0001";
    F3 <= "0110";
    --if op(3 downto 0) = "0000" then
	--imm <= F2 & F3;
        --store <= '1';
    --end if;
    wait for 10 ns;
    F1 <= "0010";
    wait for 10 ns;
    F1 <= "0100";
    wait for 10 ns;
    F1 <= "1101";
    wait for 10 ns;
    F2 <= "1101";
    op <= "0001";
    wait for 10 ns;
    F2 <= "0010";
    wait for 10 ns;
    F2 <= "1111";
    wait for 10 ns;
  end process;
  S1: scheduler port map(clk=>clk, op=>op, F1=>F1, F2=>F2, F3=>F3);
  --M1: memory port map(store=>store, clk=>clk, loc=>F1, imm=>imm);
  -- TODO What is the difference in architecture for MEM and REG?
  -- TODO registers need to remember values over multiple clock cycle?

  -- TODO How to transfer ALU values back to registers (within same clock cycle)??
end behaviour;
