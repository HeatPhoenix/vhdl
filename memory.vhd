library ieee;

entity memory is
  port (store: in bit;
	loc: in bit_vector(3 downto 0);
	imm: in bit_vector(7 downto 0);
	output: out bit_vector(7 downto 0));
	-- TODO need clock?
end entity memory;

architecture behaviour of memory is
begin
 -- TODO add memory declarations
end memory;
