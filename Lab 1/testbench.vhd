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
	clk <= '0';
	wait for 5 ns;
 	clk <= '1';
	wait for 5 ns;
  end process;
  test_process: process
  begin
    store <= '0';
    op <= "0000";
    if op(3 downto 0) = "0000" then
	imm <= F2 & F3;
        store <= '1';
    end if;
    wait for 5 ns;
  end process;
  S1: scheduler port map(clk=>clk, op=>op, F1=>F1, F2=>F2, F3=>F3);
  M1: memory port map(store=>store, clk=>clk, loc=>F1, imm=>imm);
  -- TODO What is the difference in architecture for MEM and REG?
  -- TODO registers need to remember values over multiple clock cycle?

  -- TODO How to transfer ALU values back to registers (within same clock cycle)??
end behaviour;