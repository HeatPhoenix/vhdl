library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture behaviour of testbench is
  component latched_adder is
    port (A, B, C_in, clk, reset: in std_logic; CQ, CQbar, CoutQ, CoutQbar: out std_logic);
  end component;
  signal A, B, C_in, clk, reset, CQ, CQbar, CoutQ, CoutQbar : std_logic;
begin
  LA1: latched_adder port map (A=>A, B=>B, C_in=>C_in, clk=>clk, reset=>reset, CQ=>CQ, CQbar=>CQbar, CoutQ=>CoutQ, CoutQbar=>CoutQbar);
  A <= '0' after 0 ns, '1' after 20 ns;
  B <= '0' after 0 ns, '1' after 10 ns, '0' after 20 ns, '1' after 30 ns;
  C_in <= '0' after 0 ns, '1' after 5 ns, '0' after 10 ns, '1' after 15 ns, '0' after 20 ns, '1' after 25 ns, '0' after 30 ns, '1' after 35 ns;
  clk <= '1' after 1 ns, '0' after 3 ns, '1' after 6 ns, '0' after 8 ns, '1' after 11 ns, '0' after 13 ns, '1' after 16 ns, '0' after 18 ns, '1' after 21 ns, '0' after 23 ns, '1' after 26 ns, '0' after 28 ns, '1' after 31 ns, '0' after 33 ns, '1' after 36 ns;
  reset <= '0' after 0 ns, '1' after 17 ns, '0' after 20 ns;
end behaviour;