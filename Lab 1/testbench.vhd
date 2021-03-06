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
-- 0000 - Load immediate F2&F3 into F1
-- 0001 - Store F1 register from F2 memory
-- 0010 - Load F1 register to store in F2 memory
-- 0011 - Add two F2 F3 registers and store in third F1 register
    op <= "0000"; -- store 1 to mem 0
    F1 <= "0000";
    F2 <= "0000";
    F3 <= "0001";
    wait for 10 ns;
    F1 <= "0001"; -- store 3 to mem 1
    F3 <= "0011";
    wait for 10 ns;
    F1 <= "0010"; -- store 7 to mem 2
    F3 <= "0111";
    wait for 10 ns;
    F1 <= "0011"; -- store 15 to mem 3
    F3 <= "1111";
    wait for 10 ns;
    F1 <= "0100"; -- store 4 to mem 4
    F3 <= "0100";
    wait for 10 ns;
    F1 <= "0101";
    F2 <= "0100";
    wait for 10 ns;
    F1 <= "0110";
    wait for 10 ns;
    F1 <= "0111";
    wait for 10 ns;
    F1 <= "1000";
    wait for 10 ns;
    F1 <= "1001";
    wait for 10 ns; -- 100ns
    F1 <= "1010";
    wait for 10 ns;
    F1 <= "1011";
    wait for 10 ns;
    F1 <= "1100";
    wait for 10 ns;
    F1 <= "1101";
    wait for 10 ns;
    F1 <= "1110";
    wait for 10 ns;
    F1 <= "1111";
    wait for 10 ns;
    F2 <= "1101";-- store mem 13 to reg 13
    op <= "0001";
    wait for 10 ns;
    F1 <= "0100";-- store mem 2 to reg 4
    F2 <= "0010";
    wait for 10 ns;
    F1 <= "0001";-- store mem 15 to reg 1
    F2 <= "1111";
    wait for 10 ns;
    F1 <= "0010";-- store mem 4 to reg 2
    F2 <= "0100";
    wait for 10 ns; -- 200 ns
    op <= "0010";
    F1 <= "0010";-- store reg 2 to mem 0
    F2 <= "0000";
    wait for 10 ns;
    op <= "0011";
    F1 <= "0111";-- add reg 2 to reg 4 and store in reg 7
    F2 <= "0010";
    F3 <= "0100";
    wait for 10 ns;
    op <= "0010";
    F1 <= "0010";-- store reg 7 to mem 15
    F2 <= "1111";
    wait for 300 ns;
    op <= "0000"; -- store imm 11 to mem 0
    F1 <= "0000";
    F2 <= "1011";
    F3 <= "0000";
    wait for 10 ns;
    op <= "0001"; -- load mem 0 to register 8
    F1 <= "1000";
    F2 <= "0000";
    F3 <= "0000";
    wait for 10 ns; -- 250ns
    op <= "0011"; -- add mem 8 to mem 7 -> mem 9
    F1 <= "1001";
    F2 <= "1000";
    F3 <= "0111";
    wait for 1000 ns;
  end process;
  S1: scheduler port map(clk=>clk, op=>op, F1=>F1, F2=>F2, F3=>F3);
  --M1: memory port map(store=>store, clk=>clk, loc=>F1, imm=>imm);
  -- TODO What is the difference in architecture for MEM and REG?
  -- TODO registers need to remember values over multiple clock cycle?

  -- TODO How to transfer ALU values back to registers (within same clock cycle)??
end behaviour;
