library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture behaviour of testbench is
  component full_adder is
    port (A, B, C_in: in std_logic; C, C_out: out std_logic);
  end component;
  signal A, B, C_in, C, C_out : std_logic;
begin
  FA1: full_adder port map (A=>A, B=>B, C_in=>C_in, C=>C, C_out=>C_out);
  A <= '0' after 0 ns, '1' after 20 ns;
  B <= '0' after 0 ns, '1' after 10 ns, '0' after 20 ns, '1' after 30 ns;
  C_in <= '0' after 0 ns, '1' after 5 ns, '0' after 10 ns, '1' after 15 ns, '0' after 20 ns, '1' after 25 ns, '0' after 30 ns, '1' after 35 ns;
end behaviour;