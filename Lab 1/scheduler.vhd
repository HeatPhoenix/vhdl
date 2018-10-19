library ieee;

entity scheduler is
  port (clk: in bit;
	-- TODO is this one single 16 bit_vector value or four 4 bit_vector values?
	op, F1, F2, F3: in bit_vector(3 downto 0););
end entity scheduler;

architecture behaviour of scheduler is
  signal imm: bit_vector(7 downto 0);
	 mem: bit;
begin
  mem <= 0;
  if op(3 downto 0) == "0000" then
    imm <= F2 & F3;
    mem <= 1;
  end if;
  M1: memory(store=>mem, loc=>F1, imm=>imm);
  -- TODO What is the difference in architecture for MEM and REG?
  -- TODO registers need to remember values over multiple clock cycle?

  -- TODO How to transfer ALU values back to registers (within same clock cycle)??
end scheduler;
